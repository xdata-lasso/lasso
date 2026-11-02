-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (1009, 1013.5, 'ago', 'site');
INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (1010, 1018.5, 'ago', 'site');
INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (1011, 1023.5, 'ago', 'site');
INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (1012, 1028.5, 'ago', 'site');
INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (1017, NULL, 'face', 'election');
INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (1018, NULL, 'face', 'election');
INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (1019, NULL, 'face', 'election');
INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (1020, NULL, 'face', 'election');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT college FROM (SELECT * FROM (SELECT * FROM (SELECT author, college, COUNT(*) AS n FROM submission GROUP BY author, college) ORDER BY college DESC) LIMIT 1);

/*
Gold Result:
('site',)
*/

-- Prediction Query
SELECT College FROM submission GROUP BY College ORDER BY COUNT(*) DESC, College NULLS LAST LIMIT 1;

/*
Prediction Result:
('election',)
*/