-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', 'default1'), ('default1', 'default1'), ('unique_2', 'default1'), ('unique_3', NULL), ('unique_4', 'default1'), ('unique_5', NULL), ('unique_6', 'default1'), ('unique_7', 'default2'), ('unique_8', NULL), ('unique_9', 'default2'), ('unique_10', 'default1'), ('unique_11', 'default1'), ('unique_12', 'default1'), ('unique_13', NULL), ('unique_14', NULL), ('unique_15', 'default2'), ('unique_16', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT C.CLASS FROM COURSES AS C GROUP BY C.CLASS HAVING COUNT(C.STUDENT) >= 5;

/*
Prediction Result:
(None,)
('default1',)
*/