import 'package:flutter_test/flutter_test.dart';
import 'package:gym_bro/data_models/FE_data_models/exercise_set_data_models.dart';
import 'package:gym_bro/data_models/bloc_data_models/flutter_data_models.dart';
import 'package:gym_bro/state_management/blocs/database_tables/exercise_set/get_latest_exercise_sets_by_movement_bloc/get_last_exercise_sets_by_movement_state.dart';

void main() {
  group('getEquivalentWarmupSetIndex', () {
    final mockState = SuccessfulGetLastExerciseSetsByMovementQueryState(
        lastExerciseSetsData: const {}, movementPRData: const {});
    test('1st set is warm up for current and comparison', () {
      int resultIndex = mockState.getEquivalentWarmupSetIndex(
          currentSetIndex: 0,
          comparisonExerciseSets: [
            GeneralExerciseSetModel(
                exerciseSetOrder: 1, isWarmUp: true, weight: 0, reps: 1),
          ]);

      int expectedIndex = 0;

      expect(resultIndex, expectedIndex);
    });
    test('1st & 2nd set is warm up for current and comparison', () {
      int resultIndex = mockState.getEquivalentWarmupSetIndex(
          currentSetIndex: 1,
          comparisonExerciseSets: [
            GeneralExerciseSetModel(
                exerciseSetOrder: 1, isWarmUp: true, weight: 0, reps: 1),
            GeneralExerciseSetModel(
                exerciseSetOrder: 2, isWarmUp: true, weight: 0, reps: 0)
          ]);

      int expectedIndex = 1;

      expect(resultIndex, expectedIndex);
    });
    test('1st & 2nd set is warm up for current but only first for comparison set', () {
      int resultIndex = mockState.getEquivalentWarmupSetIndex(
          currentSetIndex: 1,
          comparisonExerciseSets: [
            GeneralExerciseSetModel(
                exerciseSetOrder: 1, isWarmUp: true, weight: 0, reps: 1),
            GeneralExerciseSetModel(
                exerciseSetOrder: 2, isWarmUp: false, weight: 0, reps: 0)
          ]);

      int expectedIndex = 0;

      expect(resultIndex, expectedIndex);
    });
    test('1st set is warm up for current but none for comparison set', () {
      int resultIndex = mockState.getEquivalentWarmupSetIndex(
          currentSetIndex: 0,
          comparisonExerciseSets: [
            GeneralExerciseSetModel(
                exerciseSetOrder: 1, isWarmUp: false, weight: 0, reps: 1),
          ]);

      int expectedIndex = 0;

      expect(resultIndex, expectedIndex);
    });
  });
  group('getEquivalentWorkingSetIndex', () {
    final mockState = SuccessfulGetLastExerciseSetsByMovementQueryState(
        lastExerciseSetsData: const {}, movementPRData: const {});
    test('1st working set with 2 warm up comparison sets', () {
      int resultIndex = mockState.getEquivalentWorkingSetIndex(
          currentWorkingSetIndex: 0,
          comparisonExerciseSets: [
            GeneralExerciseSetModel(
                exerciseSetOrder: 1, isWarmUp: true, weight: 10, reps: 1),
            GeneralExerciseSetModel(
                exerciseSetOrder: 2, isWarmUp: true, weight: 11, reps: 1),
            GeneralExerciseSetModel(
                exerciseSetOrder: 3, isWarmUp: false, weight: 100, reps: 1),
            GeneralExerciseSetModel(
                exerciseSetOrder: 4, isWarmUp: false, weight: 101, reps: 1),
            GeneralExerciseSetModel(
                exerciseSetOrder: 5, isWarmUp: false, weight: 102, reps: 1),
          ]);

      int expectedIndex = 2;

      expect(resultIndex, expectedIndex);
    });
    test('2nd working set with 2 warm up comparison sets', () {
      int resultIndex = mockState.getEquivalentWorkingSetIndex(
          currentWorkingSetIndex: 1,
          comparisonExerciseSets: [
            GeneralExerciseSetModel(
                exerciseSetOrder: 1, isWarmUp: true, weight: 10, reps: 1),
            GeneralExerciseSetModel(
                exerciseSetOrder: 2, isWarmUp: true, weight: 11, reps: 1),
            GeneralExerciseSetModel(
                exerciseSetOrder: 3, isWarmUp: false, weight: 100, reps: 1),
            GeneralExerciseSetModel(
                exerciseSetOrder: 4, isWarmUp: false, weight: 101, reps: 1),
            GeneralExerciseSetModel(
                exerciseSetOrder: 5, isWarmUp: false, weight: 102, reps: 1),
          ]);

      int expectedIndex = 3;

      expect(resultIndex, expectedIndex);
    });
    test('2nd working set with 2 warm ups and one drop comparison sets', () {
      int resultIndex = mockState.getEquivalentWorkingSetIndex(
          currentWorkingSetIndex: 1,
          comparisonExerciseSets: [
            GeneralExerciseSetModel(
                exerciseSetOrder: 1, isWarmUp: true, weight: 10, reps: 1),
            GeneralExerciseSetModel(
                exerciseSetOrder: 2, isWarmUp: true, weight: 11, reps: 1),
            GeneralExerciseSetModel(
                exerciseSetOrder: 3, isWarmUp: false, weight: 100, reps: 1),
            GeneralExerciseSetModel(
                exerciseSetOrder: 4, isWarmUp: true, weight: 101, reps: 1),
            GeneralExerciseSetModel(
                exerciseSetOrder: 5, isWarmUp: false, weight: 102, reps: 1),
          ]);

      int expectedIndex = 4;

      expect(resultIndex, expectedIndex);
    });
    test('4th working set with 3 comparison working sets', () {
      int resultIndex = mockState.getEquivalentWorkingSetIndex(
          currentWorkingSetIndex: 4,
          comparisonExerciseSets: [
            GeneralExerciseSetModel(
                exerciseSetOrder: 1, isWarmUp: true, weight: 10, reps: 1),
            GeneralExerciseSetModel(
                exerciseSetOrder: 2, isWarmUp: true, weight: 11, reps: 1),
            GeneralExerciseSetModel(
                exerciseSetOrder: 3, isWarmUp: false, weight: 100, reps: 1),
            GeneralExerciseSetModel(
                exerciseSetOrder: 4, isWarmUp: false, weight: 101, reps: 1),
            GeneralExerciseSetModel(
                exerciseSetOrder: 5, isWarmUp: false, weight: 102, reps: 1),
          ]);

      int expectedIndex = 4;

      expect(resultIndex, expectedIndex);
    });
    test(
        '4th working set with 3 comparison working sets and one final drop set',
        () {
      int resultIndex = mockState.getEquivalentWorkingSetIndex(
          currentWorkingSetIndex: 4,
          comparisonExerciseSets: [
            GeneralExerciseSetModel(
                exerciseSetOrder: 1, isWarmUp: true, weight: 10, reps: 1),
            GeneralExerciseSetModel(
                exerciseSetOrder: 2, isWarmUp: true, weight: 11, reps: 1),
            GeneralExerciseSetModel(
                exerciseSetOrder: 3, isWarmUp: false, weight: 100, reps: 1),
            GeneralExerciseSetModel(
                exerciseSetOrder: 4, isWarmUp: false, weight: 101, reps: 1),
            GeneralExerciseSetModel(
                exerciseSetOrder: 5, isWarmUp: true, weight: 102, reps: 1),
          ]);

      int expectedIndex = 3;

      expect(resultIndex, expectedIndex);
    });
    test(
        '4th working set with 3 comparison working sets and one final drop set',
        () {
      int resultIndex = mockState.getEquivalentWorkingSetIndex(
          currentWorkingSetIndex: 0,
          comparisonExerciseSets: [
            GeneralExerciseSetModel(
                exerciseSetOrder: 1, isWarmUp: true, weight: 10, reps: 1),
            GeneralExerciseSetModel(
                exerciseSetOrder: 2, isWarmUp: false, weight: 11, reps: 1),
            GeneralExerciseSetModel(
                exerciseSetOrder: 3, isWarmUp: false, weight: 100, reps: 1),
            GeneralExerciseSetModel(
                exerciseSetOrder: 4, isWarmUp: false, weight: 101, reps: 1),
            GeneralExerciseSetModel(
                exerciseSetOrder: 5, isWarmUp: true, weight: 102, reps: 1),
          ]);

      int expectedIndex = 1;

      expect(resultIndex, expectedIndex);
    });
  });
  group('provideMatchingPreviousSetIndex', () {
    final mockState = SuccessfulGetLastExerciseSetsByMovementQueryState(
        lastExerciseSetsData: const {}, movementPRData: const {});
    test('1st set is warm up for current and comparison set', () {
      int resultIndex = mockState.provideMatchingPreviousSetIndex(
          currentSet: const CurrentSet(isWarmUp: true),
          completedSets: [],
          comparisonExerciseSets: [
            GeneralExerciseSetModel(
                exerciseSetOrder: 1, isWarmUp: true, weight: 0, reps: 1),
            GeneralExerciseSetModel(
                exerciseSetOrder: 2, isWarmUp: false, weight: 0, reps: 0)
          ]);

      int expectedIndex = 0;

      expect(resultIndex, expectedIndex);
    });
    test('2nd set is warm up for current and comparison set', () {
      int resultIndex = mockState.provideMatchingPreviousSetIndex(
          currentSet: const CurrentSet(isWarmUp: true),
          completedSets: [
            GeneralExerciseSetModel(
                exerciseSetOrder: 1, isWarmUp: true, weight: 0, reps: 0)
          ],
          comparisonExerciseSets: [
            GeneralExerciseSetModel(
                exerciseSetOrder: 1, isWarmUp: true, weight: 0, reps: 1),
            GeneralExerciseSetModel(
                exerciseSetOrder: 2, isWarmUp: true, weight: 0, reps: 0)
          ]);

      int expectedIndex = 1;

      expect(resultIndex, expectedIndex);
    });
    test('2nd set is warm up for current but not for comparison set', () {
      int resultIndex = mockState.provideMatchingPreviousSetIndex(
          currentSet: const CurrentSet(isWarmUp: true),
          completedSets: [
            GeneralExerciseSetModel(
                exerciseSetOrder: 1, isWarmUp: true, weight: 0, reps: 0)
          ],
          comparisonExerciseSets: [
            GeneralExerciseSetModel(
                exerciseSetOrder: 1, isWarmUp: true, weight: 0, reps: 1),
            GeneralExerciseSetModel(
                exerciseSetOrder: 2, isWarmUp: false, weight: 0, reps: 0)
          ]);

      int expectedIndex = 0;

      expect(resultIndex, expectedIndex);
    });
    test('1st current set is working but 1st comparison is warm up', () {
      int resultIndex = mockState.provideMatchingPreviousSetIndex(
          currentSet: const CurrentSet(isWarmUp: false),
          completedSets: [],
          comparisonExerciseSets: [
            GeneralExerciseSetModel(
                exerciseSetOrder: 1, isWarmUp: true, weight: 0, reps: 1),
            GeneralExerciseSetModel(
                exerciseSetOrder: 2, isWarmUp: false, weight: 0, reps: 0)
          ]);

      int expectedIndex = 1;

      expect(resultIndex, expectedIndex);
    });
  });
}
