-- Schema DDL
CREATE TABLE course (id INTEGER PRIMARY KEY, name TEXT, start_date DATE, enrollment INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO course (id, name, start_date, enrollment) VALUES (1, 'Intro to CS', '2023-01-02', 31);
INSERT INTO course (id, name, start_date, enrollment) VALUES (2, 'Data Structures', '2023-01-01', 31);
INSERT INTO course (id, name, start_date, enrollment) VALUES (3, 'Operating Systems', '2023-01-02', 30);
INSERT INTO course (id, name, start_date, enrollment) VALUES (4, 'Discrete Math', '2022-12-31', 29);
INSERT INTO course (id, name, start_date, enrollment) VALUES (5, 'Linear Algebra', '2023-01-01', 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM course WHERE start_date > '2023-01-01' AND enrollment > 30;

/*
Gold Result:
('Intro to CS',)
*/

-- Prediction Query
SELECT name FROM course WHERE start_date > '01/01/23' AND enrollment > 30;

/*
Prediction Result:
('Intro to CS',)
('Data Structures',)
*/