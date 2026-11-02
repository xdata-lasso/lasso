-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default1', 'default2'), ('default2', 'default2'), ('unique_2', NULL), ('unique_3', 'default2'), ('unique_4', 'default1'), ('unique_5', 'default2'), ('unique_6', NULL), ('unique_7', NULL), ('unique_8', 'default1'), ('unique_9', 'default2'), ('unique_10', 'default2'), ('unique_11', NULL), ('unique_12', 'default2'), ('unique_13', 'default1'), ('unique_14', NULL), ('unique_15', NULL), ('unique_16', 'default1'), ('unique_17', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT CLASS FROM (SELECT CLASS, COUNT(STUDENT) AS NUM FROM COURSES GROUP BY CLASS) AS TEMP_TABLE WHERE NUM >= 5;

/*
Prediction Result:
(None,)
('default2',)
*/