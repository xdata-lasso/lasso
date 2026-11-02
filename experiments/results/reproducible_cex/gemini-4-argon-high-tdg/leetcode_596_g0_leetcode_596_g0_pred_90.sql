-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO courses (student, class) VALUES ('s1', 'Math');
INSERT INTO courses (student, class) VALUES ('s2', 'Math');
INSERT INTO courses (student, class) VALUES ('s3', 'Math');
INSERT INTO courses (student, class) VALUES ('s4', 'Math');
INSERT INTO courses (student, class) VALUES ('s5', 'English');
INSERT INTO courses (student, class) VALUES ('s6', 'English');
INSERT INTO courses (student, class) VALUES ('s7', 'English');
INSERT INTO courses (student, class) VALUES ('s8', 'English');
INSERT INTO courses (student, class) VALUES ('s9', 'English');
INSERT INTO courses (student, class) VALUES ('s10', 'Science');
INSERT INTO courses (student, class) VALUES ('s11', 'Science');
INSERT INTO courses (student, class) VALUES ('s12', 'Science');
INSERT INTO courses (student, class) VALUES ('s13', 'Science');
INSERT INTO courses (student, class) VALUES ('s14', 'Science');
INSERT INTO courses (student, class) VALUES ('s15', 'Science');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(*) >= 5;

/*
Gold Result:
('English',)
('Science',)
*/

-- Prediction Query
SELECT COURSES.CLASS FROM COURSES GROUP BY COURSES.CLASS HAVING COUNT(DISTINCT STUDENT) >= 4;

/*
Prediction Result:
('English',)
('Math',)
('Science',)
*/