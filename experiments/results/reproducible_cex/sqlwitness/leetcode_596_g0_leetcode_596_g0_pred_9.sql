-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', 'default2'), ('default1', 'default2'), ('unique_2', 'default2'), ('unique_3', 'default1'), ('unique_4', NULL), ('unique_5', 'default2'), ('unique_6', NULL), ('unique_7', NULL), ('unique_8', 'default2'), ('unique_9', NULL), ('unique_10', NULL), ('unique_11', 'default1'), ('unique_12', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(*) >= 5;

/*
Gold Result:
(None,)
('default2',)
*/

-- Prediction Query
SELECT CLASS FROM (SELECT DISTINCT CLASS, STUDENT FROM COURSES) AS T GROUP BY CLASS HAVING COUNT(CLASS) >= 5;

/*
Prediction Result:
('default2',)
*/