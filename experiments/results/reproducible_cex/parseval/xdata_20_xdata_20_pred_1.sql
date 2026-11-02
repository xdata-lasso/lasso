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
-- Inserting into table: department --
INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('cou_e556db', 'dep_f0958c', 0.01);

INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('A', 'dep_f0958c', 0.02);

INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('dep_7d90e9', 'dep_f0958c', 0.03);

INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('C', 'dep_f0958c', 0.04);

INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('G', 'dep_f0958c', 0.05);

INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('@', 'dep_f0958c', 0.06);

INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('O', 'dep_f0958c', 0.07);

INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('B', 'dep_f0958c', 0.08);

INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('H', 'dep_f0958c', 0.09);

INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('"', 'dep_f0958c', 0.1);

INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('I', 'dep_f0958c', 0.11);

INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('D', 'dep_f0958c', 0.12);

INSERT INTO "department" ("dept_name", "building", "budget") VALUES ('F', 'dep_f0958c', 0.13);

-- Inserting into table: course --
INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES ('course_1', 'cou_aa4396', 'cou_e556db', NULL);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES ('course_2', 'cou_aa4396', 'cou_e556db', NULL);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES ('course_3', 'cou_aa4396', 'cou_e556db', NULL);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES ('course_4', 'cou_aa4396', 'cou_e556db', NULL);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES ('A', 'cou_aa4396', 'C', 4.0);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES ('course_6', 'cou_aa4396', 'cou_e556db', 4.0);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES ('I', 'cou_aa4396', 'G', 4.0);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES ('course_8', 'cou_aa4396', 'cou_e556db', 4.0);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES ('@', 'cou_aa4396', '@', 4.0);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES ('cours_10', 'cou_aa4396', 'cou_e556db', 4.0);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES ('B', 'cou_aa4396', 'O', 4.0);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES ('cours_12', 'cou_aa4396', 'cou_e556db', 4.0);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES ('J', 'cou_aa4396', 'B', 4.0);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES ('cours_14', 'cou_aa4396', 'cou_e556db', 4.0);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES ('H', 'cou_aa4396', 'H', 4.0);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES ('cours_16', 'cou_aa4396', 'cou_e556db', 4.0);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES ('L', 'cou_aa4396', '"', 4.0);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES ('cours_18', 'cou_aa4396', 'cou_e556db', 4.0);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES ('b', 'cou_aa4396', 'I', 4.0);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES ('cours_20', 'cou_aa4396', 'cou_e556db', 4.0);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES ('c', 'cou_aa4396', 'D', 4.0);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES ('cours_22', 'cou_aa4396', 'cou_e556db', 4.0);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES ('Q', 'cou_aa4396', 'F', 4.0);

INSERT INTO "course" ("course_id", "title", "dept_name", "credits") VALUES ('cours_24', 'cou_aa4396', 'cou_e556db', 4.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT dept_name, SUM(credits) FROM course INNER JOIN department USING (dept_name) WHERE credits >= 4 GROUP BY dept_name HAVING SUM(credits) < 25;

/*
Gold Result:
('"', 4.0)
('@', 4.0)
('B', 4.0)
('C', 4.0)
('D', 4.0)
('F', 4.0)
('G', 4.0)
('H', 4.0)
('I', 4.0)
('O', 4.0)
*/

-- Prediction Query
SELECT dept_name, SUM(credits) FROM course INNER JOIN department USING (dept_name) WHERE credits >= 4 GROUP BY dept_name HAVING SUM(credits) = 25;

/*
Prediction Result:
*/