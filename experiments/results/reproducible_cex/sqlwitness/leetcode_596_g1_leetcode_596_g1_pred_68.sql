-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default1', 'default1'), ('default2', NULL), ('unique_2', NULL), ('unique_3', 'default1'), ('unique_4', 'default1'), ('unique_5', NULL), ('unique_6', NULL), ('unique_7', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
*/

-- Prediction Query
WITH C AS (SELECT DISTINCT * FROM COURSES) SELECT CLASS FROM C GROUP BY CLASS HAVING COUNT(STUDENT) >= 5;

/*
Prediction Result:
(None,)
*/