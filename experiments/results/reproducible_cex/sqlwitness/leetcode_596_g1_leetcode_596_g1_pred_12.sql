-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default1', NULL), ('default2', NULL), ('unique_2', NULL), ('unique_3', NULL), ('unique_4', 'default1'), ('unique_5', 'default2'), ('unique_6', 'default1'), ('unique_7', 'default1'), ('unique_8', 'default2'), ('unique_9', 'default2'), ('unique_10', 'default1'), ('unique_11', NULL), ('unique_12', NULL), ('unique_13', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
*/

-- Prediction Query
SELECT CLASS FROM (SELECT CLASS, COUNT(DISTINCT STUDENT) AS NUM FROM COURSES GROUP BY CLASS) AS TEMP_TABLE WHERE NUM >= 5;

/*
Prediction Result:
(None,)
*/