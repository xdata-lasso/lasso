-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO workshop (Workshop_ID, Date, Venue, Name) VALUES (1, '2023-05-01', 'Room A', 'AI Workshop');
INSERT INTO workshop (Workshop_ID, Date, Venue, Name) VALUES (2, '2023-06-15', 'Room B', 'Systems Workshop');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (1, 95.0, 'Alice', 'MIT');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (2, 88.5, 'Alice', 'MIT');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (3, 91.0, 'Alice', 'MIT');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (4, 76.0, 'Bob', 'MIT');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (5, 82.0, 'Charlie', 'MIT');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (6, 90.0, 'Alice', 'Berkeley');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (7, 85.0, 'Alice', 'Berkeley');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (8, 79.5, 'David', 'Stanford');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (9, 84.0, 'David', 'Stanford');
INSERT INTO Acceptance (Submission_ID, Workshop_ID, Result) VALUES (1, 1, 'Accepted');
INSERT INTO Acceptance (Submission_ID, Workshop_ID, Result) VALUES (1, 2, 'Accepted');
INSERT INTO Acceptance (Submission_ID, Workshop_ID, Result) VALUES (2, 1, 'Rejected');
INSERT INTO Acceptance (Submission_ID, Workshop_ID, Result) VALUES (6, 2, 'Accepted');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT college, n AS count___ FROM (SELECT author, college, COUNT(*) AS n FROM submission GROUP BY author, college) ORDER BY college, count___ NULLS LAST;

/*
Gold Result:
('Berkeley', 2)
('MIT', 1)
('MIT', 1)
('MIT', 3)
('Stanford', 2)
*/

-- Prediction Query
SELECT College, COUNT(*) FROM submission GROUP BY College;

/*
Prediction Result:
('Berkeley', 2)
('MIT', 5)
('Stanford', 2)
*/