-- Schema DDL
CREATE TABLE "candidate" ("Candidate_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Poll_Source" TEXT, "Date" TEXT, "Support_rate" REAL, "Consider_rate" REAL, "Oppose_rate" REAL, "Unsure_rate" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Sex" TEXT, "Name" TEXT, "Date_of_Birth" TEXT, "Height" REAL, "Weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO candidate (candidate_id, people_id, poll_source, date, support_rate, consider_rate, oppose_rate, unsure_rate) VALUES (0, NULL, 'default2', 'default1', 0.0, 1.0, 1.0, 1.0), (1, NULL, 'default1', 'default1', 0.0, 1.0, 0.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT support_rate, consider_rate, oppose_rate FROM candidate ORDER BY support_rate, candidate.candidate_id NULLS LAST;

/*
Gold Result:
(0.0, 1.0, 1.0)
(0.0, 1.0, 0.0)
*/

-- Prediction Query
SELECT Support_rate, Consider_rate, Oppose_rate FROM candidate ORDER BY unsure_rate, candidate.candidate_id NULLS LAST;

/*
Prediction Result:
(0.0, 1.0, 0.0)
(0.0, 1.0, 1.0)
*/