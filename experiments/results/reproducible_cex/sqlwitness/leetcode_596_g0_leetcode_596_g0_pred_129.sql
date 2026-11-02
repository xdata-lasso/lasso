-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default1', NULL), ('default2', NULL), ('unique_2', 'default2'), ('unique_3', NULL), ('unique_4', 'default2'), ('unique_5', NULL), ('unique_6', NULL), ('unique_7', 'default2'), ('unique_8', 'default2'), ('unique_9', 'default1'), ('unique_10', 'default1'), ('unique_11', 'default1'), ('unique_12', 'default1'), ('unique_13', NULL), ('unique_14', 'default2'), ('unique_15', NULL), ('unique_16', 'default2'), ('unique_17', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(*) >= 5;

/*
Gold Result:
(None,)
('default2',)
*/

-- Prediction Query
SELECT CLASS FROM (SELECT CLASS, COUNT(CLASS) AS CLASS_B FROM COURSES GROUP BY CLASS) AS CL WHERE CL.CLASS_B >= 5;

/*
Prediction Result:
('default2',)
*/