-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO submission (submission_id, scores, author, college) VALUES (1, NULL, 'default1', 'default2'), (0, 0.0, 'default1', 'default2'), (2, 0.0, NULL, NULL), (3, 1.0, 'default2', 'default2'), (4, NULL, 'default1', 'default2'), (5, NULL, 'default2', NULL), (6, NULL, 'default2', NULL), (7, 0.0, 'default2', 'default1'), (8, 1.0, 'default1', 'default2'), (9, NULL, 'default2', 'default2'), (10, NULL, 'default2', NULL), (11, NULL, 'default2', 'default1');
INSERT INTO workshop (workshop_id, date, venue, name) VALUES (0, NULL, 'default2', 'default2'), (1, NULL, 'default1', NULL), (2, NULL, 'default1', NULL);
INSERT INTO acceptance (submission_id, workshop_id, result) VALUES (6, 0, 'default2'), (3, 0, 'default1'), (1, 0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT author, RESULT FROM (SELECT LHS.submission_id AS submission_id, LHS.workshop_id AS workshop_id, LHS.result AS RESULT, RHS.scores AS scores, RHS.author AS author, RHS.college AS college FROM acceptance AS LHS LEFT JOIN submission AS RHS ON (LHS.submission_id = RHS.submission_id)) ORDER BY author, RESULT NULLS LAST;

/*
Gold Result:
('default1', 'default1')
('default2', 'default1')
('default2', 'default2')
*/

-- Prediction Query
SELECT T2.Author, T1.Result FROM acceptance AS T1 JOIN submission AS T2 ON T1.Submission_ID = T2.Submission_ID;

/*
Prediction Result:
('default2', 'default2')
('default2', 'default1')
('default1', 'default1')
*/