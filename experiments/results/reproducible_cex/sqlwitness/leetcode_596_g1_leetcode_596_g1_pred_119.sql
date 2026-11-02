-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default1', 'default1'), ('default2', 'default2'), ('unique_2', NULL), ('unique_3', NULL), ('unique_4', NULL), ('unique_5', NULL), ('unique_6', 'default2'), ('unique_7', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
*/

-- Prediction Query
SELECT CLASS FROM (SELECT CLASS, COUNT(STUDENT) AS T FROM COURSES GROUP BY CLASS) AS T1 WHERE T >= 5;

/*
Prediction Result:
(None,)
*/