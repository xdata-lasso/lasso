-- Schema DDL
CREATE TABLE course (id INTEGER PRIMARY KEY, name TEXT, start_date DATE, enrollment INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO course (id, name, start_date, enrollment) VALUES (1, 'Course_Exact_Boundary_Both', '2023-01-01', 30);
INSERT INTO course (id, name, start_date, enrollment) VALUES (2, 'Course_Date_Boundary_Valid_Enrollment', '2023-01-01', 31);
INSERT INTO course (id, name, start_date, enrollment) VALUES (3, 'Course_Valid_Date_Enrollment_Boundary', '2023-01-02', 30);
INSERT INTO course (id, name, start_date, enrollment) VALUES (4, 'Course_Valid_Both_Just_Above', '2023-01-02', 31);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM course WHERE start_date > '2023-01-01' AND enrollment > 30;

/*
Gold Result:
('Course_Valid_Both_Just_Above',)
*/

-- Prediction Query
SELECT name FROM course WHERE start_date > '01-01-2023' AND enrollment > 30;

/*
Prediction Result:
('Course_Date_Boundary_Valid_Enrollment',)
('Course_Valid_Both_Just_Above',)
*/