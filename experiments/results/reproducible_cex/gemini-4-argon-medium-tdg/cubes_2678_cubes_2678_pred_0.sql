-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Unmatched submission (Submission_ID 3 not in Acceptance) to kill swapped LEFT JOIN (submission LEFT JOIN acceptance) or FULL OUTER JOIN.
-- 2. Duplicate (Author, Result) pairs across different workshops to kill SELECT DISTINCT or GROUP BY mutants.
-- 3. Multiple results for the same author ('Alice') and multiple authors to test primary and secondary ORDER BY directions.
-- 4. Submission_ID vs Workshop_ID numerical overlap (e.g., ID 1 and 2) to kill incorrect join condition (LHS.workshop_id = RHS.submission_id).
INSERT INTO workshop (Workshop_ID, Date, Venue, Name) VALUES (1, '2023-01-01', 'Venue A', 'Workshop 1');
INSERT INTO workshop (Workshop_ID, Date, Venue, Name) VALUES (2, '2023-02-01', 'Venue B', 'Workshop 2');
INSERT INTO workshop (Workshop_ID, Date, Venue, Name) VALUES (10, '2023-03-01', 'Venue C', 'Workshop 10');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (1, 95.5, 'Bob', 'MIT');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (2, 88.0, 'Alice', 'Stanford');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (3, 72.0, 'Charlie', 'Harvard');
INSERT INTO Acceptance (Submission_ID, Workshop_ID, Result) VALUES (1, 10, 'Accepted');
INSERT INTO Acceptance (Submission_ID, Workshop_ID, Result) VALUES (1, 2, 'Accepted');
INSERT INTO Acceptance (Submission_ID, Workshop_ID, Result) VALUES (2, 1, 'Rejected');
INSERT INTO Acceptance (Submission_ID, Workshop_ID, Result) VALUES (2, 2, 'Accepted');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT author, RESULT FROM (SELECT LHS.submission_id AS submission_id, LHS.workshop_id AS workshop_id, LHS.result AS RESULT, RHS.scores AS scores, RHS.author AS author, RHS.college AS college FROM acceptance AS LHS LEFT JOIN submission AS RHS ON (LHS.submission_id = RHS.submission_id)) ORDER BY author, RESULT NULLS LAST;

/*
Gold Result:
('Alice', 'Accepted')
('Alice', 'Rejected')
('Bob', 'Accepted')
('Bob', 'Accepted')
*/

-- Prediction Query
SELECT T2.Author, T1.Result FROM acceptance AS T1 JOIN submission AS T2 ON T1.Submission_ID = T2.Submission_ID;

/*
Prediction Result:
('Bob', 'Accepted')
('Bob', 'Accepted')
('Alice', 'Rejected')
('Alice', 'Accepted')
*/