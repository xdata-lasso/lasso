-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: courses --
INSERT INTO "courses" ("student", "class") VALUES ('student_1', 'cou_4360ad');

INSERT INTO "courses" ("student", "class") VALUES ('student_2', 'cou_4360ad');

INSERT INTO "courses" ("student", "class") VALUES ('student_3', 'cou_4360ad');

INSERT INTO "courses" ("student", "class") VALUES ('student_4', 'cou_4360ad');

INSERT INTO "courses" ("student", "class") VALUES ('student_5', 'cou_4360ad');

INSERT INTO "courses" ("student", "class") VALUES ('A', 'cou_4360ad');

INSERT INTO "courses" ("student", "class") VALUES ('C', 'cou_4360ad');

INSERT INTO "courses" ("student", "class") VALUES ('student_6', 'cou_4360ad');

INSERT INTO "courses" ("student", "class") VALUES ('student_9', 'cou_4360ad');

INSERT INTO "courses" ("student", "class") VALUES ('student_10', 'cou_4360ad');

INSERT INTO "courses" ("student", "class") VALUES ('student_11', 'cou_4360ad');

INSERT INTO "courses" ("student", "class") VALUES ('student_12', 'cou_4360ad');

INSERT INTO "courses" ("student", "class") VALUES ('student_13', 'cou_4360ad');

INSERT INTO "courses" ("student", "class") VALUES ('student_14', 'cou_4360ad');

INSERT INTO "courses" ("student", "class") VALUES ('student_15', 'cou_4360ad');

INSERT INTO "courses" ("student", "class") VALUES ('student_16', 'cou_4360ad');

INSERT INTO "courses" ("student", "class") VALUES ('student_17', 'cou_4360ad');

INSERT INTO "courses" ("student", "class") VALUES ('student_18', 'cou_4360ad');

INSERT INTO "courses" ("student", "class") VALUES ('student_19', NULL);

INSERT INTO "courses" ("student", "class") VALUES ('student_20', NULL);

INSERT INTO "courses" ("student", "class") VALUES ('student_21', NULL);

INSERT INTO "courses" ("student", "class") VALUES ('student_22', NULL);

INSERT INTO "courses" ("student", "class") VALUES ('student_23', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(*) >= 5;

/*
Gold Result:
(None,)
('cou_4360ad',)
*/

-- Prediction Query
SELECT TBL1.CLASS FROM (SELECT CLASS, COUNT(CLASS) AS MYCOUNT FROM COURSES GROUP BY CLASS) AS TBL1 WHERE TBL1.MYCOUNT >= 5;

/*
Prediction Result:
('cou_4360ad',)
*/