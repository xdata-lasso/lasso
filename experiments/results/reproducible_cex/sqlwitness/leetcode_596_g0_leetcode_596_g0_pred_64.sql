-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default1', 'default1'), ('default2', 'default1'), ('unique_2', NULL), ('unique_3', 'default2'), ('unique_4', 'default1'), ('unique_5', 'default1'), ('unique_6', 'default1'), ('unique_7', 'default1'), ('unique_8', 'default2'), ('unique_9', 'default1'), ('unique_10', 'default2'), ('unique_11', 'default2'), ('unique_12', 'default1'), ('unique_13', NULL), ('unique_14', NULL), ('unique_15', NULL), ('unique_16', 'default2'), ('unique_17', NULL), ('unique_18', 'default2'), ('unique_19', 'default2'), ('unique_20', NULL), ('unique_21', NULL), ('unique_22', 'default1'), ('unique_23', 'default2'), ('unique_24', 'default2');
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
SELECT COURSES.CLASS AS CLASS FROM (SELECT DISTINCT * FROM COURSES) AS COURSES GROUP BY COURSES.CLASS HAVING COUNT(COURSES.CLASS) >= 5;

/*
Prediction Result:
('default1',)
('default2',)
*/