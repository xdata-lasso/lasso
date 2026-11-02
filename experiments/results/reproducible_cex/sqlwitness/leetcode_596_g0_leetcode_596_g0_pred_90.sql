-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', NULL), ('default1', 'default1'), ('unique_2', 'default1'), ('unique_3', 'default1'), ('unique_4', NULL), ('unique_5', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(*) >= 5;

/*
Gold Result:
*/

-- Prediction Query
SELECT COURSES.CLASS FROM COURSES GROUP BY COURSES.CLASS HAVING COUNT(DISTINCT STUDENT) >= 4;

/*
Prediction Result:
('default1',)
*/