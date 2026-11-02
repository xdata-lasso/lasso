-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default1', NULL), ('default2', NULL), ('unique_2', 'default1'), ('unique_3', 'default2'), ('unique_4', NULL), ('unique_5', 'default2'), ('unique_6', NULL), ('unique_7', 'default2'), ('unique_8', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
*/

-- Prediction Query
SELECT CLASS FROM (SELECT CLASS, COUNT(DISTINCT STUDENT) AS STUDENTS FROM COURSES GROUP BY 1 HAVING COUNT(DISTINCT STUDENT) >= 5) AS IO;

/*
Prediction Result:
(None,)
*/