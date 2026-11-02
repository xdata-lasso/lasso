-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO workshop (Workshop_ID, Date, Venue, Name) VALUES (1, '2023-05-10', 'Venue B', 'Workshop Alpha');
INSERT INTO workshop (Workshop_ID, Date, Venue, Name) VALUES (2, '2023-01-15', 'Venue C', 'Workshop Beta');
INSERT INTO workshop (Workshop_ID, Date, Venue, Name) VALUES (3, '2023-01-15', 'Venue A', 'Workshop Gamma');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (101, 88.5, 'Alice', 'MIT');
INSERT INTO submission (Submission_ID, Scores, Author, College) VALUES (102, 92.0, 'Bob', 'Stanford');
INSERT INTO Acceptance (Submission_ID, Workshop_ID, Result) VALUES (101, 1, 'Accepted');
INSERT INTO Acceptance (Submission_ID, Workshop_ID, Result) VALUES (102, 1, 'Rejected');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, venue FROM workshop ORDER BY date, workshop.workshop_id NULLS LAST;

/*
Gold Result:
('2023-01-15', 'Venue C')
('2023-01-15', 'Venue A')
('2023-05-10', 'Venue B')
*/

-- Prediction Query
SELECT Date, Venue FROM workshop ORDER BY Venue, workshop.workshop_id NULLS LAST;

/*
Prediction Result:
('2023-01-15', 'Venue A')
('2023-05-10', 'Venue B')
('2023-01-15', 'Venue C')
*/