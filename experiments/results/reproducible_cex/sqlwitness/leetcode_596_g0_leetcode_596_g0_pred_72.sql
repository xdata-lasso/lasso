-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default1', 'default2'), ('default2', NULL), ('unique_2', NULL), ('unique_3', NULL), ('unique_4', 'default2'), ('unique_5', NULL), ('unique_6', NULL), ('unique_7', NULL), ('unique_8', NULL), ('unique_9', 'default1'), ('unique_10', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(*) >= 5;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CLASS FROM COURSES GROUP BY CLASS HAVING COUNT(CLASS) >= 5;

/*
Prediction Result:
*/