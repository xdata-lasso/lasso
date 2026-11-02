-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default1', 'default1'), ('default2', NULL), ('unique_2', 'default2'), ('unique_3', 'default2'), ('unique_4', 'default2'), ('unique_5', 'default2'), ('unique_6', NULL), ('unique_7', 'default2'), ('unique_8', 'default1'), ('unique_9', 'default2'), ('unique_10', 'default2'), ('unique_11', 'default1'), ('unique_12', NULL), ('unique_13', NULL), ('unique_14', 'default1'), ('unique_15', NULL), ('unique_16', 'default1'), ('unique_17', 'default1'), ('unique_18', 'default2');
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
SELECT CLASS FROM (SELECT CLASS, COUNT(*) AS NUMBER_OF_STUDENTS FROM COURSES GROUP BY CLASS) AS A WHERE NUMBER_OF_STUDENTS >= 5;

/*
Prediction Result:
(None,)
('default1',)
('default2',)
*/