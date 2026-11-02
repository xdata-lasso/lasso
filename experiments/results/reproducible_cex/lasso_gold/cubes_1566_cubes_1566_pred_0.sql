-- Schema DDL
CREATE TABLE "candidate" ("Candidate_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Poll_Source" TEXT, "Date" TEXT, "Support_rate" REAL, "Consider_rate" REAL, "Oppose_rate" REAL, "Unsure_rate" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Sex" TEXT, "Name" TEXT, "Date_of_Birth" TEXT, "Height" REAL, "Weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "sex", "name", "date_of_birth", "height", "weight") VALUES (1092, 'prove', 'Nicholas Martin', 'hundred', 1093.5, 1094.5);
INSERT INTO "people" ("people_id", "sex", "name", "date_of_birth", "height", "weight") VALUES (1100, 'push', 'Andrew Stewart', 'special', 1094.5, 1095.5);
INSERT INTO "candidate" ("candidate_id", "people_id", "poll_source", "date", "support_rate", "consider_rate", "oppose_rate", "unsure_rate") VALUES (1095, 1092, 'expect', 'wish', 1096.5, 1097.5, 1098.5, 1099.5);
INSERT INTO "candidate" ("candidate_id", "people_id", "poll_source", "date", "support_rate", "consider_rate", "oppose_rate", "unsure_rate") VALUES (1103, 1100, 'stand', 'arrive', 1104.5, 1105.5, 1106.5, 1107.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.people_id AS people_id, LHS.sex AS sex, LHS.name AS name, LHS.date_of_birth AS date_of_birth, LHS.height AS height, LHS.weight AS weight, RHS.candidate_id AS candidate_id, RHS.poll_source AS poll_source, RHS.date AS date, RHS.support_rate AS support_rate, RHS.consider_rate AS consider_rate, RHS.oppose_rate AS oppose_rate, RHS.unsure_rate AS unsure_rate FROM people AS LHS INNER JOIN candidate AS RHS ON (LHS.people_id = RHS.people_id)) ORDER BY name;

/*
Gold Result:
('Andrew Stewart',)
('Nicholas Martin',)
*/

-- Prediction Query
SELECT t1.name FROM people AS t1 JOIN candidate AS t2 ON t1.people_id = t2.people_id WHERE t2.support_rate < t2.oppose_rate;

/*
Prediction Result:
('Nicholas Martin',)
('Andrew Stewart',)
*/