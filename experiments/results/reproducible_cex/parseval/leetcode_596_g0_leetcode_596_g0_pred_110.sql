-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: courses --
INSERT INTO "courses" ("student", "class") VALUES ('student_1', 'cou_5014c3');

INSERT INTO "courses" ("student", "class") VALUES ('student_2', 'cou_5014c3');

INSERT INTO "courses" ("student", "class") VALUES ('student_3', 'cou_5014c3');

INSERT INTO "courses" ("student", "class") VALUES ('student_4', 'cou_5014c3');

INSERT INTO "courses" ("student", "class") VALUES ('student_5', 'cou_5014c3');

INSERT INTO "courses" ("student", "class") VALUES ('A', 'cou_5014c3');

INSERT INTO "courses" ("student", "class") VALUES ('C', 'cou_5014c3');

INSERT INTO "courses" ("student", "class") VALUES ('student_6', 'cou_5014c3');

INSERT INTO "courses" ("student", "class") VALUES ('student_9', 'cou_5014c3');

INSERT INTO "courses" ("student", "class") VALUES ('student_10', 'cou_5014c3');

INSERT INTO "courses" ("student", "class") VALUES ('student_11', 'cou_5014c3');

INSERT INTO "courses" ("student", "class") VALUES ('student_12', 'cou_5014c3');

INSERT INTO "courses" ("student", "class") VALUES ('student_13', 'cou_5014c3');

INSERT INTO "courses" ("student", "class") VALUES ('student_14', NULL);

INSERT INTO "courses" ("student", "class") VALUES ('student_15', NULL);

INSERT INTO "courses" ("student", "class") VALUES ('student_16', NULL);

INSERT INTO "courses" ("student", "class") VALUES ('student_17', NULL);

INSERT INTO "courses" ("student", "class") VALUES ('student_18', NULL);

INSERT INTO "courses" ("student", "class") VALUES ('student_19', 'cou_5014c3');

INSERT INTO "courses" ("student", "class") VALUES ('student_20', 'cou_5014c3');

INSERT INTO "courses" ("student", "class") VALUES ('student_21', 'cou_5014c3');

INSERT INTO "courses" ("student", "class") VALUES ('student_22', 'cou_5014c3');

INSERT INTO "courses" ("student", "class") VALUES ('student_23', 'cou_5014c3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(*) >= 5;

/*
Gold Result:
(None,)
('cou_5014c3',)
*/

-- Prediction Query
WITH TT AS (SELECT CLASS, COUNT(CLASS) AS NUM_STUDENT FROM COURSES GROUP BY CLASS) SELECT CLASS FROM TT WHERE NUM_STUDENT >= 5;

/*
Prediction Result:
('cou_5014c3',)
*/