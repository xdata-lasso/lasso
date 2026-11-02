-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (1, 95.0, 'Alice', 'Alpha University');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (2, 92.0, 'Alice', 'Alpha University');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (3, 90.0, 'Alice', 'Alpha University');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (4, 80.0, 'Bob', 'Beta College');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (5, 85.0, 'Bob', 'Beta College');
INSERT INTO "submission" ("Submission_ID", "Scores", "Author", "College") VALUES (6, 70.0, 'Charlie', 'Zeta Institute');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT college FROM (SELECT * FROM (SELECT * FROM (SELECT author, college, COUNT(*) AS n FROM submission GROUP BY author, college) ORDER BY college DESC) LIMIT 1);

/*
Gold Result:
('Zeta Institute',)
*/

-- Prediction Query
SELECT College FROM submission GROUP BY College ORDER BY COUNT(*) DESC, College NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alpha University',)
*/