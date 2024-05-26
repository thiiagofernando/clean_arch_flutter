import 'package:flutter/material.dart';
import 'package:hyrule/screns/components/category.dart';
import 'package:hyrule/utils/consts/categories.dart';

import 'favorites.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Escolha uma categoria'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Favorites(),
                  ),
                );
              },
              icon: const Icon(Icons.bookmark),
            ),
          ],
        ),
        body: GridView(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          children: categories.keys
              .map(
                (e) => Category(category: e),
              )
              .toList(),
        ),
      ),
    );
  }
}
