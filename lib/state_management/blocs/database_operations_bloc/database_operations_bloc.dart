import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../database/create_table_commands.dart';
import 'database_operations_event.dart';
import 'database_operations_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  DatabaseBloc() : super(DatabasePowerDownState());
  final String createTablesCommands = "";//SQL_CREATE_TABLE_COMMANDS;

  @override
  Stream<DatabaseState> mapEventToState(DatabaseEvent event) async* {
    if (event is StartUpDatabaseEvent) {
      yield* _mapLoadStartUpContextsToState(event);
    }
  }

  Stream<DatabaseState> _mapLoadStartUpContextsToState(
      StartUpDatabaseEvent event) async* {
    yield DatabaseStartUpState();

    try {
      WidgetsFlutterBinding.ensureInitialized();
      final database = openDatabase(
        join(await getDatabasesPath(), 'gym_bro.db'),
        onCreate: (db, version) {
          return db.execute(
            createTablesCommands,
          );
        },
        version: 1,
      );
      yield DatabaseRunningState(databaseConnection: database);
    } catch (exc) {
      print(exc);
      yield DatabaseErrorState();
    }
  }
}
