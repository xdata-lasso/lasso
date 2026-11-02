-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: courses --
INSERT INTO "courses" ("student", "class") VALUES ('student_1', 'cou_4599fb');

INSERT INTO "courses" ("student", "class") VALUES ('student_2', 'cou_4599fb');

INSERT INTO "courses" ("student", "class") VALUES ('student_3', 'cou_4599fb');

INSERT INTO "courses" ("student", "class") VALUES ('student_4', 'cou_4599fb');

INSERT INTO "courses" ("student", "class") VALUES ('student_5', 'cou_4599fb');

INSERT INTO "courses" ("student", "class") VALUES ('A', 'cou_4599fb');

INSERT INTO "courses" ("student", "class") VALUES ('C', 'cou_4599fb');

INSERT INTO "courses" ("student", "class") VALUES ('student_6', 'cou_4599fb');

INSERT INTO "courses" ("student", "class") VALUES ('student_9', 'cou_4599fb');

INSERT INTO "courses" ("student", "class") VALUES ('student_10', 'cou_4599fb');

INSERT INTO "courses" ("student", "class") VALUES ('student_11', NULL);

INSERT INTO "courses" ("student", "class") VALUES ('student_12', NULL);

INSERT INTO "courses" ("student", "class") VALUES ('student_13', NULL);

INSERT INTO "courses" ("student", "class") VALUES ('student_14', NULL);

INSERT INTO "courses" ("student", "class") VALUES ('student_15', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(class) >= 5;

/*
Gold Result:
('cou_4599fb',)
*/

-- Prediction Query
SELECT CLASS FROM (SELECT DISTINCT CLASS, STUDENT FROM COURSES) AS CLASS GROUP BY CLASS HAVING COUNT(*) > 4;

/*
Prediction Result:
(None,)
('cou_4599fb',)
*/