-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "workshop" ("Workshop_ID", "Date", "Venue", "Name") VALUES (1, '2023-01-01', 'Hall A', 'WS1');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (1, 90.5, 'Alice', 'MIT');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (2, 85.0, 'Alice', 'MIT');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (3, 88.0, 'Bob', 'MIT');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (4, 92.0, 'Alice', 'Stanford');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (5, 75.0, 'Charlie', 'Berkeley');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (6, 80.0, 'Charlie', 'Berkeley');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (7, 82.0, 'Charlie', 'Berkeley');
INSERT INTO "Acceptance" ("Submission_ID", "Workshop_ID", "Result") VALUES (1, 1, 'Accepted');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT college, n AS count___ FROM (SELECT author, college, COUNT(*) AS n FROM submission GROUP BY author, college) ORDER BY college, count___ NULLS LAST;

/*
Gold Result:
('Berkeley', 3)
('MIT', 1)
('MIT', 2)
('Stanford', 1)
*/

-- Prediction Query
SELECT College, COUNT(*) FROM submission GROUP BY College;

/*
Prediction Result:
('Berkeley', 3)
('MIT', 3)
('Stanford', 1)
*/