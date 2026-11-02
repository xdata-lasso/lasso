-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO courses (student, class) VALUES ('default2', 'default2'), ('default1', 'default2'), ('unique_2', 'default1'), ('unique_3', 'default1'), ('unique_4', NULL), ('unique_5', NULL), ('unique_6', 'default1'), ('unique_7', 'default2'), ('unique_8', NULL), ('unique_9', 'default2'), ('unique_10', NULL), ('unique_11', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(*) >= 5;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CLASS FROM COURSES AS CS GROUP BY CLASS HAVING (SELECT COUNT(DISTINCT STUDENT) FROM COURSES AS CP WHERE CP.CLASS = CS.CLASS) >= 5;

/*
Prediction Result:
*/