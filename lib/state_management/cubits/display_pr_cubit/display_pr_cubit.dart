import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_bro/constants/enums.dart';

import 'display_pr_state.dart';

class DisplayPrCubit extends Cubit<DisplayPrState> {
  DisplayPrCubit()
      : super(const DisplayPrState(
            currentDisplayedComparisonSetType: ComparisonDisplayType.latest));

  void switchComparisonType(ComparisonDisplayType newDisplayType) {
    emit(DisplayPrState(currentDisplayedComparisonSetType: newDisplayType));
  }

  void toggleComparisonType() {
    if (state.currentDisplayedComparisonSetType ==
        ComparisonDisplayType.latest) {
      emit(const DisplayPrState(
          currentDisplayedComparisonSetType: ComparisonDisplayType.PR));
    } else {
      emit(const DisplayPrState(
          currentDisplayedComparisonSetType: ComparisonDisplayType.latest));
    }
  }
}
