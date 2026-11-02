-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', NULL), ('default1', NULL), ('unique_2', 'default1'), ('unique_3', NULL), ('unique_4', 'default1'), ('unique_5', 'default1'), ('unique_6', NULL), ('unique_7', NULL), ('unique_8', 'default2'), ('unique_9', 'default1'), ('unique_10', 'default1'), ('unique_11', 'default2'), ('unique_12', 'default1'), ('unique_13', 'default1'), ('unique_14', 'default1'), ('unique_15', 'default2'), ('unique_16', 'default1'), ('unique_17', NULL), ('unique_18', NULL), ('unique_19', 'default2'), ('unique_20', 'default1'), ('unique_21', 'default2'), ('unique_22', 'default2'), ('unique_23', 'default2'), ('unique_24', 'default2'), ('unique_25', 'default2');
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
SELECT CLASS FROM (SELECT COUNT(DISTINCT STUDENT) AS STUDENT_COUNT, CLASS FROM COURSES GROUP BY CLASS) AS A WHERE STUDENT_COUNT >= 5;

/*
Prediction Result:
(None,)
('default1',)
('default2',)
*/