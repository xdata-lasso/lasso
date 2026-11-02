-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO workshop (Workshop_ID, Date, Venue, Name) VALUES (1, '2023-05-10', 'Room A', 'AI Workshop');
INSERT INTO workshop (Workshop_ID, Date, Venue, Name) VALUES (2, '2023-06-15', 'Room B', 'Systems Workshop');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (1, 95.0, 'Alice', 'Yale');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (2, 85.0, 'Alice', 'Harvard');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (3, 70.0, 'Bob', 'Brown');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (4, 80.0, 'Bob', 'Cornell');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (5, 88.5, 'Charlie', 'MIT');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (6, 92.0, 'Charlie', 'MIT');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (7, 60.0, 'Aaron', 'Stanford');
INSERT INTO Acceptance (Submission_ID, Workshop_ID, Result) VALUES (1, 1, 'Accepted');
INSERT INTO Acceptance (Submission_ID, Workshop_ID, Result) VALUES (1, 2, 'Rejected');
INSERT INTO Acceptance (Submission_ID, Workshop_ID, Result) VALUES (3, 1, 'Rejected');
INSERT INTO Acceptance (Submission_ID, Workshop_ID, Result) VALUES (5, 2, 'Accepted');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT author, college FROM submission ORDER BY author, submission.submission_id NULLS LAST;

/*
Gold Result:
('Aaron', 'Stanford')
('Alice', 'Yale')
('Alice', 'Harvard')
('Bob', 'Brown')
('Bob', 'Cornell')
('Charlie', 'MIT')
('Charlie', 'MIT')
*/

-- Prediction Query
SELECT Author, College FROM submission;

/*
Prediction Result:
('Alice', 'Yale')
('Alice', 'Harvard')
('Bob', 'Brown')
('Bob', 'Cornell')
('Charlie', 'MIT')
('Charlie', 'MIT')
('Aaron', 'Stanford')
*/