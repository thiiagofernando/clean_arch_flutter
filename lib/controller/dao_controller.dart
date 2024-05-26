import 'package:hyrule/data/dao/database.dart';
import 'package:hyrule/domain/business/dao_workflow.dart';
import 'package:hyrule/domain/models/entry.dart';

import '../data/dao/entry_dao.dart';

class DaoController implements DaoWorkflow{
  
  Future<EntryDao> createDataBase() async{
    final dataBase = await $FloorAppDataBase.databaseBuilder("app_database.db").build();
    final entryDao = dataBase.entryDao;
    return entryDao;
  }

  @override
  Future<void> deleteEntry({required Entry entry}) async {
    final EntryDao entryDao = await createDataBase();
    entryDao.removeEntry(entry);
  }

  @override
  Future<List<Entry>> getSavedEntries() async{
    final EntryDao entryDao = await createDataBase();
    return entryDao.getAllEntries();
  }

  @override
  Future<void> saveEntry({required Entry entry}) async {
    final EntryDao entryDao = await createDataBase();
    entryDao.addEntry(entry);
  }
}