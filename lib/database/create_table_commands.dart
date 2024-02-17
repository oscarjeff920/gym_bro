import 'package:gym_bro/database/tables/exercise/exercise_constants.dart' as exercise_consts;
import 'package:gym_bro/database/tables/exercise_set/exercise_set_constants.dart' as exercise_set_consts;
import 'package:gym_bro/database/tables/movement/movement_constants.dart' as movement_consts;
import 'package:gym_bro/database/tables/workout/workout_constants.dart' as workout_consts;
import 'package:gym_bro/database/tables/muscle_group/muscle_group_constants.dart' as muscle_group_consts;
import 'package:gym_bro/database/tables/movement_muscle_groups/movement_muscle_groups_constants.dart' as movement_muscle_groups_consts;

const SQL_CREATE_TABLE_COMMANDS = """
CREATE TABLE ${workout_consts.tableName} (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date TEXT NOT NULL,
    duration TEXT NOT NULL
);

CREATE TABLE ${exercise_consts.tableName} (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    movement_id INTEGER,
    workout_id INTEGER,
    exercise_order INTEGER NOT NULL,
    duration TEXT,
    num_working_sets INTEGER,
    FOREIGN KEY (movement_id) REFERENCES movement(id),
    FOREIGN KEY (workout_id) REFERENCES workout(id)
);

CREATE TABLE ${exercise_set_consts.tableName} (
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

CREATE TABLE ${movement_consts.tableName} (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
);

CREATE TABLE ${muscle_group_consts.tableName} (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
);

CREATE TABLE ${movement_muscle_groups_consts.tableName} (
    movement_id INTEGER,
    muscle_group_id INTEGER,
    role TEXT CHECK(role IN ('primary', 'secondary')), -- Add a role column
    FOREIGN KEY (movement_id) REFERENCES movement(id),
    FOREIGN KEY (muscle_group_id) REFERENCES muscle_group(id),
    PRIMARY KEY (movement_id, muscle_group_id) -- Primary key remains the same
);

INSERT INTO ${muscle_group_consts.tableName} (name) VALUES
  ('chest'),
  ('back'),
  ('shoulders),
  ('biceps'),
  ('triceps'),
  ('abs'),
  ('quads'),
  ('glutes'),
  ('hamstrings'),
  ('calves'),
  ('hip flexors'),
  ('legs');
  
""";