-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "workshop" ("Workshop_ID", "Date", "Venue", "Name") VALUES (10, '2023-07-01', 'Room 101', 'Sec Workshop');
INSERT INTO "workshop" ("Workshop_ID", "Date", "Venue", "Name") VALUES (20, '2023-08-01', 'Room 102', 'Net Workshop');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (10, 88.0, NULL, 'Berkeley');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (20, 92.0, 'Alice', 'Caltech');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (30, 85.0, 'Alice', 'Oxford');
INSERT INTO "Acceptance" ("Submission_ID", "Workshop_ID", "Result") VALUES (10, 10, 'Accepted');
INSERT INTO "Acceptance" ("Submission_ID", "Workshop_ID", "Result") VALUES (10, 20, NULL);
INSERT INTO "Acceptance" ("Submission_ID", "Workshop_ID", "Result") VALUES (20, 10, NULL);
INSERT INTO "Acceptance" ("Submission_ID", "Workshop_ID", "Result") VALUES (20, 20, 'Rejected');
INSERT INTO "Acceptance" ("Submission_ID", "Workshop_ID", "Result") VALUES (30, 10, 'Accepted');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT author, RESULT FROM (SELECT LHS.submission_id AS submission_id, LHS.workshop_id AS workshop_id, LHS.result AS RESULT, RHS.scores AS scores, RHS.author AS author, RHS.college AS college FROM acceptance AS LHS LEFT JOIN submission AS RHS ON (LHS.submission_id = RHS.submission_id)) ORDER BY author, RESULT NULLS LAST;

/*
Gold Result:
(None, 'Accepted')
(None, None)
('Alice', 'Accepted')
('Alice', 'Rejected')
('Alice', None)
*/

-- Prediction Query
SELECT T2.Author, T1.Result FROM acceptance AS T1 JOIN submission AS T2 ON T1.Submission_ID = T2.Submission_ID;

/*
Prediction Result:
(None, 'Accepted')
(None, None)
('Alice', None)
('Alice', 'Rejected')
('Alice', 'Accepted')
*/