-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', 'default2'), ('default1', NULL), ('unique_2', 'default1'), ('unique_3', 'default1'), ('unique_4', NULL), ('unique_5', 'default1'), ('unique_6', NULL), ('unique_7', NULL), ('unique_8', 'default2'), ('unique_9', NULL), ('unique_10', 'default2'), ('unique_11', 'default1'), ('unique_12', NULL), ('unique_13', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.CLASS FROM (SELECT CLASS, COUNT(STUDENT) AS COUNTER FROM COURSES GROUP BY CLASS) AS C WHERE C.COUNTER >= 5;

/*
Prediction Result:
(None,)
*/