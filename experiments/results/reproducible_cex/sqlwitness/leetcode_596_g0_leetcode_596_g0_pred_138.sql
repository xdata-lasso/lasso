-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', NULL), ('default1', NULL), ('unique_2', 'default2'), ('unique_3', NULL), ('unique_4', 'default1'), ('unique_5', NULL), ('unique_6', 'default1'), ('unique_7', 'default2'), ('unique_8', NULL), ('unique_9', 'default2'), ('unique_10', 'default1'), ('unique_11', 'default2'), ('unique_12', 'default1'), ('unique_13', 'default2'), ('unique_14', 'default1'), ('unique_15', NULL), ('unique_16', NULL), ('unique_17', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(*) >= 5;

/*
Gold Result:
(None,)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT CLASS FROM (SELECT CLASS, COUNT(CLASS) AS NUMBER FROM COURSES GROUP BY CLASS) AS A WHERE NUMBER >= 5;

/*
Prediction Result:
('default1',)
('default2',)
*/