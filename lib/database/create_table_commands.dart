
import 'package:gym_bro/data_models/database_data_models/tables/table_constants.dart';

const SQL_CREATE_TABLE_COMMANDS = [
  """
CREATE TABLE $workoutTableName (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    year INTEGER NOT NULL,
    month INTEGER NOT NULL,
    day INTEGER NOT NULL,
    duration TEXT NOT NULL
);
""",
  """
CREATE TABLE $movementTableName (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE NOT NULL
);
""",
  """
CREATE TABLE $muscleGroupTableName (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
);
""",
  """
CREATE TABLE $movementMuscleGroupsTableName (
    movement_id INTEGER,
    muscle_group_id INTEGER,
    role TEXT CHECK(role IN ('primary', 'secondary')),
    FOREIGN KEY (movement_id) REFERENCES movement(id),
    FOREIGN KEY (muscle_group_id) REFERENCES muscle_group(id),
    PRIMARY KEY (movement_id, muscle_group_id)
);
""",
  """

CREATE TABLE $exerciseTableName (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    movement_id INTEGER,
    workout_id INTEGER,
    exercise_order INTEGER NOT NULL,
    duration TEXT,
    num_working_sets INTEGER,
    FOREIGN KEY (movement_id) REFERENCES movement(id),
    FOREIGN KEY (workout_id) REFERENCES workout(id)
);
""",
  """

CREATE TABLE $exerciseSetTableName (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    exercise_id INTEGER,
    set_order INTEGER NOT NULL,
    is_warm_up INTEGER CHECK (is_warm_up IN (0, 1)),
    weight DECIMAL NOT NULL,
    reps INTEGER NOT NULL,
    extra_reps INTEGER,
    duration TEXT,
    notes TEXT,
    FOREIGN KEY (exercise_id) REFERENCES exercise(id)
);
""",
  """

INSERT INTO $movementTableName (name) VALUES
  ('flat bench press'),
  ('squats'),
  ('seated shoulder press'),
  ('standing military press'),
     ('preacher curl machine'),
  ('close grip bench'),
  ('dips'),
  ('split squat'),
  ('deadlift'),
  ('converging shoulder press machine'),
  
  ('hack squat'),
  ('bent over rows barbell (reverse grip)'),
  ('single arm dumbbell row'),
  ('lat pull-down machine'),
     ('dumbbell bench press (flat)'),
  ('dumbbell incline bench press (3)'),
  ('standing lateral raise'),
  ('pulley reverse files (12)'),
  ('converging shoulder press machine (6)'),
  ('pulley lateral raise'),
  
  ('dumbbell files (2)'),
  ('dumbbell skull crushers (4)'),
  ('sissy squat'),
  ('pull up (reverse grip)'),
     ('pull up'),
  ('triceps push-down machine'),
  ('EZ bar skull crusher (1)'),
  ('preacher curl'),
  ('seated row machine (downstairs)');
""",
  """

INSERT INTO $muscleGroupTableName(name) VALUES
  ('chest'),
  ('back'),
  ('shoulders'),
  ('biceps'),
  ('triceps'),
  ('legs');
""",
  """
  
INSERT INTO $movementMuscleGroupsTableName VALUES
  (1, 1, 'primary'),
  (1, 5, 'secondary'),
  (2, 6, 'primary'),
  (3, 3, 'primary'),
  (3, 5, 'secondary'),
  (4, 3, 'primary'),
  (4, 5, 'secondary'),
  (5, 4, 'primary'),
  (6, 1, 'secondary'),
  (6, 5, 'primary'),
  (7, 1, 'secondary'),
  (7, 5, 'primary'),
  (8, 6, 'primary'),
  (9, 6, 'primary'),
  (9, 2, 'primary'),
  (10, 3, 'primary'),
  (10, 5, 'secondary'),
  
  (11, 6, 'primary'),
  (12, 2, 'primary'),
  (12, 4, 'secondary'),
  (12, 6, 'secondary'),
  (13, 2, 'primary'),
  (13, 4, 'secondary'),
  (14, 2, 'primary'),
  (14, 4, 'secondary'),
  (15, 1, 'primary'),
  (15, 5, 'secondary'),
  (16, 1, 'primary'),
  (16, 5, 'secondary'),
  (17, 3, 'primary'),
  (18, 2, 'primary'),
  (18, 3, 'primary'),
  (19, 3, 'primary'),
  (19, 5, 'secondary'),
  (20, 3, 'primary'),
  
  (21, 1, 'primary'),
  (22, 5, 'primary'),
  (23, 6, 'primary'),
  (24, 4, 'primary'),
  (24, 2, 'secondary'),
  (25, 2, 'primary'),
  (25, 4, 'secondary'),
  (26, 5, 'primary'),
  (26, 1, 'secondary'),
  (27, 5, 'primary'),
  (28, 4, 'primary'),
  (29, 2, 'primary'),
  (29, 4, 'secondary');
""",
  // Mock Data:
  """
  INSERT INTO $workoutTableName(year, month, day, duration) VALUES
  (1988, 02, 16, '01:56:01'),
  (1995, 8, 27, '01:44:12');
  """,
  """
  INSERT INTO $exerciseTableName(movement_id, workout_id, exercise_order, duration, num_working_sets) VALUES
  (4 , 1, 1, '05:27', 4),
  
  (2 , 2, 1, '10:02', 5),
  (10, 2, 2, '12:22', 5),
  (1 , 2, 3, '02:54', 5); 
  """,
  """
  INSERT INTO $exerciseSetTableName(exercise_id, set_order, is_warm_up, weight, reps, extra_reps, duration, notes) VALUES
  (1, 1, 1, 20, 12, 10, '01:02', 'big effort'),
  (1, 2, 0, 40, 8 , 6 , '00:58', 'form awkward'),
  (1, 3, 0, 40, 7 , 4 , '00:46', 'form better'),
  (1, 4, 0, 40, 5 , 2 , '00:34', null),
  (1, 5, 0, 40, 5 , 3 , '00:37', 'exhausted'),

  (2, 1, 1, 60, 22, 18, '00:12', null),
  (2, 2, 0, 70, 8 , 12, '00:22', null),
  (2, 3, 0, 70, 8 , 11, '00:23', null),
  (2, 4, 0, 70, 4 , 2 , '00:12', null),
  (2, 5, 0, 65, 6 , 5 , '00:20', null),
  (2, 6, 0, 65, 6 , 3 , '00:26', null),

  (3, 1, 1, 12, 12, 10, '00:20', null),
  (3, 2, 0, 22, 8 , 12, '00:25', 'good stuff'),
  (3, 3, 0, 22, 8 , 11, '00:21', null),
  (3, 4, 0, 22, 4 , 2 , '00:31', null),
  (3, 5, 0, 22, 4 , 1 , '00:12', null),
  (3, 6, 0, 20, 6 , 3 , '00:15', null),

  (4, 1, 1, 10, 22, 18, '00:12', '2 ez'),
  (4, 2, 0, 15, 8 , 12, '00:22', 'still ez'),
  (4, 3, 0, 15, 8 , 11, '00:23', 'better'),
  (4, 4, 0, 15, 4 , 2 , '00:12', null),
  (4, 5, 0, 12, 6 , 5 , '00:20', null),
  (4, 6, 0, 12, 6 , 3 , '00:26', null);
  """,

];
