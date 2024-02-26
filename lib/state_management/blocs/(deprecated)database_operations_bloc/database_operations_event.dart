import 'package:equatable/equatable.dart';

abstract class DatabaseEvent extends Equatable {

  @override
  List<Object?> get props => [];
}

class StartUpDatabaseEvent extends DatabaseEvent {}

class QueryDatabaseEvent extends DatabaseEvent {}

class ShutDownDatabaseEvent extends DatabaseEvent {}
