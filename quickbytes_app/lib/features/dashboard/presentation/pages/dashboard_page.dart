import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_repository/news_repository.dart';

import 'package:quickbytes_app/features/categories/state/cubit/news_category_cubit.dart';
import 'package:quickbytes_app/features/dashboard/state/bloc/dashboard_bloc.dart';
import 'package:quickbytes_app/features/news/state/news_bloc.dart';
import 'package:quickbytes_app/features/notifications/domain/repositories/notification_service.dart';
import 'package:quickbytes_app/shared/utils/utils.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QuickBytes'),
        actions: const [
          ToggleThemeSwitch(),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
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
            GestureDetector(
              onTap: () async {
                final dashboardBloc = context.read<DashboardBloc>();
                final newsCategoryCubit = context.read<NewsCategoryCubit>();
                final newsBloc = context.read<NewsBloc>();

                final categories = dashboardBloc.state.selectedCategoryList;
                CategoryChange? change =
                    await newsCategoryCubit.updateUserCategories(categories);

                if (change != null) {
                  newsBloc.add(NewsEventUserCategoriesChanged(
                      categoriesAdded: change.categoriesAdded,
                      categoriesRemoved: change.categoriesRemoved));
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

    context.read<DashboardBloc>().add(
          IntializeCategoryListRequested(
            newsCategoryList: List.from(widget.userCategories),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
      return ListView.builder(
        itemCount: widget.allCategories.length,
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
              context.read<DashboardBloc>().add(
                  NewsCategorySelected(newsCategory: selectedNewsCategory));
            },
          );
        },
      );
    });
  }
}

class ToggleThemeSwitch extends StatelessWidget {
  const ToggleThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Switch(
      onChanged: (value) {},
      value: true,
    );
  }
}

class CategoryListItem extends StatefulWidget {
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

  @override
  State<CategoryListItem> createState() => _CategoryListItemState();
}

class _CategoryListItemState extends State<CategoryListItem> {
  late NewsCategory _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.selectedCategory;
  }

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

    return GestureDetector(
      onTap: () {
        _selectedCategory = category;
        widget.onCategorySelect(_selectedCategory);
      },
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(4),
        child: Container(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: Border.all(
              color: _selectedCategory.relevancy == category.relevancy
                  ? Colors.blue
                  : Colors.transparent,
              width: 2,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              widget.categoryName,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...widget.categoryTypes.map(
                  (e) => selectionView(category: e),
                ),
                selectionView(
                  category: widget.categoryTypes[0].copyWith(
                    relevancy: Relevancy.none,
                    name: "${widget.categoryTypes[0].name.split('_')[0]}_none",
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
