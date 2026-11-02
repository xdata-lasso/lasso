-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', 'default2'), ('default1', NULL), ('unique_2', 'default2'), ('unique_3', 'default1'), ('unique_4', NULL), ('unique_5', 'default1'), ('unique_6', NULL), ('unique_7', 'default1'), ('unique_8', 'default2'), ('unique_9', 'default1'), ('unique_10', 'default2'), ('unique_11', 'default1'), ('unique_12', NULL), ('unique_13', 'default2'), ('unique_14', 'default2'), ('unique_15', 'default2'), ('unique_16', 'default2'), ('unique_17', NULL), ('unique_18', 'default2');
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
SELECT CLASS FROM COURSES GROUP BY CLASS HAVING COUNT(DISTINCT STUDENT) >= 5 ORDER BY 1, CLASS NULLS LAST;

/*
Prediction Result:
(None,)
('default1',)
('default2',)
*/