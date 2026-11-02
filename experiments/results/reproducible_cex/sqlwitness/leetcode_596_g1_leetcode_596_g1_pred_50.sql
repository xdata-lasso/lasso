-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', 'default1'), ('default1', NULL), ('unique_2', 'default2'), ('unique_3', 'default2'), ('unique_4', 'default1'), ('unique_5', 'default1'), ('unique_6', 'default1'), ('unique_7', NULL), ('unique_8', 'default1'), ('unique_9', 'default2'), ('unique_10', NULL), ('unique_11', NULL), ('unique_12', NULL), ('unique_13', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT CLASS FROM (SELECT CLASS, COUNT(DISTINCT STUDENT) AS N FROM COURSES GROUP BY CLASS) AS A WHERE N >= 5;

/*
Prediction Result:
(None,)
('default1',)
*/