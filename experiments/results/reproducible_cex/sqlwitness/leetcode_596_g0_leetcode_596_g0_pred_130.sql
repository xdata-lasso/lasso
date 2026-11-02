-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', 'default1'), ('default1', NULL), ('unique_2', NULL), ('unique_3', NULL), ('unique_4', 'default2'), ('unique_5', 'default2'), ('unique_6', 'default1'), ('unique_7', NULL), ('unique_8', 'default1'), ('unique_9', NULL), ('unique_10', 'default1'), ('unique_11', NULL), ('unique_12', NULL), ('unique_13', 'default2'), ('unique_14', 'default1');
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
SELECT TBL1.CLASS FROM (SELECT CLASS, COUNT(CLASS) AS MYCOUNT FROM COURSES GROUP BY CLASS) AS TBL1 WHERE TBL1.MYCOUNT >= 5;

/*
Prediction Result:
('default1',)
*/