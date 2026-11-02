-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default1', 'default2'), ('default2', 'default1'), ('unique_2', 'default2'), ('unique_3', NULL), ('unique_4', NULL), ('unique_5', NULL), ('unique_6', NULL), ('unique_7', 'default1'), ('unique_8', 'default2'), ('unique_9', NULL), ('unique_10', NULL), ('unique_11', NULL), ('unique_12', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(*) >= 5;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT TB1.CLASS AS CLASS FROM (SELECT CLASS, COUNT(CLASS) AS CNT FROM COURSES GROUP BY CLASS) AS TB1 WHERE CNT >= 5;

/*
Prediction Result:
*/