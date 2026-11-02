-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', 'default1'), ('default1', NULL), ('unique_2', 'default2'), ('unique_3', 'default1'), ('unique_4', 'default2'), ('unique_5', NULL), ('unique_6', NULL), ('unique_7', 'default2'), ('unique_8', 'default1'), ('unique_9', 'default2'), ('unique_10', NULL), ('unique_11', NULL), ('unique_12', 'default2'), ('unique_13', NULL), ('unique_14', NULL), ('unique_15', 'default1'), ('unique_16', NULL), ('unique_17', NULL), ('unique_18', NULL), ('unique_19', NULL), ('unique_20', 'default2'), ('unique_21', 'default1');
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
SELECT CLASS FROM (SELECT CLASS, COUNT(STUDENT) AS NUM FROM COURSES GROUP BY CLASS) AS TEMP_TABLE WHERE NUM > 4;

/*
Prediction Result:
(None,)
('default1',)
('default2',)
*/