-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Submission with no acceptances (checks INNER JOIN vs LEFT JOIN).
-- 2. Single submission with multiple acceptances (checks SELECT DISTINCT vs SELECT ALL, and COUNT(*) > 1).
-- 3. Same author with multiple submissions having DIFFERENT acceptance counts (checks GROUP BY submission_id vs GROUP BY author).
-- 4. Different authors with the same acceptance count and ordering checks (ORDER BY author, n).
INSERT INTO "workshop" ("Workshop_ID", "Date", "Venue", "Name") VALUES (101, '2023-01-01', 'Room A', 'AI Workshop');
INSERT INTO "workshop" ("Workshop_ID", "Date", "Venue", "Name") VALUES (102, '2023-01-02', 'Room B', 'DB Workshop');
INSERT INTO "workshop" ("Workshop_ID", "Date", "Venue", "Name") VALUES (103, '2023-01-03', 'Room C', 'SE Workshop');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (1, 85.5, 'Alice', 'MIT');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (2, 90.0, 'Alice', 'MIT');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (3, 75.0, 'Bob', 'Stanford');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (4, 60.0, 'Charlie', 'CMU');
INSERT INTO "Acceptance" ("Submission_ID", "Workshop_ID", "Result") VALUES (1, 101, 'Accepted');
INSERT INTO "Acceptance" ("Submission_ID", "Workshop_ID", "Result") VALUES (2, 101, 'Accepted');
INSERT INTO "Acceptance" ("Submission_ID", "Workshop_ID", "Result") VALUES (2, 102, 'Rejected');
INSERT INTO "Acceptance" ("Submission_ID", "Workshop_ID", "Result") VALUES (3, 103, 'Accepted');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author, n AS count_distinct_t1_workshop_id_ FROM (SELECT LHS.submission_id AS submission_id, LHS.scores AS scores, LHS.author AS author, LHS.college AS college, LHS.workshop_id AS workshop_id, LHS.result AS RESULT, RHS.n AS n FROM (SELECT LHS.submission_id AS submission_id, LHS.scores AS scores, LHS.author AS author, LHS.college AS college, RHS.workshop_id AS workshop_id, RHS.result AS RESULT FROM submission AS LHS INNER JOIN acceptance AS RHS ON (LHS.submission_id = RHS.submission_id)) AS LHS INNER JOIN (SELECT submission_id, COUNT(*) AS n FROM acceptance GROUP BY submission_id) AS RHS ON (LHS.submission_id = RHS.submission_id)) ORDER BY author, count_distinct_t1_workshop_id_ NULLS LAST;

/*
Gold Result:
('Alice', 1)
('Alice', 2)
('Bob', 1)
*/

-- Prediction Query
SELECT T2.Author, COUNT(DISTINCT T1.workshop_id) FROM acceptance AS T1 JOIN submission AS T2 ON T1.Submission_ID = T2.Submission_ID GROUP BY T2.Author;

/*
Prediction Result:
('Alice', 2)
('Bob', 1)
*/