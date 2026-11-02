-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO courses (student, class) VALUES ('s1', 'Class4');
INSERT INTO courses (student, class) VALUES ('s2', 'Class4');
INSERT INTO courses (student, class) VALUES ('s3', 'Class4');
INSERT INTO courses (student, class) VALUES ('s4', 'Class4');
INSERT INTO courses (student, class) VALUES ('s5', 'Class5');
INSERT INTO courses (student, class) VALUES ('s6', 'Class5');
INSERT INTO courses (student, class) VALUES ('s7', 'Class5');
INSERT INTO courses (student, class) VALUES ('s8', 'Class5');
INSERT INTO courses (student, class) VALUES ('s9', 'Class5');
INSERT INTO courses (student, class) VALUES ('s10', 'Class6');
INSERT INTO courses (student, class) VALUES ('s11', 'Class6');
INSERT INTO courses (student, class) VALUES ('s12', 'Class6');
INSERT INTO courses (student, class) VALUES ('s13', 'Class6');
INSERT INTO courses (student, class) VALUES ('s14', 'Class6');
INSERT INTO courses (student, class) VALUES ('s15', 'Class6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
('Class5',)
('Class6',)
*/

-- Prediction Query
SELECT CLASS FROM COURSES GROUP BY CLASS HAVING COUNT(CLASS) > 1;

/*
Prediction Result:
('Class4',)
('Class5',)
('Class6',)
*/