-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO submission (submission_id, scores, author, college) VALUES (1, 1.0, NULL, 'default2'), (0, NULL, 'default1', NULL), (2, NULL, 'default1', NULL), (3, 1.0, 'default2', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT college, n AS count___ FROM (SELECT author, college, COUNT(*) AS n FROM submission GROUP BY author, college) ORDER BY college, count___ NULLS LAST;

/*
Gold Result:
(None, 2)
('default2', 1)
('default2', 1)
*/

-- Prediction Query
SELECT College, COUNT(*) FROM submission GROUP BY College;

/*
Prediction Result:
(None, 2)
('default2', 2)
*/