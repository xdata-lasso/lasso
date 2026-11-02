-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default1', 'default1'), ('default2', 'default2'), ('unique_2', NULL), ('unique_3', 'default2'), ('unique_4', 'default2'), ('unique_5', 'default1'), ('unique_6', 'default1'), ('unique_7', NULL), ('unique_8', NULL), ('unique_9', NULL), ('unique_10', 'default2'), ('unique_11', 'default2'), ('unique_12', NULL), ('unique_13', NULL), ('unique_14', NULL), ('unique_15', 'default1'), ('unique_16', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT CLASS FROM (SELECT CLASS, COUNT(DISTINCT STUDENT) AS N FROM COURSES GROUP BY CLASS) AS TEMP WHERE N >= 5;

/*
Prediction Result:
(None,)
('default2',)
*/