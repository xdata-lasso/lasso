-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', 'default2'), ('default1', NULL), ('unique_2', 'default1'), ('unique_3', 'default2'), ('unique_4', 'default2'), ('unique_5', NULL), ('unique_6', 'default2'), ('unique_7', 'default2'), ('unique_8', NULL), ('unique_9', 'default2'), ('unique_10', 'default2'), ('unique_11', 'default2'), ('unique_12', NULL), ('unique_13', 'default1'), ('unique_14', 'default2'), ('unique_15', NULL), ('unique_16', 'default2'), ('unique_17', 'default2'), ('unique_18', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT CLASS FROM (SELECT CLASS, COUNT(DISTINCT STUDENT) AS CCLASS FROM COURSES GROUP BY CLASS) AS C WHERE C.CCLASS >= 5;

/*
Prediction Result:
(None,)
('default2',)
*/