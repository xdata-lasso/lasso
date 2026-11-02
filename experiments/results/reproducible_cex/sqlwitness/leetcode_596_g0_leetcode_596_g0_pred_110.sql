-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', NULL), ('default1', NULL), ('unique_2', NULL), ('unique_3', NULL), ('unique_4', NULL), ('unique_5', 'default1'), ('unique_6', NULL), ('unique_7', 'default1'), ('unique_8', 'default1'), ('unique_9', NULL), ('unique_10', 'default1'), ('unique_11', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(*) >= 5;

/*
Gold Result:
(None,)
('default1',)
*/

-- Prediction Query
WITH TT AS (SELECT CLASS, COUNT(CLASS) AS NUM_STUDENT FROM COURSES GROUP BY CLASS) SELECT CLASS FROM TT WHERE NUM_STUDENT >= 5;

/*
Prediction Result:
('default1',)
*/