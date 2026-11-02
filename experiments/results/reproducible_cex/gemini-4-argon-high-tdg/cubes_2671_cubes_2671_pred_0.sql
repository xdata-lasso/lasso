-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO workshop (Workshop_ID, Date, Venue, Name) VALUES (10, '2023-05-01', 'Room A', 'AI Workshop');
INSERT INTO workshop (Workshop_ID, Date, Venue, Name) VALUES (20, '2023-06-01', 'Room B', 'DB Workshop');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (1, 85.5, 'David', 'MIT');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (2, 92.0, 'Bob', 'Stanford');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (10, 99.0, 'Charlie', 'Harvard');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (15, 85.0, 'Alice', 'Yale');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (20, 90.0, 'Eve', 'Berkeley');
INSERT INTO Acceptance (Submission_ID, Workshop_ID, Result) VALUES (1, 10, 'Accepted');
INSERT INTO Acceptance (Submission_ID, Workshop_ID, Result) VALUES (2, 20, 'Rejected');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT author FROM (SELECT * FROM submission AS LHS WHERE NOT EXISTS(SELECT 1 FROM acceptance AS RHS WHERE (LHS.submission_id = RHS.submission_id))) ORDER BY author;

/*
Gold Result:
('Alice',)
('Charlie',)
('Eve',)
*/

-- Prediction Query
SELECT Author FROM submission WHERE NOT Submission_ID IN (SELECT Submission_ID FROM acceptance);

/*
Prediction Result:
('Charlie',)
('Alice',)
('Eve',)
*/