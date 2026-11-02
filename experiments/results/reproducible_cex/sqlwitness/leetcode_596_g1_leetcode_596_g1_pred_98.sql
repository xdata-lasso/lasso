-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', 'default1'), ('default1', 'default2'), ('unique_2', NULL), ('unique_3', NULL), ('unique_4', NULL), ('unique_5', 'default2'), ('unique_6', 'default2'), ('unique_7', 'default2'), ('unique_8', 'default1'), ('unique_9', 'default2'), ('unique_10', NULL), ('unique_11', 'default2'), ('unique_12', 'default1'), ('unique_13', 'default2'), ('unique_14', 'default1'), ('unique_15', NULL), ('unique_16', NULL), ('unique_17', 'default2'), ('unique_18', NULL), ('unique_19', 'default2'), ('unique_20', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT C.CLASS FROM (SELECT CLASS, COUNT(STUDENT) FROM COURSES GROUP BY CLASS HAVING COUNT(STUDENT) >= 5) AS C;

/*
Prediction Result:
(None,)
('default2',)
*/