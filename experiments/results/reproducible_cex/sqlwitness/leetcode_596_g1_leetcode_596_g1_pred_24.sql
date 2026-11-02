-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default1', NULL), ('default2', 'default1'), ('unique_2', 'default2'), ('unique_3', NULL), ('unique_4', 'default1'), ('unique_5', 'default2'), ('unique_6', 'default1'), ('unique_7', NULL), ('unique_8', 'default2'), ('unique_9', 'default1'), ('unique_10', 'default1'), ('unique_11', 'default2'), ('unique_12', 'default1'), ('unique_13', NULL), ('unique_14', 'default2'), ('unique_15', 'default1'), ('unique_16', NULL), ('unique_17', 'default1'), ('unique_18', 'default1'), ('unique_19', NULL), ('unique_20', NULL), ('unique_21', NULL), ('unique_22', 'default1');
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
SELECT CLASS FROM COURSES GROUP BY (CLASS) HAVING COUNT(DISTINCT STUDENT) >= 5;

/*
Prediction Result:
(None,)
('default1',)
('default2',)
*/