-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default1', NULL), ('default2', NULL), ('unique_2', 'default1'), ('unique_3', NULL), ('unique_4', NULL), ('unique_5', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(*) >= 5;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT T1.CLASS FROM (SELECT STUDENT, CLASS FROM COURSES GROUP BY STUDENT, CLASS) AS T1 GROUP BY T1.CLASS HAVING COUNT(CLASS) >= 5;

/*
Prediction Result:
*/