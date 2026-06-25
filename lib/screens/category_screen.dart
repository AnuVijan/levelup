import 'package:flutter/material.dart';
import 'package:levelup/models/category.dart';
import 'package:levelup/services/category_service.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  final TextEditingController controller =
      TextEditingController();

  final CategoryService categoryService =
      CategoryService();

  List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<void> loadCategories() async {
    final loadedCategories =
        await categoryService.loadCategories();

    setState(() {
      categories = loadedCategories;
    });
  }

  Future<void> addCategory() async {

    if (controller.text.trim().isEmpty) {
      return;
    }

    categories.add(
      Category(
        name: controller.text.trim(),
      ),
    );

    await categoryService.saveCategories(
      categories,
    );

    controller.clear();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: "New Category",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: addCategory,
                child: const Text(
                  "Add Category",
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: categories.length,

                itemBuilder: (context, index) {

                  return Card(
                    child: ListTile(
                      title: Text(
                        categories[index].name,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}