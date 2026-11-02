-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', 'default2'), ('default1', 'default1'), ('unique_2', NULL), ('unique_3', NULL), ('unique_4', 'default1'), ('unique_5', NULL), ('unique_6', 'default2'), ('unique_7', 'default2'), ('unique_8', 'default1'), ('unique_9', 'default1'), ('unique_10', NULL), ('unique_11', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
*/

-- Prediction Query
SELECT CLASS FROM (SELECT COUNT(DISTINCT STUDENT) AS CNT, CLASS FROM COURSES GROUP BY CLASS) AS A WHERE CNT > 4;

/*
Prediction Result:
(None,)
*/