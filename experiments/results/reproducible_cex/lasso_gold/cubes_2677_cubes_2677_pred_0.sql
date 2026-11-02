-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "workshop" ("workshop_id", "date", "venue", "name") VALUES (1054, 'white', 'serious', 'Dr. Marvin Thomas Jr.');
INSERT INTO "workshop" ("workshop_id", "date", "venue", "name") VALUES (1055, 'yes', 'forward', 'Kimberly Burgess');
INSERT INTO "workshop" ("workshop_id", "date", "venue", "name") VALUES (1056, 'our', 'difference', 'Kevin Cox');
INSERT INTO "workshop" ("workshop_id", "date", "venue", "name") VALUES (1057, 'under', 'reality', 'Brenda Snyder PhD');
INSERT INTO "workshop" ("workshop_id", "date", "venue", "name") VALUES (1062, 'under', 'reality', 'Brenda Snyder PhD');
INSERT INTO "acceptance" ("submission_id", "workshop_id", "result") VALUES (NULL, 1054, 'traditional');
INSERT INTO "acceptance" ("submission_id", "workshop_id", "result") VALUES (NULL, 1055, 'break');
INSERT INTO "acceptance" ("submission_id", "workshop_id", "result") VALUES (NULL, 1056, 'claim');
INSERT INTO "acceptance" ("submission_id", "workshop_id", "result") VALUES (NULL, 1057, 'product');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT RESULT FROM (SELECT * FROM (SELECT * FROM (SELECT LHS.submission_id AS submission_id, LHS.workshop_id AS workshop_id, LHS.result AS RESULT, RHS.scores AS scores, RHS.author AS author, RHS.college AS college FROM acceptance AS LHS LEFT JOIN submission AS RHS ON (LHS.submission_id = RHS.submission_id)) ORDER BY college DESC) LIMIT 1);

/*
Gold Result:
('traditional',)
*/

-- Prediction Query
SELECT T1.Result FROM acceptance AS T1 JOIN submission AS T2 ON T1.Submission_ID = T2.Submission_ID ORDER BY T2.Scores DESC, T1.submission_id NULLS LAST, T1.workshop_id NULLS LAST, T2.submission_id NULLS LAST LIMIT 1;

/*
Prediction Result:
*/