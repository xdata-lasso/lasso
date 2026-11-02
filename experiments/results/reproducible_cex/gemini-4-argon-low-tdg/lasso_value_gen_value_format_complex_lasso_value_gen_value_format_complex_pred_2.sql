-- Schema DDL
CREATE TABLE course (id INTEGER PRIMARY KEY, name TEXT, start_date DATE, enrollment INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO course (id, name, start_date, enrollment) VALUES (1, 'CS101', '2023-01-01', 30);
INSERT INTO course (id, name, start_date, enrollment) VALUES (2, 'CS102', '2023-01-01', 31);
INSERT INTO course (id, name, start_date, enrollment) VALUES (3, 'CS103', '2023-01-02', 30);
INSERT INTO course (id, name, start_date, enrollment) VALUES (4, 'CS104', '2023-01-02', 31);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM course WHERE start_date > '2023-01-01' AND enrollment > 30;

/*
Gold Result:
('CS104',)
*/

-- Prediction Query
SELECT name FROM course WHERE start_date > '01-01-2023' AND enrollment > 30;

/*
Prediction Result:
('CS102',)
('CS104',)
*/