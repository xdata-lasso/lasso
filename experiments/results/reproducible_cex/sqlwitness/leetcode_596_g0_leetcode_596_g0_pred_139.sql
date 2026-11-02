-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', NULL), ('default1', 'default2'), ('unique_2', 'default1'), ('unique_3', NULL), ('unique_4', NULL), ('unique_5', 'default2'), ('unique_6', NULL), ('unique_7', 'default1'), ('unique_8', NULL), ('unique_9', 'default1'), ('unique_10', 'default1'), ('unique_11', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(*) >= 5;

/*
Gold Result:
(None,)
*/

-- Prediction Query
WITH CLASS_CT(CLASS, STUDENT_CT) AS (SELECT CLASS, COUNT(CLASS) AS STUDENT_CT FROM COURSES GROUP BY CLASS) SELECT CLASS FROM CLASS_CT WHERE STUDENT_CT >= 5;

/*
Prediction Result:
*/