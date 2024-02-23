import 'package:equatable/equatable.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DatabasePowerDownState extends DatabaseState {}

class DatabaseStartUpState extends DatabaseState {}

class DatabaseRunningState extends DatabaseState {
  final Future<Database> databaseConnection;

  DatabaseRunningState({required this.databaseConnection});
}

class DatabaseErrorState extends DatabaseState {}
