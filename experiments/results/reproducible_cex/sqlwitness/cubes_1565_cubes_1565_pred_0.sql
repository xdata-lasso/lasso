-- Schema DDL
CREATE TABLE "candidate" ("Candidate_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Poll_Source" TEXT, "Date" TEXT, "Support_rate" REAL, "Consider_rate" REAL, "Oppose_rate" REAL, "Unsure_rate" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Sex" TEXT, "Name" TEXT, "Date_of_Birth" TEXT, "Height" REAL, "Weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, sex, name, date_of_birth, height, weight) VALUES (2, 'default2', NULL, NULL, 0.0, NULL);
INSERT INTO candidate (candidate_id, people_id, poll_source, date, support_rate, consider_rate, oppose_rate, unsure_rate) VALUES (0, NULL, NULL, NULL, 1.0, NULL, 1.0, 0.0), (2, NULL, 'default1', NULL, NULL, 2.0, 2.0, 2.0), (1, 2, NULL, NULL, 2.0, NULL, NULL, 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT candidate_id FROM (SELECT * FROM (SELECT * FROM candidate ORDER BY unsure_rate DESC, candidate.candidate_id NULLS LAST) LIMIT 1);

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT Candidate_ID FROM candidate ORDER BY oppose_rate, candidate.candidate_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1,)
*/