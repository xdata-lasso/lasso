-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', 'default1'), ('default1', NULL), ('unique_2', 'default1'), ('unique_3', NULL), ('unique_4', 'default1'), ('unique_5', NULL), ('unique_6', 'default1'), ('unique_7', 'default1'), ('unique_8', 'default2'), ('unique_9', 'default1'), ('unique_10', 'default2'), ('unique_11', 'default1'), ('unique_12', NULL), ('unique_13', NULL), ('unique_14', 'default1'), ('unique_15', 'default1'), ('unique_16', 'default2'), ('unique_17', 'default1'), ('unique_18', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT CLASS FROM (SELECT CLASS, COUNT(DISTINCT STUDENT) AS INNER_NUMBER_OF_VALUES FROM COURSES GROUP BY CLASS) AS INNER_QUERY WHERE INNER_NUMBER_OF_VALUES >= 5;

/*
Prediction Result:
(None,)
('default1',)
*/