-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default1', NULL), ('default2', NULL), ('unique_2', 'default2'), ('unique_3', 'default1'), ('unique_4', 'default1'), ('unique_5', 'default2'), ('unique_6', NULL), ('unique_7', 'default2'), ('unique_8', 'default1'), ('unique_9', 'default1'), ('unique_10', 'default1'), ('unique_11', NULL), ('unique_12', 'default1'), ('unique_13', NULL), ('unique_14', 'default1'), ('unique_15', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT CLASS FROM (SELECT CLASS, COUNT(DISTINCT STUDENT) AS N FROM COURSES GROUP BY CLASS) AS T WHERE N >= 5;

/*
Prediction Result:
(None,)
('default1',)
*/