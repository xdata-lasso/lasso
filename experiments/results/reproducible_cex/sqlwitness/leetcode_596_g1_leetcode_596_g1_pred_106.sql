-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', 'default2'), ('default1', 'default2'), ('unique_2', 'default2'), ('unique_3', 'default1'), ('unique_4', 'default2'), ('unique_5', 'default1'), ('unique_6', 'default2'), ('unique_7', 'default1'), ('unique_8', NULL), ('unique_9', NULL), ('unique_10', 'default2'), ('unique_11', NULL), ('unique_12', 'default1'), ('unique_13', 'default1'), ('unique_14', NULL), ('unique_15', 'default1'), ('unique_16', 'default1'), ('unique_17', NULL);
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
SELECT CLASS1.CLASS FROM (SELECT CLASS, COUNT(DISTINCT STUDENT) AS COUNTER FROM COURSES GROUP BY 1) AS CLASS1 WHERE CLASS1.COUNTER >= 5;

/*
Prediction Result:
(None,)
('default1',)
('default2',)
*/