-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (1, 100.0, 'Alice', 'Stanford');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (2, 75.0, 'Alice', 'Berkeley');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (3, 90.0, 'Bob', 'Stanford');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT author FROM (SELECT LHS.submission_id AS submission_id, LHS.scores AS scores, LHS.author AS author, LHS.college AS college, LHS.maxscores AS maxscores, RHS.submission_id AS submission_id_other, RHS.college AS college_other, RHS.maxscores AS maxscores_other FROM (SELECT submission_id, scores, author, college, MAX(scores) OVER () AS maxscores FROM submission) AS LHS INNER JOIN (SELECT submission_id, scores, author, college, MAX(scores) OVER () AS maxscores FROM submission) AS RHS ON (LHS.author = RHS.author AND LHS.maxscores = RHS.scores)) ORDER BY author;

/*
Gold Result:
('Alice',)
('Alice',)
*/

-- Prediction Query
SELECT Author FROM submission ORDER BY Scores DESC, submission.submission_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alice',)
*/