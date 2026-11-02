-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', 'default2'), ('default1', 'default1'), ('unique_2', 'default2'), ('unique_3', 'default2'), ('unique_4', NULL), ('unique_5', NULL), ('unique_6', NULL), ('unique_7', 'default1'), ('unique_8', NULL), ('unique_9', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
*/

-- Prediction Query
WITH AGG AS (SELECT CLASS, COUNT(*) AS "1A" FROM COURSES GROUP BY CLASS) SELECT CLASS FROM AGG WHERE "1A" >= 5;

/*
Prediction Result:
(None,)
*/