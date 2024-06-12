import 'package:equatable/equatable.dart';

class DisplayPrState extends Equatable {
  final bool displayedPR;

  const DisplayPrState({required this.displayedPR});

  @override
  List<Object?> get props => [displayedPR];
}
