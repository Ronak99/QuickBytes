import 'package:cache_repository/cache_repository.dart';
import 'package:cache_repository/src/cache_config.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CategoryEndpoint {
  Box<Map>? _categoryBox;

  init() async {
    try {
      _categoryBox = await Hive.openBox<Map>(CacheRoutes.categories);
    } catch (e) {
      throw const CacheInitializationError();
    }
  }

  Future<List<Map<String, dynamic>>> queryCategories() async {
    try {
      if (_categoryBox == null) {
        // Ensuring that this function is smart enough to handle the null case for news box
        // sometimes, when queryArticles is called on initState, the box isn't even properly initialized
        // by the time, the flow reaches, query articles.
        await init();
        return queryCategories();
      }

      List<Map> valueList = _categoryBox!.values.toList();

      List<Map<String, dynamic>> categoryMapList =
          valueList.map((e) => Map<String, dynamic>.from(e)).toList();

      return categoryMapList;
    } catch (e) {
      throw const QueryCategoryCacheException();
    }
  }

  saveCategories(List<Map<String, dynamic>> categoryList) async {
    try {
      if (_categoryBox == null) {
        throw const SaveCategoryCacheException(
          message: 'Category box is not open',
        );
      }
      await _categoryBox!.clear();

      print("Value length: ${_categoryBox!.values.length}");
      await _categoryBox!.addAll(categoryList);
    } catch (e) {
      throw const SaveCategoryCacheException();
    }
  }
}
