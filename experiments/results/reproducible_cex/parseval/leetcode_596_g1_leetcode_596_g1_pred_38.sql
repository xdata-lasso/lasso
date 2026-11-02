-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: courses --
INSERT INTO "courses" ("student", "class") VALUES ('student_1', 'cou_061aa0');

INSERT INTO "courses" ("student", "class") VALUES ('student_2', 'cou_061aa0');

INSERT INTO "courses" ("student", "class") VALUES ('student_3', 'cou_061aa0');

INSERT INTO "courses" ("student", "class") VALUES ('student_4', 'cou_061aa0');

INSERT INTO "courses" ("student", "class") VALUES ('student_5', 'cou_061aa0');

INSERT INTO "courses" ("student", "class") VALUES ('A', 'cou_061aa0');

INSERT INTO "courses" ("student", "class") VALUES ('C', 'cou_061aa0');

INSERT INTO "courses" ("student", "class") VALUES ('student_6', 'cou_061aa0');

INSERT INTO "courses" ("student", "class") VALUES ('student_9', 'cou_061aa0');

INSERT INTO "courses" ("student", "class") VALUES ('student_10', 'cou_061aa0');

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
('cou_061aa0',)
*/

-- Prediction Query
SELECT C.CLASS FROM (SELECT DISTINCT STUDENT, CLASS FROM COURSES) AS C GROUP BY C.CLASS HAVING COUNT(*) >= 5;

/*
Prediction Result:
(None,)
('cou_061aa0',)
*/