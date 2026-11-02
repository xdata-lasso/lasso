-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default1', NULL), ('default2', 'default1'), ('unique_2', NULL), ('unique_3', 'default2'), ('unique_4', 'default1'), ('unique_5', 'default1'), ('unique_6', NULL), ('unique_7', NULL), ('unique_8', 'default2'), ('unique_9', 'default1'), ('unique_10', 'default2'), ('unique_11', 'default1'), ('unique_12', 'default2'), ('unique_13', NULL), ('unique_14', 'default1'), ('unique_15', 'default2'), ('unique_16', NULL), ('unique_17', NULL), ('unique_18', NULL), ('unique_19', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(*) >= 5;

/*
Gold Result:
(None,)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT A.CLASS FROM (SELECT STUDENT, CLASS FROM COURSES GROUP BY STUDENT, CLASS) AS A GROUP BY CLASS HAVING COUNT(CLASS) >= 5;

/*
Prediction Result:
('default1',)
('default2',)
*/