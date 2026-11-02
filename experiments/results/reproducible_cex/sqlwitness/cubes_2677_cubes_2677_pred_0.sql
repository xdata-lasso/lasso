-- Schema DDL
CREATE TABLE "workshop" ("Workshop_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Venue" TEXT, "Name" TEXT);

CREATE TABLE "submission" ("Submission_ID" INTEGER PRIMARY KEY, "Scores" REAL, "Author" TEXT, "College" TEXT);

CREATE TABLE "Acceptance" ("Submission_ID" INTEGER, "Workshop_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Submission_ID", "Workshop_ID"), FOREIGN KEY ("Workshop_ID") REFERENCES "workshop" ("Workshop_ID"), FOREIGN KEY ("Submission_ID") REFERENCES "submission" ("Submission_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO submission (submission_id, scores, author, college) VALUES (1, 2.0, NULL, NULL), (0, 2.0, 'default1', 'default1'), (2, 2.0, 'default1', 'default2'), (3, 0.0, 'default2', NULL), (4, NULL, 'default2', 'default2'), (5, 2.0, 'default2', 'default1'), (6, 0.0, NULL, 'default2');
INSERT INTO workshop (workshop_id, date, venue, name) VALUES (0, NULL, 'default2', NULL), (1, NULL, 'default2', 'default1'), (2, NULL, 'default1', 'default1'), (3, 'default1', NULL, NULL), (4, NULL, 'default2', NULL), (5, NULL, 'default2', NULL), (6, 'default1', 'default2', 'default2');
INSERT INTO acceptance (submission_id, workshop_id, result) VALUES (6, 1, 'default2'), (6, 5, 'default1'), (2, 2, NULL), (1, 3, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT RESULT FROM (SELECT * FROM (SELECT * FROM (SELECT LHS.submission_id AS submission_id, LHS.workshop_id AS workshop_id, LHS.result AS RESULT, RHS.scores AS scores, RHS.author AS author, RHS.college AS college FROM acceptance AS LHS LEFT JOIN submission AS RHS ON (LHS.submission_id = RHS.submission_id)) ORDER BY college DESC) LIMIT 1);

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT T1.Result FROM acceptance AS T1 JOIN submission AS T2 ON T1.Submission_ID = T2.Submission_ID ORDER BY T2.Scores DESC, T1.submission_id NULLS LAST, T1.workshop_id NULLS LAST, T2.submission_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/