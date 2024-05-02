import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_repository/news_repository.dart';
import 'package:quickbytes_app/features/notifications/domain/repositories/notification_service.dart';

part 'news_category_state.dart';

class NewsCategoryCubit extends Cubit<NewsCategoryState> {
  NewsCategoryCubit({required NewsRepository newsRepository})
      : _newsRepository = newsRepository,
        super(NewsCategoryStateInitial());

  final NewsRepository _newsRepository;

  void queryAllCategories() async {
    emit(NewsCategoryStateLoading());

    List<NewsCategory> allCategories =
        await _newsRepository.queryAllCategories();
    List<NewsCategory> userCategories =
        await _newsRepository.queryUserCategories(
      allCategories: allCategories,
    );

    _handleInitialSubscription(userCategories: userCategories);

    emit(NewsCategoryStateLoaded(
      allCategories: allCategories,
      userCategories: userCategories,
    ));
  }

  /// When the app completes loading, we will subscribe their categories to FCM
  /// This becomes particularly handy when the app is launched for the first time
  /// and we want users to be subscribed to the default notification categories.
  void _handleInitialSubscription(
      {required List<NewsCategory> userCategories}) {
    for (NewsCategory category in userCategories) {
      if (!category.isNone) {
        NotificationService.instance.subscribeToTopic(category.name);
      }
    }
  }

  void _handleNotificationSubscription({
    required List<NewsCategory> userSelectedCategories,
  }) async {
    if (state is NewsCategoryStateLoaded) {
      List<NewsCategory> currentUserCategories =
          (state as NewsCategoryStateLoaded).userCategories;

      emit((state as NewsCategoryStateLoaded)
          .copyWith(userCategories: List.from(userSelectedCategories)));

      // news categories to remove
      List<NewsCategory> categoriesToRemove = currentUserCategories
          .where((category) =>
              !category.isNone && !userSelectedCategories.contains(category))
          .toList();

      for (NewsCategory category in categoriesToRemove) {
        NotificationService.instance.unsubscribeFromTopic(category.name);
      }

      // news categories to add
      List<NewsCategory> categoriesToAdd = userSelectedCategories
          .where((category) =>
              !category.isNone && !currentUserCategories.contains(category))
          .toList();

      for (NewsCategory category in categoriesToAdd) {
        NotificationService.instance.subscribeToTopic(category.name);
      }
    }
  }

  Future<void> updateUserCategories(List<NewsCategory> newsCategories) async {
    try {
      _handleNotificationSubscription(userSelectedCategories: newsCategories);
      // await _newsRepository.saveCategories(newsCategories);
    } catch (e) {
      if (e is SaveNewsCategoryException) {
        print(e.message);
      }
    }
  }
}
