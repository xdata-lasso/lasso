-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO workshop (Workshop_ID, Date, Venue, Name) VALUES (10, '2023-01-10', 'Hall A', 'Alpha Workshop');
INSERT INTO workshop (Workshop_ID, Date, Venue, Name) VALUES (20, '2023-05-15', 'Hall B', 'Beta Workshop');
INSERT INTO workshop (Workshop_ID, Date, Venue, Name) VALUES (30, '2023-09-20', 'Hall C', 'Gamma Workshop');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (1, 95.0, 'Alice', 'Brown');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (2, 85.5, 'Bob', 'Yale');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (3, 70.0, 'Charlie', 'MIT');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (4, 99.0, 'David', 'Zurich');
INSERT INTO Acceptance (Submission_ID, Workshop_ID, Result) VALUES (1, 30, 'Accepted');
INSERT INTO Acceptance (Submission_ID, Workshop_ID, Result) VALUES (2, 20, 'Pending');
INSERT INTO Acceptance (Submission_ID, Workshop_ID, Result) VALUES (3, 10, 'Rejected');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT RESULT FROM (SELECT * FROM (SELECT * FROM (SELECT LHS.submission_id AS submission_id, LHS.workshop_id AS workshop_id, LHS.result AS RESULT, RHS.scores AS scores, RHS.author AS author, RHS.college AS college FROM acceptance AS LHS LEFT JOIN submission AS RHS ON (LHS.submission_id = RHS.submission_id)) ORDER BY college DESC) LIMIT 1);

/*
Gold Result:
('Pending',)
*/

-- Prediction Query
SELECT T1.Result FROM acceptance AS T1 JOIN submission AS T2 ON T1.Submission_ID = T2.Submission_ID ORDER BY T2.Scores DESC, T1.submission_id NULLS LAST, T1.workshop_id NULLS LAST, T2.submission_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Accepted',)
*/