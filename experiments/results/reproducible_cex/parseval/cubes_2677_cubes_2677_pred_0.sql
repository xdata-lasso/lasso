-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: workshop --
INSERT INTO "workshop" ("workshop_id", "date", "venue", "name") VALUES (1, '5k5swwqcgs', '9n8', '4');

-- Inserting into table: submission --
INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (1, 1.0, 'rhs_eafca4', 'rhs_0410a7');

INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (-2147483647, 1.0, 'rhs_4f876f', 'rhs_a6623b');

INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (3, 1.0, 'rhs_eafca4', 'rhs_0410a7');

INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (2, 249.706432, 'u7', 'fe4hri');

INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (4, 710.998147, '2', 'puzhsrw');

INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (5, 944.247544, 'p', 'luhvdltti');

INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (-2147483642, 998.421621, 'prmd', 'posiie5unw6k');

INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (-2147483641, 741.842896, '9000t5c4ec', 'gce');

-- Inserting into table: acceptance --
INSERT INTO "acceptance" ("submission_id", "workshop_id", "result") VALUES (1, 1, 'lhs_7dc98f');

INSERT INTO "acceptance" ("submission_id", "workshop_id", "result") VALUES (2, 1, 'lhs_7dc98f');

INSERT INTO "acceptance" ("submission_id", "workshop_id", "result") VALUES (-2147483642, 1, 'q_2_4c4f3c');

INSERT INTO "acceptance" ("submission_id", "workshop_id", "result") VALUES (-2147483641, 1, 'q_2_4c4f3c');

INSERT INTO "acceptance" ("submission_id", "workshop_id", "result") VALUES (4, 1, '6nium52zb');

INSERT INTO "acceptance" ("submission_id", "workshop_id", "result") VALUES (5, 1, '4nrq');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT RESULT FROM (SELECT * FROM (SELECT * FROM (SELECT LHS.submission_id AS submission_id, LHS.workshop_id AS workshop_id, LHS.result AS RESULT, RHS.scores AS scores, RHS.author AS author, RHS.college AS college FROM acceptance AS LHS LEFT JOIN submission AS RHS ON (LHS.submission_id = RHS.submission_id)) ORDER BY college DESC) LIMIT 1);

/*
Gold Result:
('lhs_7dc98f',)
*/

-- Prediction Query
SELECT T1.Result FROM acceptance AS T1 JOIN submission AS T2 ON T1.Submission_ID = T2.Submission_ID ORDER BY T2.Scores DESC, T1.submission_id NULLS LAST, T1.workshop_id NULLS LAST, T2.submission_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('q_2_4c4f3c',)
*/