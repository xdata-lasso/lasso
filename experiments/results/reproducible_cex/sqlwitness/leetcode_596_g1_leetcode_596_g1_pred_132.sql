-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', NULL), ('default1', NULL), ('unique_2', 'default1'), ('unique_3', NULL), ('unique_4', NULL), ('unique_5', NULL), ('unique_6', 'default1'), ('unique_7', 'default1'), ('unique_8', NULL), ('unique_9', 'default2'), ('unique_10', 'default2'), ('unique_11', 'default1'), ('unique_12', 'default1'), ('unique_13', 'default2'), ('unique_14', 'default1'), ('unique_15', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT CLASS FROM (SELECT CLASS, COUNT(STUDENT) AS TOTAL FROM COURSES GROUP BY 1 HAVING TOTAL >= 5) AS BASE;

/*
Prediction Result:
(None,)
('default1',)
*/