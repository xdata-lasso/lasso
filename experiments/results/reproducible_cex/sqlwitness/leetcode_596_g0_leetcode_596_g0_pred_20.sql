-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default1', NULL), ('_', NULL), ('default2', '_'), ('unique_3', NULL), ('unique_4', 'default1'), ('unique_5', 'default1'), ('unique_6', 'default1'), ('unique_7', NULL), ('unique_8', 'default1'), ('unique_9', 'default2'), ('unique_10', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(*) >= 5;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CLASS FROM (SELECT CLASS, COUNT(*) AS COUNTER FROM (SELECT DISTINCT STUDENT || '_' || CLASS AS DIS, CLASS FROM COURSES) AS SUB GROUP BY CLASS) AS RESULT WHERE COUNTER >= 5;

/*
Prediction Result:
*/