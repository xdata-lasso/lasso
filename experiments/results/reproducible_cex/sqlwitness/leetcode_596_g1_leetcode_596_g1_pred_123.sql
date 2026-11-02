-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', NULL), ('default1', NULL), ('unique_2', NULL), ('unique_3', NULL), ('unique_4', NULL), ('unique_5', 'default2'), ('unique_6', 'default2'), ('unique_7', 'default1'), ('unique_8', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
*/

-- Prediction Query
SELECT CLASS FROM (SELECT CLASS, COUNT(*) FROM COURSES GROUP BY CLASS HAVING COUNT(*) >= 5) AS B;

/*
Prediction Result:
(None,)
*/