-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', NULL), ('default1', NULL), ('unique_2', 'default2'), ('unique_3', 'default1'), ('unique_4', NULL), ('unique_5', 'default2'), ('unique_6', 'default2'), ('unique_7', 'default2'), ('unique_8', 'default1'), ('unique_9', NULL), ('unique_10', NULL), ('unique_11', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT DISTINCT (CLASS) FROM COURSES GROUP BY CLASS HAVING COUNT(DISTINCT STUDENT) >= 5;

/*
Prediction Result:
(None,)
('default2',)
*/