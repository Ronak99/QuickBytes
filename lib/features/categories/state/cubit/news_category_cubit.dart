import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_repository/news_repository.dart';
import 'package:quickbytes_app/features/notifications/domain/repositories/notification_service.dart';

part 'news_category_state.dart';

class CategoryChange {
  List<NewsCategory> categoriesAdded;
  List<NewsCategory> categoriesRemoved;

  CategoryChange({
    required this.categoriesRemoved,
    required this.categoriesAdded,
  });
}

class NewsCategoryCubit extends Cubit<NewsCategoryState> {
  NewsCategoryCubit({required NewsRepository newsRepository})
      : _newsRepository = newsRepository,
        super(NewsCategoryStateInitial());

  final NewsRepository _newsRepository;

  Future<void> queryAllCategories() async {
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
  void _handleInitialSubscription({
    required List<NewsCategory> userCategories,
  }) {
    for (NewsCategory category in userCategories) {
      if (!category.isNone) {
        NotificationService.instance.subscribeToTopic(category.name);
      }
    }
  }

  CategoryChange calculateChange({
    required List<NewsCategory> userSelectedCategories,
    required List<NewsCategory> currentUserCategories,
  }) {
    emit((state as NewsCategoryStateLoaded)
        .copyWith(userCategories: List.from(userSelectedCategories)));

    // news categories to remove
    List<NewsCategory> categoriesToRemove = currentUserCategories
        .where((category) =>
            !category.isNone && !userSelectedCategories.contains(category))
        .toList();

    // news categories to add
    List<NewsCategory> categoriesToAdd = userSelectedCategories
        .where((category) =>
            !category.isNone && !currentUserCategories.contains(category))
        .toList();

    return CategoryChange(
      categoriesRemoved: categoriesToRemove,
      categoriesAdded: categoriesToAdd,
    );
  }

  void _handleNotificationSubscription({required CategoryChange change}) async {
    for (NewsCategory category in change.categoriesRemoved) {
      NotificationService.instance.unsubscribeFromTopic(category.name);
    }

    for (NewsCategory category in change.categoriesAdded) {
      NotificationService.instance.subscribeToTopic(category.name);
    }
  }

  Future<CategoryChange?> updateUserCategories(
      List<NewsCategory> newsCategories) async {
    if (state is NewsCategoryStateLoaded) {
      try {
        CategoryChange changeInCategories = calculateChange(
          userSelectedCategories: newsCategories,
          currentUserCategories:
              (state as NewsCategoryStateLoaded).userCategories,
        );

        _handleNotificationSubscription(change: changeInCategories);

        await _newsRepository.saveCategories(newsCategories);

        return changeInCategories;
      } catch (e) {
        if (e is SaveNewsCategoryException) {
          print(e.message);
        }
      }
    }
    return null;
  }
}
