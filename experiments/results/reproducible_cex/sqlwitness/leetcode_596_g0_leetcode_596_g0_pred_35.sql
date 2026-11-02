-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default1', NULL), ('default2', 'default1'), ('unique_2', 'default1'), ('unique_3', NULL), ('unique_4', NULL), ('unique_5', 'default2'), ('unique_6', 'default2'), ('unique_7', NULL), ('unique_8', NULL), ('unique_9', 'default2'), ('unique_10', 'default1'), ('unique_11', NULL), ('unique_12', NULL), ('unique_13', 'default2'), ('unique_14', NULL), ('unique_15', 'default1'), ('unique_16', NULL), ('unique_17', 'default2'), ('unique_18', 'default1'), ('unique_19', 'default1'), ('unique_20', 'default2'), ('unique_21', 'default2'), ('unique_22', NULL);
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
WITH T AS (SELECT DISTINCT * FROM COURSES) SELECT CLASS FROM T GROUP BY CLASS HAVING COUNT(CLASS) >= 5;

/*
Prediction Result:
('default1',)
('default2',)
*/