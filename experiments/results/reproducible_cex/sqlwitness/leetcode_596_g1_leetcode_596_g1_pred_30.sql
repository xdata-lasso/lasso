-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', 'default2'), ('default1', 'default2'), ('unique_2', 'default2'), ('unique_3', 'default1'), ('unique_4', 'default1'), ('unique_5', NULL), ('unique_6', 'default1'), ('unique_7', 'default2'), ('unique_8', 'default1'), ('unique_9', 'default1'), ('unique_10', NULL), ('unique_11', NULL), ('unique_12', 'default2'), ('unique_13', NULL), ('unique_14', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
('default1',)
('default2',)
*/

-- Prediction Query
SELECT SUB.CLASS FROM (SELECT COUNT(DISTINCT STUDENT) AS COUNTS, CLASS FROM COURSES GROUP BY CLASS) AS SUB WHERE SUB.COUNTS >= 5;

/*
Prediction Result:
(None,)
('default1',)
('default2',)
*/