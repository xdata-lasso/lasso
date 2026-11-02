-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (1, 95.5, 'Charlie', 'MIT');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (2, 45.0, 'Alice', 'Stanford');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (3, 80.0, 'Alice', 'Harvard');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (4, 60.0, 'Bob', 'Berkeley');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (5, 70.0, NULL, 'CMU');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT author FROM submission ORDER BY author, submission.submission_id NULLS LAST;

/*
Gold Result:
(None,)
('Alice',)
('Alice',)
('Bob',)
('Charlie',)
*/

-- Prediction Query
SELECT Author FROM submission ORDER BY Scores ASC, submission.submission_id NULLS LAST;

/*
Prediction Result:
('Alice',)
('Bob',)
(None,)
('Alice',)
('Charlie',)
*/