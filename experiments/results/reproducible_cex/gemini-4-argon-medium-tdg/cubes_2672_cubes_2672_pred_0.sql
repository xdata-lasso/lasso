-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests NULL handling in Author, College, and Scores (catches WHERE IS NOT NULL mutants and NULLS FIRST/LAST ordering mutants on author).
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (3, 90.0, NULL, 'Harvard');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (1, NULL, NULL, 'Yale');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (2, 75.0, 'Charlie', NULL);
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (4, 80.0, 'Alice', 'MIT');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT author, college FROM submission ORDER BY author, submission.submission_id NULLS LAST;

/*
Gold Result:
(None, 'Yale')
(None, 'Harvard')
('Alice', 'MIT')
('Charlie', None)
*/

-- Prediction Query
SELECT Author, College FROM submission;

/*
Prediction Result:
(None, 'Yale')
('Charlie', None)
(None, 'Harvard')
('Alice', 'MIT')
*/