-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default1', 'default2'), ('default2', 'default1'), ('unique_2', 'default2'), ('unique_3', 'default1'), ('unique_4', NULL), ('unique_5', NULL), ('unique_6', 'default1'), ('unique_7', 'default1'), ('unique_8', NULL), ('unique_9', NULL), ('unique_10', 'default1'), ('unique_11', 'default1'), ('unique_12', NULL), ('unique_13', 'default1'), ('unique_14', NULL), ('unique_15', NULL), ('unique_16', 'default1'), ('unique_17', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT CLASS FROM (SELECT CLASS, COUNT(*) AS N_STUDENTS FROM COURSES GROUP BY CLASS HAVING N_STUDENTS >= 5) AS TEMP;

/*
Prediction Result:
(None,)
('default1',)
*/