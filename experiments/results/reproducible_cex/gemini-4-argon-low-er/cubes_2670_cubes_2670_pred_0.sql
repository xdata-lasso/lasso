-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (1, 10.0, 'Alice', 'A_College');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (2, 10.0, 'Bob', 'A_College');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (3, 10.0, 'Charlie', 'Z_College');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT college FROM (SELECT * FROM (SELECT * FROM (SELECT author, college, COUNT(*) AS n FROM submission GROUP BY author, college) ORDER BY college DESC) LIMIT 1);

/*
Gold Result:
('Z_College',)
*/

-- Prediction Query
SELECT College FROM submission GROUP BY College ORDER BY COUNT(*) DESC, College NULLS LAST LIMIT 1;

/*
Prediction Result:
('A_College',)
*/