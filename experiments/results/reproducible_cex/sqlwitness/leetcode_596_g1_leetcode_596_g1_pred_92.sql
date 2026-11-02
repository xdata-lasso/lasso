-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default1', NULL), ('default2', NULL), ('unique_2', 'default1'), ('unique_3', 'default2'), ('unique_4', 'default1'), ('unique_5', NULL), ('unique_6', 'default1'), ('unique_7', 'default2'), ('unique_8', 'default1'), ('unique_9', NULL), ('unique_10', NULL), ('unique_11', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT CLASS FROM COURSES GROUP BY CLASS HAVING COUNT(*) > 4;

/*
Prediction Result:
(None,)
('default1',)
*/