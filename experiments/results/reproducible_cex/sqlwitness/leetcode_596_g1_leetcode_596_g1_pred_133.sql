-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', 'default2'), ('default1', NULL), ('unique_2', 'default1'), ('unique_3', NULL), ('unique_4', NULL), ('unique_5', NULL), ('unique_6', 'default2'), ('unique_7', NULL), ('unique_8', 'default1'), ('unique_9', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
*/

-- Prediction Query
SELECT CLASS FROM (SELECT CLASS, COUNT(STUDENT) AS NUM FROM COURSES GROUP BY CLASS) AS TEMP WHERE NUM >= 5;

/*
Prediction Result:
(None,)
*/