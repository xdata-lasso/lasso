-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', NULL), ('default1', 'default2'), ('unique_2', 'default1'), ('unique_3', 'default1'), ('unique_4', NULL), ('unique_5', NULL), ('unique_6', 'default2'), ('unique_7', 'default2'), ('unique_8', NULL), ('unique_9', 'default1'), ('unique_10', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
*/

-- Prediction Query
WITH DB AS (SELECT CLASS, COUNT(DISTINCT STUDENT) AS COUNT FROM COURSES GROUP BY CLASS) SELECT CLASS FROM DB WHERE COUNT >= 5;

/*
Prediction Result:
(None,)
*/