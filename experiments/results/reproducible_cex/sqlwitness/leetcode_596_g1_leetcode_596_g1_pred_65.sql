-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default1', 'default1'), ('default2', 'default2'), ('unique_2', 'default2'), ('unique_3', 'default2'), ('unique_4', 'default1'), ('unique_5', 'default2'), ('unique_6', NULL), ('unique_7', 'default2'), ('unique_8', NULL), ('unique_9', 'default1'), ('unique_10', NULL), ('unique_11', 'default1'), ('unique_12', NULL), ('unique_13', 'default2'), ('unique_14', 'default2'), ('unique_15', 'default1'), ('unique_16', 'default2'), ('unique_17', 'default1'), ('unique_18', NULL), ('unique_19', 'default1'), ('unique_20', 'default2'), ('unique_21', 'default2'), ('unique_22', 'default1');
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
SELECT MAIN.CLASS FROM (SELECT EXTRA.CLASS, COUNT(DISTINCT EXTRA.STUDENT) AS STUDENT_COUNT FROM COURSES AS EXTRA GROUP BY CLASS HAVING (STUDENT_COUNT >= 5)) AS MAIN;

/*
Prediction Result:
(None,)
('default1',)
('default2',)
*/