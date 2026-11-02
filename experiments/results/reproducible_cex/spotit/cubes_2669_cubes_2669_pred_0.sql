-- Schema DDL
CREATE TABLE "WORKSHOP" (
    "WORKSHOP_ID" INT,
    "DATE" TEXT,
    "VENUE" TEXT,
    "NAME" TEXT,
    PRIMARY KEY ("WORKSHOP_ID")
);
CREATE TABLE "SUBMISSION" (
    "SUBMISSION_ID" INT,
    "SCORES" FLOAT,
    "AUTHOR" TEXT,
    "COLLEGE" TEXT,
    PRIMARY KEY ("SUBMISSION_ID")
);
CREATE TABLE "ACCEPTANCE" (
    "SUBMISSION_ID" INT,
    "WORKSHOP_ID" INT,
    "RESULT" TEXT,
    PRIMARY KEY ("SUBMISSION_ID", "WORKSHOP_ID"),
    FOREIGN KEY ("WORKSHOP_ID") REFERENCES "WORKSHOP"("WORKSHOP_ID"),
    FOREIGN KEY ("SUBMISSION_ID") REFERENCES "SUBMISSION"("SUBMISSION_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO WORKSHOP VALUES (-1, 0, 0, 0);
INSERT INTO WORKSHOP VALUES (0, 0, 0, 0);
INSERT INTO SUBMISSION VALUES (0, 64, 1, 65);
INSERT INTO SUBMISSION VALUES (1, 67, 1, 68);
INSERT INTO ACCEPTANCE VALUES (1, -1, 63);
INSERT INTO ACCEPTANCE VALUES (0, 0, 66);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT author, n AS count_distinct_t1_workshop_id_ FROM (SELECT LHS.submission_id AS submission_id, LHS.scores AS scores, LHS.author AS author, LHS.college AS college, LHS.workshop_id AS workshop_id, LHS.result AS RESULT, RHS.n AS n FROM (SELECT LHS.submission_id AS submission_id, LHS.scores AS scores, LHS.author AS author, LHS.college AS college, RHS.workshop_id AS workshop_id, RHS.result AS RESULT FROM submission AS LHS INNER JOIN acceptance AS RHS ON (LHS.submission_id = RHS.submission_id)) AS LHS INNER JOIN (SELECT submission_id, COUNT(*) AS n FROM acceptance GROUP BY submission_id) AS RHS ON (LHS.submission_id = RHS.submission_id)) ORDER BY author, count_distinct_t1_workshop_id_ NULLS LAST;

/*
Gold Result:
('1', 1)
*/

-- Prediction Query
SELECT T2.Author, COUNT(DISTINCT T1.workshop_id) FROM acceptance AS T1 JOIN submission AS T2 ON T1.Submission_ID = T2.Submission_ID GROUP BY T2.Author;

/*
Prediction Result:
('1', 2)
*/