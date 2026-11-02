-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO submission (submission_id, scores, author, college) VALUES (1, NULL, NULL, NULL), (0, 1.0, NULL, 'default1'), (2, 1.0, 'default2', NULL), (3, 1.0, NULL, 'default1');
INSERT INTO workshop (workshop_id, date, venue, name) VALUES (1, NULL, 'default2', 'default1'), (0, NULL, NULL, NULL), (2, 'default2', 'default1', 'default1'), (3, 'default2', 'default1', NULL);
INSERT INTO acceptance (submission_id, workshop_id, result) VALUES (1, 1, 'default2'), (3, 3, 'default2'), (1, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author, n AS count_distinct_t1_workshop_id_ FROM (SELECT LHS.submission_id AS submission_id, LHS.scores AS scores, LHS.author AS author, LHS.college AS college, LHS.workshop_id AS workshop_id, LHS.result AS RESULT, RHS.n AS n FROM (SELECT LHS.submission_id AS submission_id, LHS.scores AS scores, LHS.author AS author, LHS.college AS college, RHS.workshop_id AS workshop_id, RHS.result AS RESULT FROM submission AS LHS INNER JOIN acceptance AS RHS ON (LHS.submission_id = RHS.submission_id)) AS LHS INNER JOIN (SELECT submission_id, COUNT(*) AS n FROM acceptance GROUP BY submission_id) AS RHS ON (LHS.submission_id = RHS.submission_id)) ORDER BY author, count_distinct_t1_workshop_id_ NULLS LAST;

/*
Gold Result:
(None, 1)
(None, 2)
*/

-- Prediction Query
SELECT T2.Author, COUNT(DISTINCT T1.workshop_id) FROM acceptance AS T1 JOIN submission AS T2 ON T1.Submission_ID = T2.Submission_ID GROUP BY T2.Author;

/*
Prediction Result:
(None, 3)
*/