import 'package:flutter/material.dart';
import 'package:hyrule/controller/dao_controller.dart';
import 'package:hyrule/domain/models/entry.dart';

class Details extends StatelessWidget {
  final Entry entry;

  final DaoController daoController = DaoController();

  Details({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes'),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                entry.name.toUpperCase(),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Wrap(
                children: entry
                    .commonLocationsConverter()
                    .map((e) => Container(
                        padding: const EdgeInsets.all(2),
                        child: Chip(label: Text(e))))
                    .toList(),
              ),
              Image.network(entry.image),
              Text(entry.description),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            daoController.saveEntry(entry: entry);
          },
          child: const Icon(Icons.bookmark),
        ),
      ),
    );
  }
}
