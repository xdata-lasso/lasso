-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (1, 90.0, 'Bob', 'MIT');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (2, 85.0, 'Alice', 'Stanford');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT author, college FROM submission ORDER BY author, submission.submission_id NULLS LAST;

/*
Gold Result:
('Alice', 'Stanford')
('Bob', 'MIT')
*/

-- Prediction Query
SELECT Author, College FROM submission;

/*
Prediction Result:
('Bob', 'MIT')
('Alice', 'Stanford')
*/