-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default1', NULL), ('default2', 'default2'), ('unique_2', 'default2'), ('unique_3', NULL), ('unique_4', 'default1'), ('unique_5', 'default1'), ('unique_6', NULL), ('unique_7', 'default2'), ('unique_8', 'default2'), ('unique_9', 'default1'), ('unique_10', 'default2'), ('unique_11', NULL), ('unique_12', NULL), ('unique_13', 'default2'), ('unique_14', 'default2'), ('unique_15', NULL), ('unique_16', 'default1'), ('unique_17', 'default1'), ('unique_18', 'default1'), ('unique_19', 'default1');
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
WITH AGG AS (SELECT CLASS, COUNT(*) AS A FROM COURSES GROUP BY CLASS) SELECT CLASS FROM AGG WHERE A >= 5;

/*
Prediction Result:
(None,)
('default1',)
('default2',)
*/