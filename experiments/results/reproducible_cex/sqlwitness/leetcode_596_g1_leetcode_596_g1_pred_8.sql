-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default1', NULL), ('default2', NULL), ('unique_2', 'default1'), ('unique_3', NULL), ('unique_4', 'default2'), ('unique_5', NULL), ('unique_6', 'default1'), ('unique_7', 'default1'), ('unique_8', 'default2'), ('unique_9', 'default2'), ('unique_10', NULL), ('unique_11', 'default1'), ('unique_12', 'default1'), ('unique_13', 'default2'), ('unique_14', 'default2'), ('unique_15', 'default1'), ('unique_16', 'default2'), ('unique_17', NULL), ('unique_18', NULL), ('unique_19', 'default2'), ('unique_20', 'default2');
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
SELECT CLASS FROM (SELECT DISTINCT CLASS, STUDENT FROM COURSES) AS CLASS GROUP BY CLASS HAVING COUNT(*) > 4;

/*
Prediction Result:
(None,)
('default1',)
('default2',)
*/