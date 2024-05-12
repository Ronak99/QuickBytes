import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_repository/news_repository.dart';

import 'package:quickbytes_app/features/categories/state/cubit/news_category_cubit.dart';
import 'package:quickbytes_app/features/news/state/news_bloc.dart';
import 'package:quickbytes_app/features/settings/state/bloc/settings_bloc.dart';
import 'package:quickbytes_app/shared/utils/constants.dart';
import 'package:quickbytes_app/shared/utils/utils.dart';

class UserPreferencesPage extends StatelessWidget {
  const UserPreferencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Your Preferences',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 12),
            const PreferenceIndexView(),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: ColorConstants.primaryDarkestDark,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: BlocBuilder<NewsCategoryCubit, NewsCategoryState>(
                  builder: (context, state) {
                    if (state is NewsCategoryStateLoaded) {
                      return ListViewBuilder(
                        allCategories:
                            state.getCategoriesByLabel(state.allCategories),
                        userCategories: state.userCategories,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                final settingsBloc = context.read<SettingsBloc>();
                final newsCategoryCubit = context.read<NewsCategoryCubit>();
                final newsBloc = context.read<NewsBloc>();

                final categories = settingsBloc.state.selectedCategoryList;
                CategoryChange? change =
                    await newsCategoryCubit.updateUserCategories(categories);

                if (change != null) {
                  newsBloc.add(
                    NewsEventUserCategoriesChanged(
                      categoriesAdded: change.categoriesAdded,
                      categoriesRemoved: change.categoriesRemoved,
                    ),
                  );
                }

                Utils.showSnackbar(message: "Categories Updated!!!");
              },
              child: Container(
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListViewBuilder extends StatefulWidget {
  final Map<String, List<NewsCategory>> allCategories;
  final List<NewsCategory> userCategories;

  const ListViewBuilder({
    Key? key,
    required this.allCategories,
    required this.userCategories,
  }) : super(key: key);

  @override
  State<ListViewBuilder> createState() => _ListViewBuilderState();
}

class _ListViewBuilderState extends State<ListViewBuilder> {
  @override
  void initState() {
    super.initState();

    context.read<SettingsBloc>().add(
          IntializeCategoryListRequested(
              newsCategoryList: widget.userCategories),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: widget.allCategories.length,
          padding: const EdgeInsets.symmetric(vertical: 12),
          itemBuilder: (context, index) {
            MapEntry<String, List<NewsCategory>> categoryMap =
                widget.allCategories.entries.elementAt(index);

            if (state.selectedCategoryList.isEmpty) {
              return const SizedBox.shrink();
            }

            return CategoryListItem(
              categoryName: categoryMap.key,
              categoryTypes: categoryMap.value,
              selectedCategory: state.selectedCategoryList[index],
              onCategorySelect: (selectedNewsCategory) {
                context.read<SettingsBloc>().add(
                      NewsCategorySelected(newsCategory: selectedNewsCategory),
                    );
              },
            );
          },
        );
      },
    );
  }
}

class CategoryListItem extends StatelessWidget {
  final String categoryName;
  final NewsCategory selectedCategory;
  final List<NewsCategory> categoryTypes;
  final Function(NewsCategory) onCategorySelect;

  const CategoryListItem({
    Key? key,
    required this.categoryName,
    required this.selectedCategory,
    required this.onCategorySelect,
    required this.categoryTypes,
  }) : super(key: key);

  Widget selectionView({required NewsCategory category}) {
    Color color = Colors.red;

    switch (category.relevancy) {
      case Relevancy.all:
        color = Colors.green;
      case Relevancy.major:
        color = Colors.yellow;
      default:
        color = Colors.red;
    }

    return PreferenceCircle(
      onTap: () {
        onCategorySelect(category);
      },
      isSelected: selectedCategory == category,
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 25,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              categoryName,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...categoryTypes.map(
                  (e) => selectionView(category: e),
                ),
                selectionView(
                  category: categoryTypes[0].copyWith(
                    relevancy: Relevancy.none,
                    name: "${categoryTypes[0].name.split('_')[0]}_none",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PreferenceCircle extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;
  final bool isSelected;
  const PreferenceCircle({
    Key? key,
    required this.onTap,
    required this.color,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double preferenceCircleRadius = 25;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Container(
          height: preferenceCircleRadius,
          width: preferenceCircleRadius,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: Border.all(
              color: isSelected ? Colors.blue : Colors.transparent,
              width: 1,
            ),
          ),
          padding: const EdgeInsets.all(4),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}

class PreferenceIndexView extends StatelessWidget {
  const PreferenceIndexView({super.key});

  @override
  Widget build(BuildContext context) {
    Widget indexItem({required String text, required Color color}) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PreferenceCircle(
            onTap: () {},
            color: color,
            isSelected: false,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ],
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: ColorConstants.primaryDark,
        border: Border.all(
          color: Colors.white24,
          width: .5,
        ),
      ),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(top: 12, left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          indexItem(
            text: "All",
            color: Colors.green,
          ),
          indexItem(
            text: "Major",
            color: Colors.yellow,
          ),
          indexItem(
            text: "No News",
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
