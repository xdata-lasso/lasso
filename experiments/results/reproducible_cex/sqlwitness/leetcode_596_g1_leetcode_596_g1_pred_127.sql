-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', NULL), ('default1', 'default1'), ('unique_2', 'default2'), ('unique_3', 'default2'), ('unique_4', 'default1'), ('unique_5', NULL), ('unique_6', NULL), ('unique_7', 'default2'), ('unique_8', 'default1'), ('unique_9', 'default2'), ('unique_10', NULL), ('unique_11', NULL), ('unique_12', 'default2'), ('unique_13', 'default2'), ('unique_14', NULL), ('unique_15', NULL), ('unique_16', 'default2'), ('unique_17', NULL), ('unique_18', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT CLASS FROM COURSES GROUP BY (CLASS) HAVING COUNT(STUDENT) >= 5;

/*
Prediction Result:
(None,)
('default2',)
*/