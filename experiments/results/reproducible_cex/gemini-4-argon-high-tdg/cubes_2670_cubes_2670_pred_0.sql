-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO workshop (Workshop_ID, Date, Venue, Name) VALUES (1, '2023-05-10', 'Hall A', 'AI Workshop');
INSERT INTO workshop (Workshop_ID, Date, Venue, Name) VALUES (2, '2023-06-15', 'Hall B', 'Systems Workshop');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (1, 50.0, 'Charlie', 'Alpha University');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (2, 55.0, 'Charlie', 'Alpha University');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (3, 60.0, 'Charlie', 'Alpha University');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (4, 70.0, 'Bob', 'Zeta');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (5, 80.0, 'Bob', 'Zeta');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (6, 98.5, 'Alice', 'Bay');
INSERT INTO Acceptance (Submission_ID, Workshop_ID, Result) VALUES (1, 1, 'Accepted');
INSERT INTO Acceptance (Submission_ID, Workshop_ID, Result) VALUES (6, 2, 'Accepted');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT college FROM (SELECT * FROM (SELECT * FROM (SELECT author, college, COUNT(*) AS n FROM submission GROUP BY author, college) ORDER BY college DESC) LIMIT 1);

/*
Gold Result:
('Zeta',)
*/

-- Prediction Query
SELECT College FROM submission GROUP BY College ORDER BY COUNT(*) DESC, College NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alpha University',)
*/