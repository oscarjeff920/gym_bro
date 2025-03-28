import 'package:gym_bro/data_models/database_data_models/tables/table_constants.dart';

const Map<String, List<Map<String, dynamic>>> mockData1 = {
  workoutTableName: [
    {'id': 0, 'year': 2025, 'month': 2, 'day': 3},
    {'id': 1, 'year': 2025, 'month': 2, 'day': 9},
    {'id': 2, 'year': 2025, 'month': 2, 'day': 20},
    {'id': 3, 'year': 2025, 'month': 2, 'day': 24},
    {'id': 4, 'year': 2025, 'month': 3, 'day': 4},
    {'id': 5, 'year': 2025, 'month': 3, 'day': 7},
    {'id': 6, 'year': 2025, 'month': 3, 'day': 9},
    {'id': 7, 'year': 2025, 'month': 3, 'day': 12},
    {'id': 8, 'year': 2025, 'month': 3, 'day': 15},
    {'id': 9, 'year': 2025, 'month': 3, 'day': 18},
    {'id': 10, 'year': 2025, 'month': 3, 'day': 20},
    {'id': 11, 'year': 2025, 'month': 3, 'day': 24},
    {'id': 12, 'year': 2025, 'month': 4, 'day': 1},
    {'id': 13, 'year': 2025, 'month': 3, 'day': 6},
  ],
  exerciseTableName: [
    {'id': 0, 'movement_id': 1, 'workout_id': 0, 'exercise_order': 0},
    {'id': 1, 'movement_id': 1, 'workout_id': 1, 'exercise_order': 0},
    {'id': 2, 'movement_id': 1, 'workout_id': 2, 'exercise_order': 0},
    {'id': 3, 'movement_id': 1, 'workout_id': 3, 'exercise_order': 0},
    {'id': 4, 'movement_id': 1, 'workout_id': 4, 'exercise_order': 0},
    {'id': 5, 'movement_id': 1, 'workout_id': 5, 'exercise_order': 0},
    {'id': 6, 'movement_id': 1, 'workout_id': 6, 'exercise_order': 0},
    {'id': 7, 'movement_id': 1, 'workout_id': 7, 'exercise_order': 0},
    {'id': 8, 'movement_id': 1, 'workout_id': 8, 'exercise_order': 0},
    {'id': 9, 'movement_id': 1, 'workout_id': 9, 'exercise_order': 0},
    {'id': 10, 'movement_id': 1, 'workout_id': 10, 'exercise_order': 0},
    {'id': 11, 'movement_id': 0, 'workout_id': 11, 'exercise_order': 0},
    {'id': 12, 'movement_id': 0, 'workout_id': 12, 'exercise_order': 0},
  ]
};
const Map<String, List<Map<String, dynamic>>> mockData2 = {
  exerciseSetTableName: [
    {'exercise_id': 0, 'set_order': 0, 'is_warm_up': 0, 'weight': 0, 'reps': 0},
    {'exercise_id': 0, 'set_order': 1, 'is_warm_up': 0, 'weight': 0, 'reps': 0},
    {'exercise_id': 0, 'set_order': 2, 'is_warm_up': 0, 'weight': 0, 'reps': 0},
    {'exercise_id': 0, 'set_order': 3, 'is_warm_up': 0, 'weight': 0, 'reps': 0},
    {'exercise_id': 0, 'set_order': 4, 'is_warm_up': 0, 'weight': 0, 'reps': 0},
    {'exercise_id': 0, 'set_order': 5, 'is_warm_up': 0, 'weight': 0, 'reps': 0},
    {'exercise_id': 0, 'set_order': 6, 'is_warm_up': 0, 'weight': 0, 'reps': 0},
    {'exercise_id': 1, 'set_order': 0, 'is_warm_up': 0, 'weight': 0, 'reps': 0},
    {'exercise_id': 1, 'set_order': 1, 'is_warm_up': 0, 'weight': 0, 'reps': 0},
    {'exercise_id': 2, 'set_order': 0, 'is_warm_up': 0, 'weight': 0, 'reps': 0},
    {'exercise_id': 2, 'set_order': 1, 'is_warm_up': 0, 'weight': 0, 'reps': 0},
    {'exercise_id': 2, 'set_order': 2, 'is_warm_up': 0, 'weight': 0, 'reps': 0},
    {'exercise_id': 2, 'set_order': 3, 'is_warm_up': 0, 'weight': 0, 'reps': 0},
    {'exercise_id': 2, 'set_order': 4, 'is_warm_up': 0, 'weight': 0, 'reps': 0},
  ]
};

const Map<String, List<Map<String, dynamic>>> mockData3 = {
  workoutTableName: [
    {'id': 0, 'year': 2025, 'month': 2, 'day': 3},
    {'id': 1, 'year': 2024, 'month': 3, 'day': 4},
    {'id': 2, 'year': 2025, 'month': 1, 'day': 5},
    {'id': 3, 'year': 2025, 'month': 4, 'day': 6},
  ],
  exerciseTableName: [
    {'id': 0, 'movement_id': 1, 'workout_id': 0, 'exercise_order': 0},
    {'id': 1, 'movement_id': 1, 'workout_id': 1, 'exercise_order': 0},
    {'id': 2, 'movement_id': 1, 'workout_id': 2, 'exercise_order': 0},
    {'id': 3, 'movement_id': 1, 'workout_id': 3, 'exercise_order': 0},
  ],
  exerciseSetTableName: [
    {'id': 0, 'exercise_id': 0, 'set_order': 1, 'weight': 60, 'reps': 2},
    {'id': 1, 'exercise_id': 1, 'set_order': 2, 'weight': 60, 'reps': 2},
    {'id': 2, 'exercise_id': 2, 'set_order': 3, 'weight': 60, 'reps': 2},
    {'id': 3, 'exercise_id': 3, 'set_order': 0, 'weight': 60, 'reps': 2},
    {'id': 4, 'exercise_id': 3, 'set_order': 4, 'weight': 60, 'reps': 2},
  ]
};
