import 'package:equatable/equatable.dart';

class SaveErrorStateState extends Equatable {
  final Map<String, dynamic> errorStateData;
  final String? errorMessageString;

  const SaveErrorStateState({
    this.errorStateData = const {},
    this.errorMessageString,
  });

  @override
  List<Object?> get props => [errorStateData, errorMessageString];
}
