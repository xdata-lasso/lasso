-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', NULL), ('default1', NULL), ('unique_2', NULL), ('unique_3', NULL), ('unique_4', NULL), ('unique_5', NULL), ('unique_6', 'default2'), ('unique_7', 'default1'), ('unique_8', NULL), ('unique_9', NULL), ('unique_10', 'default2'), ('unique_11', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
*/

-- Prediction Query
SELECT CLASS FROM COURSES GROUP BY CLASS HAVING COUNT(1) >= 5;

/*
Prediction Result:
(None,)
*/