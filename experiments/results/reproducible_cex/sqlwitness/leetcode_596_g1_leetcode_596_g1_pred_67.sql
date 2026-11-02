-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default1', NULL), ('default2', 'default1'), ('unique_2', 'default2'), ('unique_3', 'default2'), ('unique_4', NULL), ('unique_5', NULL), ('unique_6', NULL), ('unique_7', NULL), ('unique_8', 'default1'), ('unique_9', NULL), ('unique_10', 'default2'), ('unique_11', NULL), ('unique_12', NULL), ('unique_13', 'default1'), ('unique_14', 'default2'), ('unique_15', NULL), ('unique_16', NULL), ('unique_17', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
*/

-- Prediction Query
WITH A AS (SELECT CLASS, COUNT(DISTINCT (STUDENT)) AS STUD_COUNT FROM COURSES GROUP BY CLASS HAVING STUD_COUNT > 4) SELECT CLASS FROM A;

/*
Prediction Result:
(None,)
*/