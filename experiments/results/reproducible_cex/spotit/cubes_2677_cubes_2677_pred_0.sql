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
INSERT INTO WORKSHOP VALUES (0, 0, 0, 0);
INSERT INTO WORKSHOP VALUES (1, 0, 0, 0);
INSERT INTO SUBMISSION VALUES (-1, 0, 29, 30);
INSERT INTO SUBMISSION VALUES (0, -1, 32, 33);
INSERT INTO ACCEPTANCE VALUES (0, 1, 28);
INSERT INTO ACCEPTANCE VALUES (-1, 0, 31);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT RESULT FROM (SELECT * FROM (SELECT * FROM (SELECT LHS.submission_id AS submission_id, LHS.workshop_id AS workshop_id, LHS.result AS RESULT, RHS.scores AS scores, RHS.author AS author, RHS.college AS college FROM acceptance AS LHS LEFT JOIN submission AS RHS ON (LHS.submission_id = RHS.submission_id)) ORDER BY college DESC) LIMIT 1);

/*
Gold Result:
('28',)
*/

-- Prediction Query
SELECT T1.Result FROM acceptance AS T1 JOIN submission AS T2 ON T1.Submission_ID = T2.Submission_ID ORDER BY T2.Scores DESC, T1.submission_id NULLS LAST, T1.workshop_id NULLS LAST, T2.submission_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('31',)
*/