-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: submission --
INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (-2147483648, 582.588439, 'sub_29d56f', 'sub_c7113a');

INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (-2147483647, 680.190136, 'sub_29d56f', 'sub_c7113a');

INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (-2147483646, 487.053947, 'sub_29d56f', 'sub_c7113a');

INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (-2147483645, 486.033807, 'sub_29d56f', 'sub_c7113a');

INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (-2147483644, 345.329712, 'sub_29d56f', 'sub_c7113a');

INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (-2147483643, 833.684115, 'sub_29d56f', 'sub_c7113a');

INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (-2147483642, 261.897639, 'sub_29d56f', NULL);

INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (-2147483641, 97.952323, 'sub_29d56f', NULL);

INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (-2147483640, 171.746906, 'sub_29d56f', NULL);

INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (-2147483639, 557.512061, NULL, 'sub_c7113a');

INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (-2147483638, 868.436572, NULL, 'sub_c7113a');

INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (-2147483637, 537.136345, NULL, 'sub_c7113a');

INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (-2147483636, 38.937207, 'sub_29d56f', 'sub_c7113a');

INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (-2147483635, 249.706432, 'sub_29d56f', 'sub_c7113a');

INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (-2147483634, 99.523333, 'sub_29d56f', 'sub_c7113a');

INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (-2147483633, 314.813297, 'sub_29d56f', 'sub_c7113a');

INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (-2147483632, 328.996339, 'sub_29d56f', 'sub_c7113a');

INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (-2147483631, 906.21648, 'sub_29d56f', 'sub_c7113a');

INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (-2147483630, 483.665643, 'sub_29d56f', 'sub_c7113a');

INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (-2147483629, 818.685402, 'sub_29d56f', 'sub_c7113a');

INSERT INTO "submission" ("submission_id", "scores", "author", "college") VALUES (-2147483628, 804.971537, 'sub_29d56f', 'sub_c7113a');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT college, n AS count___ FROM (SELECT author, college, COUNT(*) AS n FROM submission GROUP BY author, college) ORDER BY college, count___ NULLS LAST;

/*
Gold Result:
(None, 3)
('sub_c7113a', 3)
('sub_c7113a', 15)
*/

-- Prediction Query
SELECT College, COUNT(*) FROM submission GROUP BY College;

/*
Prediction Result:
(None, 3)
('sub_c7113a', 18)
*/