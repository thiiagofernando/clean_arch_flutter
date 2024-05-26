import 'package:flutter/material.dart';
import 'package:hyrule/controller/dao_controller.dart';
import 'package:hyrule/screns/components/entry_card.dart';

class Favorites extends StatelessWidget {
  final DaoController daoController = DaoController();
  Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Favoritos'),
        ),
        body: FutureBuilder(
          future: daoController.getSavedEntries(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
                break;
              case ConnectionState.none:
                break;
              case ConnectionState.done:
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) => EntryCard(
                      entry: snapshot.data![index],
                      isSaved: true,
                    ),
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
