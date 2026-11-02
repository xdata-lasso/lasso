-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Author with multiple submissions having DIFFERENT acceptance counts (tests GROUP BY submission_id vs GROUP BY author).
-- 2. Submission with multiple acceptances (tests SELECT DISTINCT deduplication of joined rows).
-- 3. Submission with 0 acceptances (tests INNER JOIN vs LEFT JOIN).
-- 4. Different Result values including NULL (tests COUNT(*) vs COUNT(Result) or unwanted WHERE Result = 'Accepted' filters).
INSERT INTO workshop (Workshop_ID, Date, Venue, Name) VALUES (1, '2023-01-01', 'Venue A', 'WS 1');
INSERT INTO workshop (Workshop_ID, Date, Venue, Name) VALUES (2, '2023-01-02', 'Venue B', 'WS 2');
INSERT INTO workshop (Workshop_ID, Date, Venue, Name) VALUES (3, '2023-01-03', 'Venue C', 'WS 3');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (101, 95.5, 'Alice', 'MIT');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (102, 88.0, 'Alice', 'MIT');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (103, 72.0, 'Bob', 'Stanford');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (104, 60.0, 'Charlie', 'Harvard');
INSERT INTO Acceptance (Submission_ID, Workshop_ID, Result) VALUES (101, 1, 'Accepted');
INSERT INTO Acceptance (Submission_ID, Workshop_ID, Result) VALUES (101, 2, 'Rejected');
INSERT INTO Acceptance (Submission_ID, Workshop_ID, Result) VALUES (102, 3, 'Accepted');
INSERT INTO Acceptance (Submission_ID, Workshop_ID, Result) VALUES (103, 1, NULL);
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
('Alice', 3)
('Bob', 1)
*/