-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', 'default1'), ('default1', NULL), ('unique_2', NULL), ('unique_3', NULL), ('unique_4', NULL), ('unique_5', 'default2'), ('unique_6', 'default2'), ('unique_7', NULL), ('unique_8', 'default2'), ('unique_9', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(*) >= 5;

/*
Gold Result:
(None,)
*/

-- Prediction Query
WITH AGG AS (SELECT CLASS, COUNT(CLASS) AS NUMBER FROM COURSES GROUP BY CLASS) SELECT CLASS FROM AGG WHERE NUMBER >= 5;

/*
Prediction Result:
*/