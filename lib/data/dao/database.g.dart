// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDataBaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDataBaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDataBaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDataBase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDataBase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDataBaseBuilderContract databaseBuilder(String name) =>
      _$AppDataBaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDataBaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDataBaseBuilder(null);
}

class _$AppDataBaseBuilder implements $AppDataBaseBuilderContract {
  _$AppDataBaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDataBaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDataBaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDataBase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDataBase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDataBase extends AppDataBase {
  _$AppDataBase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  EntryDao? _entryDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Entry` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `image` TEXT NOT NULL, `description` TEXT NOT NULL, `commonLocations` TEXT NOT NULL, `category` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  EntryDao get entryDao {
    return _entryDaoInstance ??= _$EntryDao(database, changeListener);
  }
}

class _$EntryDao extends EntryDao {
  _$EntryDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _entryInsertionAdapter = InsertionAdapter(
            database,
            'Entry',
            (Entry item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'image': item.image,
                  'description': item.description,
                  'commonLocations': item.commonLocations,
                  'category': item.category
                }),
        _entryDeletionAdapter = DeletionAdapter(
            database,
            'Entry',
            ['id'],
            (Entry item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'image': item.image,
                  'description': item.description,
                  'commonLocations': item.commonLocations,
                  'category': item.category
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Entry> _entryInsertionAdapter;

  final DeletionAdapter<Entry> _entryDeletionAdapter;

  @override
  Future<List<Entry>> getAllEntries() async {
    return _queryAdapter.queryList('select * from entry',
        mapper: (Map<String, Object?> row) => Entry(
            id: row['id'] as int,
            name: row['name'] as String,
            image: row['image'] as String,
            description: row['description'] as String,
            commonLocations: row['commonLocations'] as String,
            category: row['category'] as String));
  }

  @override
  Future<void> addEntry(Entry entry) async {
    await _entryInsertionAdapter.insert(entry, OnConflictStrategy.replace);
  }

  @override
  Future<void> removeEntry(Entry entry) async {
    await _entryDeletionAdapter.delete(entry);
  }
}
