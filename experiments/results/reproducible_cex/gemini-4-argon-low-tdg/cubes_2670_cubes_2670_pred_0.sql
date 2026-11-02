-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- General comprehensive dataset:
-- Tests ORDER BY college DESC vs ORDER BY COUNT(*) DESC, ORDER BY Scores DESC, ORDER BY Author DESC, ORDER BY Submission_ID.
-- Also tests erroneous inner joins with Acceptance/workshop since Yale (the top college alphabetically DESC) has no rows in Acceptance.
INSERT INTO workshop (Workshop_ID, Date, Venue, Name) VALUES (1, '2023-01-01', 'New York', 'AI Conf');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (1, 95.0, 'Zack', 'MIT');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (2, 95.0, 'Zack', 'MIT');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (3, 95.0, 'Zack', 'MIT');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (4, 80.0, 'Bob', 'Stanford');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (5, 85.0, 'Bob', 'Stanford');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (6, 50.0, 'Alice', 'Yale');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (7, 100.0, 'Charlie', 'Berkeley');
INSERT INTO Acceptance (Submission_ID, Workshop_ID, Result) VALUES (1, 1, 'Accepted');
INSERT INTO Acceptance (Submission_ID, Workshop_ID, Result) VALUES (4, 1, 'Rejected');
INSERT INTO Acceptance (Submission_ID, Workshop_ID, Result) VALUES (7, 1, 'Accepted');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT college FROM (SELECT * FROM (SELECT * FROM (SELECT author, college, COUNT(*) AS n FROM submission GROUP BY author, college) ORDER BY college DESC) LIMIT 1);

/*
Gold Result:
('Yale',)
*/

-- Prediction Query
SELECT College FROM submission GROUP BY College ORDER BY COUNT(*) DESC, College NULLS LAST LIMIT 1;

/*
Prediction Result:
('MIT',)
*/