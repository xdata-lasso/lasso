-- Schema DDL
CREATE TABLE "candidate" ("Candidate_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Poll_Source" TEXT, "Date" TEXT, "Support_rate" REAL, "Consider_rate" REAL, "Oppose_rate" REAL, "Unsure_rate" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Sex" TEXT, "Name" TEXT, "Date_of_Birth" TEXT, "Height" REAL, "Weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (1, 'M', 'John Doe', '1980-01-01', 180.0, 75.0);
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (2, 'F', 'Jane Smith', '1985-05-12', 165.0, 60.0);
INSERT INTO candidate (Candidate_ID, People_ID, Poll_Source, Date, Support_rate, Consider_rate, Oppose_rate, Unsure_rate) VALUES (1, 1, 'Source_Alpha', '2023-01-01', 0.45, 0.20, 0.30, 0.05);
INSERT INTO candidate (Candidate_ID, People_ID, Poll_Source, Date, Support_rate, Consider_rate, Oppose_rate, Unsure_rate) VALUES (2, 1, 'Source_Beta', '2023-01-02', 0.55, 0.15, 0.25, 0.05);
INSERT INTO candidate (Candidate_ID, People_ID, Poll_Source, Date, Support_rate, Consider_rate, Oppose_rate, Unsure_rate) VALUES (3, 2, 'Source_Gamma', '2023-01-03', 0.45, 0.25, 0.20, 0.10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT poll_source FROM (SELECT LHS.candidate_id AS candidate_id, LHS.people_id AS people_id, LHS.poll_source AS poll_source, LHS.date AS date, LHS.support_rate AS support_rate, LHS.consider_rate AS consider_rate, LHS.oppose_rate AS oppose_rate, LHS.unsure_rate AS unsure_rate, RHS.candidate_id AS candidate_id_other, RHS.people_id AS people_id_other, RHS.poll_source AS poll_source_other, RHS.date AS date_other, RHS.consider_rate AS consider_rate_other, RHS.oppose_rate AS oppose_rate_other, RHS.unsure_rate AS unsure_rate_other FROM candidate AS LHS INNER JOIN (SELECT candidate_id, people_id, poll_source, date, support_rate, consider_rate, oppose_rate, unsure_rate, COUNT(*) OVER () AS n FROM candidate) AS RHS ON (LHS.candidate_id = RHS.n AND LHS.support_rate = RHS.support_rate)) ORDER BY poll_source;

/*
Gold Result:
('Source_Gamma',)
*/

-- Prediction Query
SELECT poll_source FROM candidate GROUP BY poll_source ORDER BY COUNT(*) DESC, poll_source NULLS LAST LIMIT 1;

/*
Prediction Result:
('Source_Alpha',)
*/