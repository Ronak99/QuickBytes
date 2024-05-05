import 'package:api_repository/api_repository.dart';
import 'package:cache_repository/cache_repository.dart';
import 'package:news_repository/src/exceptions/category_exceptions.dart';
import 'package:news_repository/src/exceptions/news_exceptions.dart';
import 'package:news_repository/src/models/models.dart';

class NewsRepository {
  late ApiRepository _apiRepository;
  late CacheRepository _cacheRepository;

  Future<void> init() async {
    _cacheRepository = CacheRepository.instance;
    await _cacheRepository.init();

    _apiRepository = ApiRepository.instance;
  }

  Future<List<Article>> queryAllArticles({
    required List<String> categoryIdList,
  }) async {
    try {
      List<dynamic> articleList = await _apiRepository.articles.queryArticles(
        categoryIdList: categoryIdList,
      );
      _cacheRepository.articles.saveArticles(
        articleList.map((e) => e as Map<String, dynamic>).toList(),
      );

      return articleList.map((e) => Article.fromJson(e)).toList();
    } catch (e) {
      if (e is ApiException) {
        List<dynamic> articleList =
            await _cacheRepository.articles.queryArticles();

        if (articleList.isEmpty) {
          throw const QueryArticleNewsException(
              message: "No articles found even in cache");
        }
        return articleList.map((e) => Article.fromJson(e)).toList();
      } else if (e is QueryArticleCacheException) {
        throw QueryArticleNewsException(message: e.message);
      }
      return [];
    }
  }

  Future<List<NewsCategory>> queryAllCategories() async {
    try {
      List<dynamic> categoryList =
          await _apiRepository.categories.queryCategories();

      return categoryList.map((e) => NewsCategory.fromJson(e)).toList();
    } catch (e) {
      if (e is ApiException) {
        throw QueryNewsCategoryException(message: e.message);
      }
      return [];
    }
  }

  Future<List<NewsCategory>> queryUserCategories({
    required List<NewsCategory> allCategories,
  }) async {
    try {
      List<dynamic> categoryList =
          await _cacheRepository.categories.queryCategories();

      if (categoryList.isEmpty) {
        // parse out categories that are all of major category
        List<NewsCategory> categoriesToSave =
            allCategories.where((category) => !category.isAll).toList();
        // save a default set of categories and return that
        await _cacheRepository.categories.saveCategories(
          categoriesToSave.map((e) => e.toJson()).toList(),
        );
        return categoriesToSave;
      }

      return categoryList.map((e) => NewsCategory.fromJson(e)).toList();
    } catch (e) {
      if (e is ApiException) {
        throw QueryNewsCategoryException(message: e.message);
      }
      return [];
    }
  }

  Future<void> saveCategories(List<NewsCategory> categoryList) async {
    try {
      _cacheRepository.categories.saveCategories(
        categoryList.map((e) => e.toJson()).toList(),
      );
    } catch (e) {
      throw SaveNewsCategoryException(message: e.toString());
    }
  }
}
