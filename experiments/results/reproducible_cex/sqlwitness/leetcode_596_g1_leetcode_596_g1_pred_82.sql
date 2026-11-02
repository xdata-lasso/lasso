-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default1', 'default2'), ('default2', 'default2'), ('unique_2', 'default1'), ('unique_3', 'default2'), ('unique_4', 'default2'), ('unique_5', 'default2'), ('unique_6', 'default1'), ('unique_7', NULL), ('unique_8', NULL), ('unique_9', 'default1'), ('unique_10', NULL), ('unique_11', 'default1'), ('unique_12', 'default2'), ('unique_13', NULL), ('unique_14', NULL), ('unique_15', NULL), ('unique_16', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT T1.CLASS FROM (SELECT CLASS, COUNT(*) AS TOT FROM COURSES GROUP BY CLASS) AS T1 WHERE T1.TOT >= 5;

/*
Prediction Result:
(None,)
('default2',)
*/