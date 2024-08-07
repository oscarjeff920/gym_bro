
import 'package:gym_bro/data_models/database_data_models/tables/table_constants.dart';

const SQL_CREATE_TABLE_COMMANDS = [
  """
CREATE TABLE $workoutTableName (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    year INTEGER NOT NULL,
    month INTEGER NOT NULL,
    day INTEGER NOT NULL,
    start_time TEXT,
    duration TEXT
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
    name TEXT UNIQUE NOT NULL
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
    movement_id INTEGER NOT NULL,
    workout_id INTEGER NOT NULL,
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
    exercise_id INTEGER NOT NULL,
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
  ('seated row machine (downstairs)'),
  ('front raises'),
  
  ('vertical row');
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
  (29, 4, 'secondary'),
  (30, 3, 'primary'),
  
  (31, 3, 'primary'),
  (31, 4, 'secondary')
  ;
""",
  """
  INSERT INTO $workoutTableName(year, month, day, duration) VALUES
  (2023, 12, 29, '01:36:00'),
  (2023, 12, 23, null),
  (2024, 01, 07, null),
  (2024, 01, 10, null),
    (2024, 01, 14, null)
  ;
  """,
  """
  INSERT INTO $exerciseTableName
  (movement_id, workout_id, exercise_order, duration, num_working_sets) VALUES
  
  (4 , 1, 1, '30:00', 6),
  (15, 1, 2, '13:00', 3),
  (3 , 1, 3, null   , 5),
  (17, 1, 4, null   , 5),
  
    (9, 2, 1, null, 4),
  (8, 2, 2, null, 3),
  (4, 2, 3, null, 3),
  (19, 2, 4, null, 5),
  (11, 2, 5, null, 4),
  
    (4, 3, 1, null, 6),
  (2, 3, 2, null, 4),
  (3, 3, 3, null, 4),
  (18, 3, 4, null, 3),
  (20, 3, 5, null, 2),
    (19, 3, 6, null, 5),
    
  (16, 4, 1, null, 6),
  (21, 4, 2, null, 6),
  (22, 4, 3, null, 6),
  (15, 4, 4, null, 6),
    (27, 4, 5, null, 4),
  (6, 4, 6, null, 4),
  
  (3, 5, 1, null, 7),
  (18, 5, 2, null, 6),
  (30, 5, 3, null, 6),
    (31, 5, 4, null, 4),
  (10, 5, 5, null, 4); 
  """,
  """
  INSERT INTO $exerciseSetTableName
  (exercise_id, set_order, is_warm_up, weight, reps, extra_reps, duration, notes) VALUES
  
  (1, 1, 1, 20, 12, null, null, null),
  (1, 2, 1, 30, 12, null, null, 'becoming tricky'),
  (1, 3, 0, 40, 6, null, null, 'hard'),
  (1, 4, 0, 40, 4, null, null, null),
    (1, 5, 0, 40, 5, 1, null, 'better after longer break'),
  (1, 6, 0, 40, 4, 2, '02:00', null),
  (1, 7, 0, 40, 5, 1, '02:00', null),
  (1, 8, 0, 30, 5, 2, '03:00', null),
    
  (2, 1, 1, 24, 10, null, '01:00', null),
(2, 2, 0, 28, 6, null, '02:00', null),
  (2, 3, 0, 30, 6, null, '02:00', null),
  (2, 4, 0, 30, 2, null, '01:00', null),
    
  (3, 1, 0, 16, 8, null, '01:00', null),
  (3, 2, 0, 16, 8, null, '01:00', null),
    (3, 3, 0, 16, 6, null, null, 'slow'),
  (3, 4, 0, 16, 4, 2, null, 'slow'),
  (3, 5, 0, 16, 4, 2, null, 'slow'),
    
  (4, 1, 1, 8, 10, null, '02:00', 'form didnt feel great'),
  (4, 2, 0, 8, 10, null, '02:00', 'fine but last two'),
(4, 3, 0, 8, 8, null, null, 'not full ROM drop weight'),
  (4, 4, 0, 6, 12, null, null, 'felt much better'),
  (4, 5, 0, 6, 10, null, null, 'feeling better, had to cheat on last two'),
    
    
  (5, 1, 1, 50, 8, null, null, null),
  (5, 2, 0, 70, 8, null, null, null),
    (5, 3, 0, 70, 8, null, null, 'tired'),
  (5, 4, 0, 90, 8, null, null, 'tired'),
  (5, 5, 0, 90, 4, null, null, 'ok'),
    
  (6, 1, 1, 20, 10, null, null, 'challenging'),
  (6, 2, 0, 30, 6, null, null, 'challenging, but better'),
(6, 3, 0, 30, 6, null, null, 'hard, tired, needed rest'),
    
  (7, 1, 1, 30, 12, null, null, 'warm'),
  (7, 2, 0, 40, 4, null, null, '5 to failure'),
  (7, 3, 0, 40, 4, null, null, '5 to fail'),
  (7, 4, 0, 40, 4, null, null, '5 to fail'),
    
    (8, 1, 1, 15, 12, null, null, null),
  (8, 2, 0, 25, 2, null, null, '3 to fail'),
  (8, 3, 0, 20, 6, null, null, 'good weight'),
  (8, 4, 0, 20, 5, null, null, '6 to fail'),
  (8, 5, 0, 20, 6, null, null, 'gassed out'),
(8, 6, 0, 20, 4, 2, null, '5 to fail'),
    
  (9, 1, 1, 0, 12, null, null, null),
  (9, 2, 0, 10, 8, null, null, 'near failure'),
  (9, 3, 0, 10, 8, null, null, 'form breakdown 2nd to last'),
  (9, 4, 0, 10, 8, null, null, 'noticed right leg dominance'),
    (9, 5, 0, 10, 8, null, null, 'better'),
    
    
  (10, 1, 1, 20, 12, null, null, null),
  (10, 2, 1, 30, 8, null, null, null),
  (10, 3, 0, 40, 4, null, null, null),
  (10, 4, 0, 40, 4, null, null, 'hard'),
(10, 5, 0, 40, 2, null, null, null),
  (10, 6, 0, 30, 6, null, null, 'super close grip'),
  (10, 7, 0, 30, 6, null, null, 'super close grip'),
  (10, 8, 0, 30, 6, null, null, 'super close grip'),
    
  (11, 1, 1, 30, 6, null, null, null),
    (11, 2, 0, 50, 6, null, null, null),
  (11, 3, 0, 50, 6, null, null, 'stripper pop up last two reps'),
  (11, 4, 0, 50, 6, null, null, 'form funny from rep 5'),
  (11, 5, 0, 30, 6, null, null, 'powerful concentric'),
    
  (12, 1, 1, 16, 8, null, null, null),
(12, 2, 0, 18, 8, null, null, null),
  (12, 3, 0, 20, 5, 1, null, null),
  (12, 4, 0, 20, 4, 2, null, null),
  (12, 5, 0, 20, 4, 1, null, null),
    
  (13, 1, 1, 3.4, 12, null, null, null),
    (13, 2, 1, 5.7, 6, null, null, 'form felt off'),
  (13, 3, 0, 3.4, 8, null, null, 'felt better'),
  (13, 4, 0, 3.4, 8, null, null, 'good'),
  (13, 5, 0, 3.4, 8, null, null, null),
    
  (14, 1, 1, 3.4, 12, null, null, null),
(14, 2, 1, 5.7, 4, null, null, null),
  (14, 3, 0, 3.4, 8, null, null, null),
  (14, 4, 0, 3.4, 8, null, null, null),
    
  (15, 1, 1, 10, 8, null, null, null),
  (15, 2, 0, 15, 5, 0, null, null),
    (15, 3, 0, 15, 4, 2, null, null),
  (15, 4, 0, 15, 4, 1, null, null),
  (15, 5, 0, 15, 2, 0, null, null),
  (15, 6, 1, 10, 4, null, null, null),
  (15, 7, 0, 10, 6, 4, null, null),
    
    
(16, 1, 1, 22, 12, null, null, 'ez'),
  (16, 2, 0, 24, 7, 2, null, null),
  (16, 3, 0, 26, 3, 2, null, null),
  (16, 4, 0, 24, 4, 1, null, null),
  (16, 5, 0, 24, 4, 2, null, null),
    (16, 6, 0, 24, 3, 2, null, null),
  (16, 7, 0, 24, 4, 1, null, null),
    
  (17, 1, 1, 12, 12, null, null, null),
  (17, 2, 0, 14, 12,  null, null, null),
  (17, 3, 0, 14, 8, null, null, 'felt better stretch'),
(17, 4, 0, 14, 8, 2, null, null),
  (17, 5, 0, 14, 8, 4, null, null),
  (17, 6, 0, 14, 8, 4, null, null),
  (17, 7, 0, 14, 7, 3, null, null),
    
  (18, 1, 1, 7, 8, null, null, 'felt RHS more'),
    (18, 2, 0, 7, 12, null, null, null),
  (18, 3, 0, 8, 12, null, null, 'LHS elbow flared too much'),
  (18, 4, 0, 8, 8, 2, null, null),
  (18, 5, 0, 8, 6, 4, null, null),
  (18, 6, 0, 8, 7, 2, null, null),
(18, 7, 0, 8, 7, 2, null, null),
    
  (19, 1, 0, 24, 4, null, null, null),
  (19, 2, 0, 24, 4, null, null, 'triceps giving out'),
  (19, 3, 0, 24, 3, 1, null, null),
  (19, 4, 0, 22, 4, 2, null, null),
    (19, 5, 0, 22, 3, 2, null, null),
  (19, 6, 0, 22, 4, 2, null, null),
  (19, 7, 1, 18, 8, null, null, null),
    
  (20, 1, 0, 15, 4, null, null, null),
  (20, 2, 0, 10, 10, null, null, null),
(20, 3, 0, 10, 8, null, null, null),
  (20, 4, 0, 10, 12, null, null, null),
    
  (21, 1, 0, 15, 4, null, null, null),
  (21, 2, 0, 10, 10, null, null, null),
  (21, 3, 0, 10, 8, null, null, null),
    (21, 4, 0, 10, 12, null, null, null),
    
    
  (22, 1, 1, 16, 8, null, null, 'shoulders clicking'),
  (22, 2, 1, 16, 8, null, null, null),
  (22, 3, 0, 20, 6, null, null, null),
  (22, 4, 0, 20, 4, 1, null, null),
(22, 5, 0, 20, 4, 2, null, null),
  (22, 6, 0, 20, 4, 2, null, null),
  (22, 7, 0, 20, 3, 1, null, null),
  (22, 8, 0, 18, 4, 1, null, null),
  (22, 9, 0, 18, 6, 3, null, null),
    (22, 10, 1, 14, 6, 4, null, null),
    
  (23, 1, 1, 4.5, 12, null, null, null),
  (23, 2, 0, 6.8, 8, null, null, null),
  (23, 3, 0, 6.8, 8, null, null, null),
  (23, 4, 0, 6.8, 8, null, null, null),
(23, 5, 0, 6.8, 7, null, null, null),
  (23, 6, 0, 6.8, 7, 1, null, null),
    
  (24, 1, 0, 10, 6, null, null, null),
  (24, 2, 0, 10, 6, null, null, null),
  (24, 3, 0, 10, 8, 2, null, null),
    (24, 4, 0, 10, 8, 2, null, null),
  (24, 5, 0, 10, 8, 4, null, null),
  (24, 6, 0, 10, 10, 4, null, null),
    
  (25, 1, 1, 6, 12, null, null, null),
  (25, 2, 1, 6, 12, null, null, null),
(25, 3, 0, 8, 8, null, null, null),
  (25, 4, 0, 8, 8, null, null, null),
  (25, 5, 0, 8, 8, null, null, null),
  (25, 6, 0, 8, 8, 4, null, null),
    
  (26, 1, 0, 10, 8, null, null, 'failed on 9'),
    (26, 2, 0, 10, 6, null, null, null),
  (26, 3, 0, 10, 4, 2, null, null),
  (26, 4, 0, 10, 4, 2, null, null);  

  """,
];

String convertDartCommandsToSQL (String dartSQL) {
  return dartSQL;
}

main () {
  for (var input in SQL_CREATE_TABLE_COMMANDS) {
    print(input);
  }
  // print("""SELECT $exerciseTableName.id AS id,
  //     $exerciseTableName.exercise_order AS exercise_order,
  //     $movementTableName.name AS movement_name,
  //     $exerciseTableName.movement_id AS movement_id,
  //     $exerciseTableName.duration AS exercise_duration,
  //     $exerciseTableName.num_working_sets AS num_working_sets,
  //     $muscleGroupTableName.name as primary_muscle_group_name
  //   FROM $exerciseTableName
  //   JOIN $movementTableName ON $exerciseTableName.movement_id = $movementTableName.id
  //   JOIN $movementMuscleGroupsTableName ON $movementTableName.id = $movementMuscleGroupsTableName.movement_id
  //   JOIN $muscleGroupTableName ON $movementMuscleGroupsTableName.muscle_group_id = $muscleGroupTableName.id
  //   WHERE $exerciseTableName.workout_id = INSERT AND $movementMuscleGroupsTableName.role = 'primary'
  //   ORDER BY $exerciseTableName.exercise_order ASC;
  //   """);
}