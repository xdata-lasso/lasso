-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO workshop (Workshop_ID, Date, Venue, Name) VALUES (1, '2023-05-10', 'Room A', 'AI Symposium');
INSERT INTO workshop (Workshop_ID, Date, Venue, Name) VALUES (2, '2023-06-15', 'Hall B', 'Systems Workshop');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (1, 85.5, 'Zack', 'Cornell');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (2, 92.0, 'Alice', 'Brown');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (3, 78.0, 'Bob', 'Duke');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (4, 88.0, 'Alice', 'Yale');
INSERT INTO Acceptance (Submission_ID, Workshop_ID, Result) VALUES (1, 1, 'Accepted');
INSERT INTO Acceptance (Submission_ID, Workshop_ID, Result) VALUES (2, 1, 'Accepted');
INSERT INTO Acceptance (Submission_ID, Workshop_ID, Result) VALUES (2, 2, 'Rejected');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT author FROM submission ORDER BY author, submission.submission_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('Bob',)
('Zack',)
*/

-- Prediction Query
SELECT Author FROM submission ORDER BY Scores ASC, submission.submission_id NULLS LAST;

/*
Prediction Result:
('Bob',)
('Zack',)
('Alice',)
('Alice',)
*/