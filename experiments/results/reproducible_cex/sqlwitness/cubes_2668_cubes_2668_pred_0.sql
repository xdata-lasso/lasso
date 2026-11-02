-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO submission (submission_id, scores, author, college) VALUES (0, 1.0, 'Florida', 'default1'), (1, NULL, 'default1', 'Florida'), (2, 1.0, NULL, 'Temple'), (3, 1.0, NULL, 'default1'), (4, 0.0, 'Florida', 'default1'), (5, 0.0, 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "author" FROM "submission" WHERE ("college" = 'Florida' OR "college" = 'Temple') ORDER BY author, submission.submission_id NULLS LAST;

/*
Gold Result:
(None,)
('default1',)
*/

-- Prediction Query
SELECT Author FROM submission WHERE College = 'Florida' OR College = 'Temple';

/*
Prediction Result:
('default1',)
(None,)
*/