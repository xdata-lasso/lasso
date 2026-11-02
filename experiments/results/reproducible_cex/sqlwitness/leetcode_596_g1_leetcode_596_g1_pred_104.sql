-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', 'default1'), ('default1', NULL), ('unique_2', NULL), ('unique_3', 'default1'), ('unique_4', NULL), ('unique_5', 'default2'), ('unique_6', NULL), ('unique_7', 'default2'), ('unique_8', NULL), ('unique_9', NULL), ('unique_10', NULL), ('unique_11', NULL), ('unique_12', 'default2'), ('unique_13', NULL), ('unique_14', NULL), ('unique_15', 'default1'), ('unique_16', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
*/

-- Prediction Query
SELECT CLASS FROM COURSES GROUP BY 1 HAVING COUNT(1) > 4;

/*
Prediction Result:
(None,)
*/