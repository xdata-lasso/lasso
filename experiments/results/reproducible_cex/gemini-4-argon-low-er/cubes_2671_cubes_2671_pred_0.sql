-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO submission (Submission_ID, Author) VALUES (1, 'B');
INSERT INTO submission (Submission_ID, Author) VALUES (2, 'A');
INSERT INTO Acceptance (Submission_ID, Workshop_ID, Result) VALUES (NULL, NULL, 'Accepted');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT author FROM (SELECT * FROM submission AS LHS WHERE NOT EXISTS(SELECT 1 FROM acceptance AS RHS WHERE (LHS.submission_id = RHS.submission_id))) ORDER BY author;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT Author FROM submission WHERE NOT Submission_ID IN (SELECT Submission_ID FROM acceptance);

/*
Prediction Result:
*/