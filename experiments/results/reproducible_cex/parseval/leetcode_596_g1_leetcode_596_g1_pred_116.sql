-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: courses --
INSERT INTO "courses" ("student", "class") VALUES ('student_1', 'cou_51f0bd');

INSERT INTO "courses" ("student", "class") VALUES ('student_2', 'cou_51f0bd');

INSERT INTO "courses" ("student", "class") VALUES ('student_3', 'cou_51f0bd');

INSERT INTO "courses" ("student", "class") VALUES ('student_4', 'cou_51f0bd');

INSERT INTO "courses" ("student", "class") VALUES ('student_5', 'cou_51f0bd');

INSERT INTO "courses" ("student", "class") VALUES ('A', 'cou_51f0bd');

INSERT INTO "courses" ("student", "class") VALUES ('C', 'cou_51f0bd');

INSERT INTO "courses" ("student", "class") VALUES ('student_6', 'cou_51f0bd');

INSERT INTO "courses" ("student", "class") VALUES ('student_9', 'cou_51f0bd');

INSERT INTO "courses" ("student", "class") VALUES ('student_10', 'cou_51f0bd');

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
('cou_51f0bd',)
*/

-- Prediction Query
SELECT T.CLASS FROM (SELECT CLASS, COUNT(STUDENT) AS CNT FROM COURSES GROUP BY CLASS HAVING CNT >= 5) AS T;

/*
Prediction Result:
(None,)
('cou_51f0bd',)
*/