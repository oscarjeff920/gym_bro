import 'data_models/tables/table_constants.dart';

const SQL_CREATE_TABLE_COMMANDS = [
  """
CREATE TABLE $workoutTableName (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date TEXT NOT NULL,
    duration TEXT NOT NULL
);
""",
  """
CREATE TABLE $movementTableName (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
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
    weight DECIMAL,
    reps INTEGER,
    extra_reps INTEGER,
    duration TEXT,
    notes TEXT,
    FOREIGN KEY (exercise_id) REFERENCES exercise(id)
);
""",
  """

INSERT INTO $movementTableName (name) VALUES
  ('flat chest press'),
  ('squats'),
  ('seated shoulder press'),
  ('standing military press'),
  ('preacher curls'),
  ('close grip bench'),
  ('dips');
""",
  """

INSERT INTO $muscleGroupTableName (name) VALUES
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
  (7, 5, 'primary');
""",
];
