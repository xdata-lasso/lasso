-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default1', 'default1'), ('default2', NULL), ('unique_2', NULL), ('unique_3', 'default2'), ('unique_4', 'default2'), ('unique_5', 'default2'), ('unique_6', 'default1'), ('unique_7', NULL), ('unique_8', NULL), ('unique_9', NULL), ('unique_10', 'default1'), ('unique_11', 'default2'), ('unique_12', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
*/

-- Prediction Query
SELECT CLASS FROM (SELECT DISTINCT * FROM COURSES) AS SUB GROUP BY CLASS HAVING COUNT(*) >= 5;

/*
Prediction Result:
(None,)
*/