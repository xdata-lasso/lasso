-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', NULL), ('default1', NULL), ('unique_2', 'default1'), ('unique_3', NULL), ('unique_4', 'default2'), ('unique_5', 'default1'), ('unique_6', NULL), ('unique_7', 'default2'), ('unique_8', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(*) >= 5;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT A.CLASS FROM (SELECT DISTINCT STUDENT, CLASS FROM COURSES) AS A GROUP BY A.CLASS HAVING COUNT(A.CLASS) >= 5;

/*
Prediction Result:
*/