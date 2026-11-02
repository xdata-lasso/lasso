-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (1014, 1015.5, 'option', 'agreement');
INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (1016, 1016.5, 'early', 'mouth');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT author FROM (SELECT * FROM submission AS LHS WHERE NOT EXISTS(SELECT 1 FROM acceptance AS RHS WHERE (LHS.submission_id = RHS.submission_id))) ORDER BY author;

/*
Gold Result:
('early',)
('option',)
*/

-- Prediction Query
SELECT Author FROM submission WHERE NOT Submission_ID IN (SELECT Submission_ID FROM acceptance);

/*
Prediction Result:
('option',)
('early',)
*/