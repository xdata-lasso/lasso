-- Schema DDL
CREATE TABLE "courses" ("student" TEXT(255) PRIMARY KEY, "class" TEXT(255), UNIQUE ("student", "class"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: courses --
INSERT INTO "courses" ("student", "class") VALUES ('student_1', 'cou_582183');

INSERT INTO "courses" ("student", "class") VALUES ('student_2', 'cou_582183');

INSERT INTO "courses" ("student", "class") VALUES ('student_3', 'cou_582183');

INSERT INTO "courses" ("student", "class") VALUES ('student_4', 'cou_582183');

INSERT INTO "courses" ("student", "class") VALUES ('student_5', 'cou_582183');

INSERT INTO "courses" ("student", "class") VALUES ('A', 'cou_582183');

INSERT INTO "courses" ("student", "class") VALUES ('C', 'cou_582183');

INSERT INTO "courses" ("student", "class") VALUES ('student_6', 'cou_582183');

INSERT INTO "courses" ("student", "class") VALUES ('student_9', 'cou_582183');

INSERT INTO "courses" ("student", "class") VALUES ('student_10', 'cou_582183');

INSERT INTO "courses" ("student", "class") VALUES ('student_11', 'cou_582183');

INSERT INTO "courses" ("student", "class") VALUES ('student_12', 'cou_582183');

INSERT INTO "courses" ("student", "class") VALUES ('student_13', 'cou_582183');

INSERT INTO "courses" ("student", "class") VALUES ('student_14', NULL);

INSERT INTO "courses" ("student", "class") VALUES ('student_15', NULL);

INSERT INTO "courses" ("student", "class") VALUES ('student_16', NULL);

INSERT INTO "courses" ("student", "class") VALUES ('student_17', NULL);

INSERT INTO "courses" ("student", "class") VALUES ('student_18', NULL);

INSERT INTO "courses" ("student", "class") VALUES ('student_19', 'cou_582183');

INSERT INTO "courses" ("student", "class") VALUES ('student_20', 'cou_582183');

INSERT INTO "courses" ("student", "class") VALUES ('student_21', 'cou_582183');

INSERT INTO "courses" ("student", "class") VALUES ('student_22', 'cou_582183');

INSERT INTO "courses" ("student", "class") VALUES ('student_23', 'cou_582183');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT class FROM courses GROUP BY class HAVING COUNT(*) >= 5;

/*
Gold Result:
(None,)
('cou_582183',)
*/

-- Prediction Query
SELECT CLASS FROM (SELECT CLASS, COUNT(CLASS) AS NUM FROM COURSES GROUP BY CLASS) AS TEMP WHERE NUM >= 5;

/*
Prediction Result:
('cou_582183',)
*/