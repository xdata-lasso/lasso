-- Schema DDL
CREATE TABLE "candidate" ("Candidate_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Poll_Source" TEXT, "Date" TEXT, "Support_rate" REAL, "Consider_rate" REAL, "Oppose_rate" REAL, "Unsure_rate" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Sex" TEXT, "Name" TEXT, "Date_of_Birth" TEXT, "Height" REAL, "Weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "sex", "name", "date_of_birth", "height", "weight") VALUES (1001, 'purpose', 'Patrick Sanchez', 'chair', 1002.5, 1003.5);
INSERT INTO "candidate" ("candidate_id", "people_id", "poll_source", "date", "support_rate", "consider_rate", "oppose_rate", "unsure_rate") VALUES (1, 1001, 'since', 'blue', 1004.5, 1005.5, 1006.5, 1007.5);
INSERT INTO "candidate" ("candidate_id", "people_id", "poll_source", "date", "support_rate", "consider_rate", "oppose_rate", "unsure_rate") VALUES (1008, 1001, 'require', 'sit', 1004.5, 1009.5, 1010.5, 1011.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT poll_source FROM (SELECT LHS.candidate_id AS candidate_id, LHS.people_id AS people_id, LHS.poll_source AS poll_source, LHS.date AS date, LHS.support_rate AS support_rate, LHS.consider_rate AS consider_rate, LHS.oppose_rate AS oppose_rate, LHS.unsure_rate AS unsure_rate, RHS.candidate_id AS candidate_id_other, RHS.people_id AS people_id_other, RHS.poll_source AS poll_source_other, RHS.date AS date_other, RHS.consider_rate AS consider_rate_other, RHS.oppose_rate AS oppose_rate_other, RHS.unsure_rate AS unsure_rate_other FROM candidate AS LHS INNER JOIN (SELECT candidate_id, people_id, poll_source, date, support_rate, consider_rate, oppose_rate, unsure_rate, COUNT(*) OVER () AS n FROM candidate) AS RHS ON (LHS.candidate_id = RHS.n AND LHS.support_rate = RHS.support_rate)) ORDER BY poll_source;

/*
Gold Result:
*/

-- Prediction Query
SELECT poll_source FROM candidate GROUP BY poll_source ORDER BY COUNT(*) DESC, poll_source NULLS LAST LIMIT 1;

/*
Prediction Result:
('require',)
*/