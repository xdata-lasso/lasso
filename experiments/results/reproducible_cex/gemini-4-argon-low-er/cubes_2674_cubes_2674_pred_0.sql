-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "workshop" ("Workshop_ID", "Date", "Venue", "Name") VALUES (1, 'A', 'B', 'W1');
INSERT INTO "workshop" ("Workshop_ID", "Date", "Venue", "Name") VALUES (2, 'B', 'A', 'W2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, venue FROM workshop ORDER BY date, workshop.workshop_id NULLS LAST;

/*
Gold Result:
('A', 'B')
('B', 'A')
*/

-- Prediction Query
SELECT Date, Venue FROM workshop ORDER BY Venue, workshop.workshop_id NULLS LAST;

/*
Prediction Result:
('B', 'A')
('A', 'B')
*/