-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Date ASC, and secondary tie-breaking by Workshop_ID ASC, with Venue in reverse order of Workshop_ID to catch wrong tie-breaker columns.
INSERT INTO "workshop" ("Workshop_ID", "Date", "Venue", "Name") VALUES (10, '2023-05-01', 'Room B', 'AI Workshop');
INSERT INTO "workshop" ("Workshop_ID", "Date", "Venue", "Name") VALUES (2, '2023-01-15', 'Room Z', 'DB Workshop');
INSERT INTO "workshop" ("Workshop_ID", "Date", "Venue", "Name") VALUES (5, '2023-01-15', 'Room A', 'SE Workshop');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, venue FROM workshop ORDER BY date, workshop.workshop_id NULLS LAST;

/*
Gold Result:
('2023-01-15', 'Room Z')
('2023-01-15', 'Room A')
('2023-05-01', 'Room B')
*/

-- Prediction Query
SELECT Date, Venue FROM workshop ORDER BY Venue, workshop.workshop_id NULLS LAST;

/*
Prediction Result:
('2023-01-15', 'Room A')
('2023-05-01', 'Room B')
('2023-01-15', 'Room Z')
*/