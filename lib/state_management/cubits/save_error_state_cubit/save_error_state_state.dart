import 'package:equatable/equatable.dart';

class SaveErrorStateState extends Equatable {
  final Map errorStateData;

  const SaveErrorStateState({this.errorStateData = const {}});

  @override
  List<Object?> get props => [errorStateData];
}