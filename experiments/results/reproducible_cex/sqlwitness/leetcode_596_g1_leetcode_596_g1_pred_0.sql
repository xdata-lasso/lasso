-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default1', NULL), ('default2', 'default2'), ('unique_2', 'default1'), ('unique_3', 'default1'), ('unique_4', NULL), ('unique_5', NULL), ('unique_6', NULL), ('unique_7', NULL), ('unique_8', NULL), ('unique_9', 'default2'), ('unique_10', 'default2'), ('unique_11', NULL), ('unique_12', 'default1'), ('unique_13', NULL), ('unique_14', 'default1'), ('unique_15', 'default1'), ('unique_16', 'default1'), ('unique_17', NULL), ('unique_18', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT A.CLASS FROM (SELECT DISTINCT * FROM COURSES) AS A GROUP BY CLASS HAVING COUNT(STUDENT) >= 5;

/*
Prediction Result:
(None,)
('default1',)
*/