-- Schema DDL
CREATE TABLE "candidate" ("Candidate_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Poll_Source" TEXT, "Date" TEXT, "Support_rate" REAL, "Consider_rate" REAL, "Oppose_rate" REAL, "Unsure_rate" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Sex" TEXT, "Name" TEXT, "Date_of_Birth" TEXT, "Height" REAL, "Weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, sex, name, date_of_birth, height, weight) VALUES (2, NULL, NULL, NULL, NULL, 0.0), (0, 'default2', 'default1', 'default1', 0.0, 0.0);
INSERT INTO candidate (candidate_id, people_id, poll_source, date, support_rate, consider_rate, oppose_rate, unsure_rate) VALUES (1, NULL, 'default2', NULL, 1.0, 0.0, 2.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM people AS LHS WHERE NOT EXISTS(SELECT 1 FROM candidate AS RHS WHERE (LHS.people_id = RHS.people_id))) ORDER BY name;

/*
Gold Result:
(None,)
('default1',)
*/

-- Prediction Query
SELECT name FROM people WHERE NOT people_id IN (SELECT people_id FROM candidate);

/*
Prediction Result:
*/