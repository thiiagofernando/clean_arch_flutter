import 'package:flutter/material.dart';
import 'package:hyrule/controller/api_controller.dart';
import 'package:hyrule/screns/components/entry_card.dart';
import 'package:hyrule/utils/consts/categories.dart';

class Results extends StatelessWidget {
  final String category;
  final ApiController apiController = ApiController();
  Results({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(categories[category]!),
        ),
        body: FutureBuilder(
          future: apiController.getEntriesByCategory(category: category),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
                break;
              case ConnectionState.none:
                break;
              case ConnectionState.done:
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return EntryCard(entry: snapshot.data![index]);
                    },
                  );
                }
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              default:
            }
            return Container();
          },
        ),
      ),
    );
  }
}
