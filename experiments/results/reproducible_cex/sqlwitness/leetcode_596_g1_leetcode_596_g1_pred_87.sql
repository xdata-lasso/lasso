-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', 'default2'), ('default1', 'default2'), ('unique_2', 'default1'), ('unique_3', NULL), ('unique_4', 'default2'), ('unique_5', 'default1'), ('unique_6', 'default1'), ('unique_7', NULL), ('unique_8', 'default1'), ('unique_9', NULL), ('unique_10', 'default2'), ('unique_11', 'default1'), ('unique_12', NULL), ('unique_13', 'default1'), ('unique_14', NULL), ('unique_15', 'default2'), ('unique_16', 'default2'), ('unique_17', 'default2');
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
WITH TEMP AS (SELECT CLASS, COUNT(STUDENT) AS NO FROM COURSES GROUP BY CLASS) SELECT CLASS FROM TEMP WHERE NO > 4;

/*
Prediction Result:
(None,)
('default1',)
('default2',)
*/