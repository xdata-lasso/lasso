-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', 'default1'), ('default1', NULL), ('unique_2', NULL), ('unique_3', 'default2'), ('unique_4', 'default1'), ('unique_5', NULL), ('unique_6', NULL), ('unique_7', NULL), ('unique_8', 'default2'), ('unique_9', 'default1'), ('unique_10', 'default2'), ('unique_11', NULL), ('unique_12', NULL), ('unique_13', 'default1'), ('unique_14', 'default1'), ('unique_15', 'default1'), ('unique_16', 'default1'), ('unique_17', 'default1'), ('unique_18', 'default2'), ('unique_19', NULL);
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
SELECT CLASS FROM (SELECT DISTINCT * FROM COURSES) AS C GROUP BY CLASS HAVING COUNT(CLASS) >= 5;

/*
Prediction Result:
('default1',)
*/