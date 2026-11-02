-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default1', 'default1'), ('default2', NULL), ('unique_2', 'default2'), ('unique_3', 'default2'), ('unique_4', NULL), ('unique_5', 'default1'), ('unique_6', NULL), ('unique_7', 'default1'), ('unique_8', 'default2'), ('unique_9', NULL), ('unique_10', 'default2'), ('unique_11', NULL), ('unique_12', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT CLASS FROM (SELECT CLASS, COUNT(1) AS W FROM COURSES GROUP BY CLASS) AS L WHERE W >= 5;

/*
Prediction Result:
(None,)
('default2',)
*/