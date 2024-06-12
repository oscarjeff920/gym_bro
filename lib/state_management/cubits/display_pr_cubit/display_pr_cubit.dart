import 'package:flutter_bloc/flutter_bloc.dart';

import 'display_pr_state.dart';

class DisplayPrCubit extends Cubit<DisplayPrState> {
  DisplayPrCubit() : super(const DisplayPrState(displayedPR: false));

  togglePr() {
    if (state.displayedPR) {
      emit(const DisplayPrState(displayedPR: false));
    } else {
      emit(const DisplayPrState(displayedPR: true));
    }
  }
}
