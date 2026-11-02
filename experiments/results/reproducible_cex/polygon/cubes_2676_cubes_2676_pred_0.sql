-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "workshop" ("workshop_id", "date", "venue", "name") VALUES (7, '1', '1', '1');
INSERT INTO "workshop" ("workshop_id", "date", "venue", "name") VALUES (6, '1', '1', '1');
INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (9, 1, NULL, NULL);
INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (8, 1, '10', NULL);
INSERT INTO "Acceptance" ("submission_id", "workshop_id", "result") VALUES (8, 7, '1');
INSERT INTO "Acceptance" ("submission_id", "workshop_id", "result") VALUES (8, 6, '1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT college, n AS count___ FROM (SELECT author, college, COUNT(*) AS n FROM submission GROUP BY author, college) ORDER BY college, count___ NULLS LAST;

/*
Gold Result:
(None, 1)
(None, 1)
*/

-- Prediction Query
SELECT College, COUNT(*) FROM submission GROUP BY College;

/*
Prediction Result:
(None, 2)
*/