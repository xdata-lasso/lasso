-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO submission (submission_id, scores, author, college) VALUES (0, NULL, 'default1', NULL), (1, 0.0, 'default2', 'default2'), (2, 1.0, 'default1', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT author FROM submission ORDER BY author, submission.submission_id NULLS LAST;

/*
Gold Result:
('default1',)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT Author FROM submission ORDER BY Scores ASC, submission.submission_id NULLS LAST;

/*
Prediction Result:
('default1',)
('default2',)
('default1',)
*/