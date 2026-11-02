-- Schema DDL
CREATE TABLE "candidate" ("Candidate_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Poll_Source" TEXT, "Date" TEXT, "Support_rate" REAL, "Consider_rate" REAL, "Oppose_rate" REAL, "Unsure_rate" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Sex" TEXT, "Name" TEXT, "Date_of_Birth" TEXT, "Height" REAL, "Weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (1, 'F', 'Alice Smith', '1980-05-12', 165.0, 60.0);
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (2, 'M', 'Bob Jones', '1975-08-23', 180.0, 82.0);
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (3, 'F', 'Carol White', '1988-11-04', 170.0, 65.0);
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (4, 'M', 'David Brown', '1990-02-19', 175.0, 77.0);
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (5, 'F', 'Eve Davis', '1983-07-30', 162.0, 58.0);
INSERT INTO candidate (Candidate_ID, People_ID, Poll_Source, Date, Support_rate, Consider_rate, Oppose_rate, Unsure_rate) VALUES (1, 3, 'Gallup', '2024-01-10', 0.40, 0.30, 0.20, 0.10);
INSERT INTO candidate (Candidate_ID, People_ID, Poll_Source, Date, Support_rate, Consider_rate, Oppose_rate, Unsure_rate) VALUES (3, 1, 'Pew', '2024-01-15', 0.40, 0.25, 0.25, 0.10);
INSERT INTO candidate (Candidate_ID, People_ID, Poll_Source, Date, Support_rate, Consider_rate, Oppose_rate, Unsure_rate) VALUES (5, 5, 'YouGov', '2024-01-20', 0.60, 0.20, 0.15, 0.05);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT poll_source FROM (SELECT LHS.candidate_id AS candidate_id, LHS.people_id AS people_id, LHS.poll_source AS poll_source, LHS.date AS date, LHS.support_rate AS support_rate, LHS.consider_rate AS consider_rate, LHS.oppose_rate AS oppose_rate, LHS.unsure_rate AS unsure_rate, RHS.candidate_id AS candidate_id_other, RHS.people_id AS people_id_other, RHS.poll_source AS poll_source_other, RHS.date AS date_other, RHS.consider_rate AS consider_rate_other, RHS.oppose_rate AS oppose_rate_other, RHS.unsure_rate AS unsure_rate_other FROM candidate AS LHS INNER JOIN (SELECT candidate_id, people_id, poll_source, date, support_rate, consider_rate, oppose_rate, unsure_rate, COUNT(*) OVER () AS n FROM candidate) AS RHS ON (LHS.candidate_id = RHS.n AND LHS.support_rate = RHS.support_rate)) ORDER BY poll_source;

/*
Gold Result:
('Pew',)
*/

-- Prediction Query
SELECT poll_source FROM candidate GROUP BY poll_source ORDER BY COUNT(*) DESC, poll_source NULLS LAST LIMIT 1;

/*
Prediction Result:
('Gallup',)
*/