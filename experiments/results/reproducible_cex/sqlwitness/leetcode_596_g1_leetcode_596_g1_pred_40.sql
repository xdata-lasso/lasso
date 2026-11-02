-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', NULL), ('default1', 'default2'), ('unique_2', 'default1'), ('unique_3', NULL), ('unique_4', NULL), ('unique_5', 'default1'), ('unique_6', 'default1'), ('unique_7', NULL), ('unique_8', 'default1'), ('unique_9', 'default1'), ('unique_10', 'default2'), ('unique_11', NULL), ('unique_12', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT CLASS FROM (SELECT CLASS, COUNT(DISTINCT STUDENT) AS CNT FROM COURSES GROUP BY CLASS) AS A WHERE CNT > 4;

/*
Prediction Result:
(None,)
('default1',)
*/