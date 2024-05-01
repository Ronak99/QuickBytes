import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_repository/news_repository.dart';

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

    emit(NewsCategoryStateLoaded(
      allCategories: allCategories,
      userCategories: userCategories,
    ));
  }
}
