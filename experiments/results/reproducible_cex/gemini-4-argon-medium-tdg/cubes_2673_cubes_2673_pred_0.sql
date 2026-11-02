-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (out-of-order insertion), duplicate authors (kills SELECT DISTINCT / GROUP BY), and unreferenced submissions (kills INNER JOIN with Acceptance).
INSERT INTO "workshop" ("Workshop_ID", "Date", "Venue", "Name") VALUES (1, '2023-05-01', 'Room A', 'AI Workshop');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (10, 85.0, 'Charlie', 'MIT');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (20, 90.0, 'Alice', 'Stanford');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (30, 75.0, 'Bob', 'CMU');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (40, 95.0, 'Alice', 'Harvard');
INSERT INTO "Acceptance" ("Submission_ID", "Workshop_ID", "Result") VALUES (10, 1, 'Accepted');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT author FROM submission ORDER BY author, submission.submission_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('Bob',)
('Charlie',)
*/

-- Prediction Query
SELECT Author FROM submission ORDER BY Scores ASC, submission.submission_id NULLS LAST;

/*
Prediction Result:
('Bob',)
('Charlie',)
('Alice',)
('Alice',)
*/