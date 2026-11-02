-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', 'default1'), ('default1', NULL), ('unique_2', 'default2'), ('unique_3', 'default1'), ('unique_4', 'default1'), ('unique_5', NULL), ('unique_6', 'default1'), ('unique_7', 'default1'), ('unique_8', 'default1'), ('unique_9', 'default1'), ('unique_10', 'default1'), ('unique_11', 'default1'), ('unique_12', NULL), ('unique_13', NULL), ('unique_14', NULL);
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
SELECT DISTINCT CLASS FROM COURSES GROUP BY CLASS HAVING COUNT(CLASS) >= 5;

/*
Prediction Result:
('default1',)
*/