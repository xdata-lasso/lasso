-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default1', NULL), ('default2', NULL), ('unique_2', 'default1'), ('unique_3', NULL), ('unique_4', 'default1'), ('unique_5', 'default1'), ('unique_6', NULL), ('unique_7', NULL), ('unique_8', 'default1'), ('unique_9', 'default2'), ('unique_10', NULL), ('unique_11', NULL), ('unique_12', 'default1'), ('unique_13', 'default2'), ('unique_14', 'default1'), ('unique_15', NULL), ('unique_16', 'default2'), ('unique_17', 'default2'), ('unique_18', NULL), ('unique_19', 'default2'), ('unique_20', 'default2'), ('unique_21', NULL), ('unique_22', 'default2'), ('unique_23', NULL), ('unique_24', NULL);
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
SELECT CLASS FROM (SELECT CLASS, COUNT(*) FROM COURSES GROUP BY CLASS HAVING COUNT(*) >= 5) AS A;

/*
Prediction Result:
(None,)
('default1',)
('default2',)
*/