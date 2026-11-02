-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', NULL), ('default1', NULL), ('unique_2', NULL), ('unique_3', NULL), ('unique_4', 'default2'), ('unique_5', NULL), ('unique_6', 'default1'), ('unique_7', 'default2'), ('unique_8', 'default2'), ('unique_9', 'default2'), ('unique_10', 'default2'), ('unique_11', 'default1'), ('unique_12', 'default2'), ('unique_13', 'default2'), ('unique_14', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT A.CLASS FROM (SELECT CLASS, COUNT(STUDENT) FROM COURSES GROUP BY 1 HAVING COUNT(STUDENT) >= 5) AS A;

/*
Prediction Result:
(None,)
('default2',)
*/