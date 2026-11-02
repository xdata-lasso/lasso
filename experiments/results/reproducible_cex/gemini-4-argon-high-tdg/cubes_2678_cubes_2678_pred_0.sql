-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO workshop (Workshop_ID, Date, Venue, Name) VALUES (1, '2023-01-10', 'Room A', 'AI Workshop');
INSERT INTO workshop (Workshop_ID, Date, Venue, Name) VALUES (2, '2023-02-15', 'Room B', 'Systems Workshop');
INSERT INTO workshop (Workshop_ID, Date, Venue, Name) VALUES (3, '2023-03-20', 'Room C', 'Unused Workshop');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (1, 95.5, 'Zack', 'MIT');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (2, 82.0, 'Alice', 'Stanford');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (3, 70.0, 'Alice', 'Berkeley');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (4, 60.0, 'Bob', 'CMU');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (5, 88.0, 'Unmatched Author', 'Harvard');
INSERT INTO Acceptance (Submission_ID, Workshop_ID, Result) VALUES (1, 2, 'Rejected');
INSERT INTO Acceptance (Submission_ID, Workshop_ID, Result) VALUES (2, 1, 'Rejected');
INSERT INTO Acceptance (Submission_ID, Workshop_ID, Result) VALUES (3, 2, 'Accepted');
INSERT INTO Acceptance (Submission_ID, Workshop_ID, Result) VALUES (4, 1, 'Accepted');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT author, RESULT FROM (SELECT LHS.submission_id AS submission_id, LHS.workshop_id AS workshop_id, LHS.result AS RESULT, RHS.scores AS scores, RHS.author AS author, RHS.college AS college FROM acceptance AS LHS LEFT JOIN submission AS RHS ON (LHS.submission_id = RHS.submission_id)) ORDER BY author, RESULT NULLS LAST;

/*
Gold Result:
('Alice', 'Accepted')
('Alice', 'Rejected')
('Bob', 'Accepted')
('Zack', 'Rejected')
*/

-- Prediction Query
SELECT T2.Author, T1.Result FROM acceptance AS T1 JOIN submission AS T2 ON T1.Submission_ID = T2.Submission_ID;

/*
Prediction Result:
('Zack', 'Rejected')
('Alice', 'Rejected')
('Alice', 'Accepted')
('Bob', 'Accepted')
*/