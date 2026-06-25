import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/category.dart';

class CategoryService {

  Future<void> saveCategories(
    List<Category> categories,
  ) async {

    final prefs =
        await SharedPreferences.getInstance();

    List<String> categoryList =
        categories.map(
          (category) =>
              jsonEncode(category.toMap()),
        ).toList();

    await prefs.setStringList(
      'categories',
      categoryList,
    );
  }

  Future<List<Category>> loadCategories()
      async {

    final prefs =
        await SharedPreferences.getInstance();

    List<String>? categoryList =
        prefs.getStringList('categories');

    if (categoryList == null) {
      return [
        Category(name: 'Health'),
        Category(name: 'Learning'),
        Category(name: 'Career'),
        Category(name: 'Discipline'),
        Category(name: 'Mindset'),
        Category(name: 'Social'),
        Category(name: 'Personal'),
      ];
    }

    return categoryList.map((item) {
      return Category.fromMap(
        jsonDecode(item),
      );
    }).toList();
  }
}