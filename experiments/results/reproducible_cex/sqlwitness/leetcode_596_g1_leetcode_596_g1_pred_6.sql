-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', NULL), ('default1', NULL), ('unique_2', NULL), ('unique_3', 'default2'), ('unique_4', 'default1'), ('unique_5', NULL), ('unique_6', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.CLASS FROM COURSES AS A GROUP BY A.CLASS HAVING COUNT(DISTINCT (A.STUDENT)) >= 5;

/*
Prediction Result:
(None,)
*/