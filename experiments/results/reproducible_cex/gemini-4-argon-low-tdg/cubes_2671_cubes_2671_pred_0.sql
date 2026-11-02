-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "workshop" ("Workshop_ID", "Date", "Venue", "Name") VALUES (1, '2023-05-01', 'Hall A', 'AI Conf');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (1, 90.0, 'Zack', 'MIT');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (2, 85.0, 'Alice', 'Stanford');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (3, 75.0, 'Bob', 'CMU');
INSERT INTO "Acceptance" ("Submission_ID", "Workshop_ID", "Result") VALUES (3, 1, 'Accepted');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT author FROM (SELECT * FROM submission AS LHS WHERE NOT EXISTS(SELECT 1 FROM acceptance AS RHS WHERE (LHS.submission_id = RHS.submission_id))) ORDER BY author;

/*
Gold Result:
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT Author FROM submission WHERE NOT Submission_ID IN (SELECT Submission_ID FROM acceptance);

/*
Prediction Result:
('Zack',)
('Alice',)
*/