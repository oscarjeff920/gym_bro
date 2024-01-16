const SQL_CREATE_TABLE_COMMANDS = """
CREATE TABLE workout(
id INTEGER PRIMARY KEY,
    date DATE,
duration TIME
);

CREATE TABLE movement (
id INTEGER PRIMARY KEY,
name STRING,
main_muscle STRING
);

CREATE INDEX name_index
ON movement(name);

CREATE INDEX muscle_index
ON movement(main_muscle);

CREATE TABLE exersize (
id INTEGER PRIMARY KEY,
movement_id INTEGER FORIEGN KEY REFERENCES movement (movement_id),
workout_id INTEGER FORIEGN KEY REFERENCES workout (workout_id)
);

CREATE TABLE sets (
id INTEGER PRIMARY KEY,
weight INTEGER,
reps INTEGER,
superset_reps INTEGER,
time_taken TIME,
exersize_id INTEGER FORIEGN KEY REFERENCES exersize (exersize_id)
);

CREATE INDEX weight_index
ON sets(weight);
""";