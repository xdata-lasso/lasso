-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard grouping by (Author, College), duplicate counts within the same college (testing SELECT vs SELECT DISTINCT), and ordering by College then Count.
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (1, 90.0, 'Alice', 'MIT');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (2, 85.5, 'Alice', 'MIT');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (3, 78.0, 'Bob', 'MIT');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (4, 88.0, 'Charlie', 'MIT');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (5, 92.0, 'Alice', 'Stanford');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (6, 80.0, 'David', 'Harvard');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (7, 81.0, 'David', 'Harvard');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (8, 82.0, 'David', 'Harvard');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT college, n AS count___ FROM (SELECT author, college, COUNT(*) AS n FROM submission GROUP BY author, college) ORDER BY college, count___ NULLS LAST;

/*
Gold Result:
('Harvard', 3)
('MIT', 1)
('MIT', 1)
('MIT', 2)
('Stanford', 1)
*/

-- Prediction Query
SELECT College, COUNT(*) FROM submission GROUP BY College;

/*
Prediction Result:
('Harvard', 3)
('MIT', 4)
('Stanford', 1)
*/