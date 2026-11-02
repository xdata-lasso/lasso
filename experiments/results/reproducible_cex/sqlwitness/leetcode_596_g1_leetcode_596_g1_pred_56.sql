-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default1', 'default1'), ('default2', NULL), ('unique_2', 'default2'), ('unique_3', 'default1'), ('unique_4', NULL), ('unique_5', NULL), ('unique_6', 'default2'), ('unique_7', 'default1'), ('unique_8', NULL), ('unique_9', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
*/

-- Prediction Query
SELECT CLASS FROM (SELECT CLASS, COUNT(DISTINCT (STUDENT)) AS MYCOUNT FROM COURSES GROUP BY CLASS) AS A WHERE MYCOUNT >= 5;

/*
Prediction Result:
(None,)
*/