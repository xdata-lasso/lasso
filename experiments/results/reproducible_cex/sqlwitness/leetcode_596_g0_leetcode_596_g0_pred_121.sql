-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', NULL), ('default1', NULL), ('unique_2', NULL), ('unique_3', NULL), ('unique_4', 'default2'), ('unique_5', 'default2'), ('unique_6', NULL), ('unique_7', 'default1'), ('unique_8', 'default2'), ('unique_9', 'default1'), ('unique_10', 'default2'), ('unique_11', NULL), ('unique_12', 'default2'), ('unique_13', NULL), ('unique_14', 'default2'), ('unique_15', 'default1'), ('unique_16', 'default1'), ('unique_17', 'default2'), ('unique_18', NULL), ('unique_19', 'default1'), ('unique_20', 'default1');
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
SELECT CLASS FROM (SELECT CLASS, COUNT(CLASS) FROM COURSES GROUP BY CLASS HAVING COUNT(CLASS) >= 5) AS B;

/*
Prediction Result:
('default1',)
('default2',)
*/