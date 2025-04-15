import 'package:equatable/equatable.dart';
import 'package:gym_bro/constants/enums.dart';

class DisplayPrState extends Equatable {
  final ComparisonDisplayType currentDisplayedComparisonSetType;

  const DisplayPrState({required this.currentDisplayedComparisonSetType});

  get isPRDisplayed =>
      currentDisplayedComparisonSetType == ComparisonDisplayType.PR;

  @override
  List<Object?> get props => [currentDisplayedComparisonSetType];
}
