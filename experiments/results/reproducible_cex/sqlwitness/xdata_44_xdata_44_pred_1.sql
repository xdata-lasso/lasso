-- Schema DDL
CREATE TABLE classroom (building TEXT(15), room_number TEXT(7), capacity REAL(4, 0), PRIMARY KEY (building, room_number));

CREATE TABLE department (dept_name TEXT(20) PRIMARY KEY, building TEXT(15), budget REAL(12, 2) CHECK (budget > 0));

CREATE TABLE course (course_id TEXT(8) PRIMARY KEY, title TEXT(50), dept_name TEXT(20), credits REAL(2, 0) CHECK (credits > 0), FOREIGN KEY (dept_name) REFERENCES department (dept_name) ON delete SET NULL);

CREATE TABLE instructor (ID TEXT(5) PRIMARY KEY, name TEXT(20) NOT NULL, dept_name TEXT(20), salary REAL(8, 2) CHECK (salary > 29000), FOREIGN KEY (dept_name) REFERENCES department (dept_name) ON delete SET NULL);

CREATE TABLE section (course_id TEXT(8), sec_id TEXT(8), semester TEXT(6) CHECK (semester IN ('Fall', 'Winter', 'Spring', 'Summer')), year REAL(4, 0) CHECK (year > 1701 AND year < 2100), building TEXT(15), room_number TEXT(7), time_slot_id TEXT(4), PRIMARY KEY (course_id, sec_id, semester, year), FOREIGN KEY (course_id) REFERENCES course (course_id) ON delete CASCADE, FOREIGN KEY (building, room_number) REFERENCES classroom (building, room_number) ON delete SET NULL);

CREATE TABLE teaches (ID TEXT(5), course_id TEXT(8), sec_id TEXT(8), semester TEXT(6), year REAL(4, 0), PRIMARY KEY (ID, course_id, sec_id, semester, year), FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES section (course_id, sec_id, semester, year) ON delete CASCADE, FOREIGN KEY (ID) REFERENCES instructor (ID) ON delete CASCADE);

CREATE TABLE student (ID TEXT(5) PRIMARY KEY, name TEXT(20) NOT NULL, dept_name TEXT(20), tot_cred REAL(3, 0) CHECK (tot_cred >= 0), FOREIGN KEY (dept_name) REFERENCES department (dept_name) ON delete SET NULL);

CREATE TABLE takes (ID TEXT(5), course_id TEXT(8), sec_id TEXT(8), semester TEXT(6), year REAL(4, 0), grade TEXT(2), PRIMARY KEY (ID, course_id, sec_id, semester, year), FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES section (course_id, sec_id, semester, year) ON delete CASCADE, FOREIGN KEY (ID) REFERENCES student (ID) ON delete CASCADE);

CREATE TABLE advisor (s_ID TEXT(5) PRIMARY KEY, i_ID TEXT(5), FOREIGN KEY (i_ID) REFERENCES instructor (ID) ON delete SET NULL, FOREIGN KEY (s_ID) REFERENCES student (ID) ON delete CASCADE);

CREATE TABLE time_slot (time_slot_id TEXT(4), day TEXT(1), start_hr REAL(2) CHECK (start_hr >= 0 AND start_hr < 24), start_min REAL(2) CHECK (start_min >= 0 AND start_min < 60), end_hr REAL(2) CHECK (end_hr >= 0 AND end_hr < 24), end_min REAL(2) CHECK (end_min >= 0 AND end_min < 60), PRIMARY KEY (time_slot_id, day, start_hr, start_min));

CREATE TABLE prereq (course_id TEXT(8), prereq_id TEXT(8), PRIMARY KEY (course_id, prereq_id), FOREIGN KEY (course_id) REFERENCES course (course_id) ON delete CASCADE, FOREIGN KEY (prereq_id) REFERENCES course (course_id));

CREATE TABLE grade_value (grade TEXT(2) PRIMARY KEY, value REAL(4, 2));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO department (dept_name, building, budget) VALUES ('Spring', 'Spring', NULL), ('default2', 'Spring', NULL), ('default1', NULL, NULL), ('unique_3', 'default2', 1.0), ('unique_4', 'default2', NULL), ('unique_5', NULL, 1.0), ('unique_6', 'default1', 1.0), ('unique_7', 'default1', NULL), ('unique_8', NULL, NULL), ('unique_9', 'Spring', 1.0), ('unique_10', NULL, NULL), ('unique_11', NULL, NULL), ('unique_12', 'Spring', NULL), ('unique_13', 'Spring', 1.0), ('unique_14', 'default1', NULL), ('unique_15', NULL, 1.0), ('unique_16', 'default1', 1.0);
INSERT INTO instructor (id, dept_name, name, salary) VALUES ('default1', 'unique_5', 'default2', 29001), ('default2', 'unique_5', 'default2', 29001), ('Spring', 'default1', 'Spring', NULL), ('unique_3', 'default2', 'default2', NULL);
INSERT INTO classroom (building, room_number, capacity) VALUES ('default2', 'default1', NULL), ('Spring', 'default1', 0.0), ('unique_str_7423', 'unique_str_1992', 1.0), ('default1', 'default1', 0.0), ('Spring', 'default2', 1.0), ('Spring', 'Spring', 0.0), ('default2', 'default2', NULL), ('default2', 'Spring', 0.0), ('default1', 'default2', NULL), ('unique_str_7423', 'unique_str_7423', 1.0), ('default1', 'Spring', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM instructor WHERE EXISTS(SELECT * FROM teaches INNER JOIN section ON (teaches.course_id = section.course_id AND teaches.sec_id = section.sec_id AND teaches.semester = section.semester AND teaches.year = section.year) WHERE instructor.ID = teaches.ID AND teaches.semester = 'Spring');

/*
Gold Result:
*/

-- Prediction Query
SELECT name FROM instructor WHERE NOT EXISTS(SELECT * FROM teaches NATURAL JOIN instructor WHERE instructor.ID = teaches.ID AND teaches.semester = 'Spring');

/*
Prediction Result:
('default2',)
('default2',)
('Spring',)
('default2',)
*/