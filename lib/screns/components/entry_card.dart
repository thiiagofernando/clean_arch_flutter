import 'package:flutter/material.dart';
import 'package:hyrule/controller/dao_controller.dart';
import 'package:hyrule/domain/models/entry.dart';

import '../details.dart';

class EntryCard extends StatelessWidget {
  final Entry entry;
  final DaoController daoController = DaoController();

  final bool isSaved;
  EntryCard({super.key, required this.entry, required this.isSaved});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Dismissible(
        direction:
            isSaved ? DismissDirection.endToStart : DismissDirection.none,
        key: ValueKey<int>(entry.id),
        onDismissed: (direction) {
          daoController.deleteEntry(entry: entry);
        },
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Details(
                      entry: entry,
                    ),
                  ),
                );
              },
              child: Ink(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        entry.image,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          entry.name.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(entry.description),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                  color: Colors.blueGrey,
                  border: Border(top: BorderSide(width: 1.0)),
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: Wrap(
                children: entry
                    .commonLocationsConverter()
                    .map(
                      (e) => Chip(
                        label: Text(e),
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
