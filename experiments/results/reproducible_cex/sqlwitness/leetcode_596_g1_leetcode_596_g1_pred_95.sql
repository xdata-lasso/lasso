-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', 'default2'), ('default1', 'default2'), ('unique_2', 'default1'), ('unique_3', 'default1'), ('unique_4', 'default2'), ('unique_5', 'default2'), ('unique_6', 'default1'), ('unique_7', 'default2'), ('unique_8', NULL), ('unique_9', NULL), ('unique_10', 'default2'), ('unique_11', 'default1'), ('unique_12', 'default1'), ('unique_13', NULL), ('unique_14', NULL), ('unique_15', NULL), ('unique_16', NULL), ('unique_17', 'default1');
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
SELECT C.CLASS FROM COURSES AS C GROUP BY C.CLASS HAVING COUNT(DISTINCT STUDENT) >= 5;

/*
Prediction Result:
(None,)
('default1',)
('default2',)
*/