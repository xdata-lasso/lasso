-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO workshop (workshop_id, date, venue, name) VALUES (0, 'default2', NULL, 'default1'), (1, NULL, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, venue FROM workshop ORDER BY date, workshop.workshop_id NULLS LAST;

/*
Gold Result:
(None, 'default1')
('default2', None)
*/

-- Prediction Query
SELECT Date, Venue FROM workshop ORDER BY Venue, workshop.workshop_id NULLS LAST;

/*
Prediction Result:
('default2', None)
(None, 'default1')
*/