-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "workshop" ("Workshop_ID", "Date", "Venue", "Name") VALUES (1, '2023-05-01', 'Miami', 'AI Conf');
INSERT INTO "workshop" ("Workshop_ID", "Date", "Venue", "Name") VALUES (2, '2023-06-15', 'Philadelphia', 'DB Conf');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (1, 85.5, 'Zack', 'Florida');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (2, 92.0, 'Alice', 'Temple');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (3, 78.0, 'Bob', 'Harvard');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (4, 88.0, 'Alice', 'Florida');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (5, 60.0, 'Charlie', NULL);
INSERT INTO "Acceptance" ("Submission_ID", "Workshop_ID", "Result") VALUES (1, 1, 'Accepted');
INSERT INTO "Acceptance" ("Submission_ID", "Workshop_ID", "Result") VALUES (1, 2, 'Rejected');
INSERT INTO "Acceptance" ("Submission_ID", "Workshop_ID", "Result") VALUES (3, 1, 'Accepted');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "author" FROM "submission" WHERE ("college" = 'Florida' OR "college" = 'Temple') ORDER BY author, submission.submission_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT Author FROM submission WHERE College = 'Florida' OR College = 'Temple';

/*
Prediction Result:
('Zack',)
('Alice',)
('Alice',)
*/