-- Schema DDL
CREATE TABLE "candidate" ("Candidate_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Poll_Source" TEXT, "Date" TEXT, "Support_rate" REAL, "Consider_rate" REAL, "Oppose_rate" REAL, "Unsure_rate" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Sex" TEXT, "Name" TEXT, "Date_of_Birth" TEXT, "Height" REAL, "Weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (1, 'M', 'John Doe', '1970-05-14', 180.0, 78.5);
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (2, 'F', 'Jane Smith', '1975-08-22', 165.0, 62.0);
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (3, 'M', 'Robert Brown', '1968-11-03', 175.0, 82.0);
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (4, 'F', 'Emily Davis', '1982-02-19', 170.0, 65.0);
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (5, 'M', 'Michael Wilson', '1965-07-30', 182.0, 88.0);
INSERT INTO candidate (Candidate_ID, People_ID, Poll_Source, Date, Support_rate, Consider_rate, Oppose_rate, Unsure_rate) VALUES (1, 5, 'Gallup', '2020-01-01', 0.40, 0.20, 0.30, 0.10);
INSERT INTO candidate (Candidate_ID, People_ID, Poll_Source, Date, Support_rate, Consider_rate, Oppose_rate, Unsure_rate) VALUES (2, 1, 'Pew Research', '2020-01-02', 0.50, 0.10, 0.25, 0.15);
INSERT INTO candidate (Candidate_ID, People_ID, Poll_Source, Date, Support_rate, Consider_rate, Oppose_rate, Unsure_rate) VALUES (3, 5, 'Rasmussen', '2020-01-03', 0.35, 0.22, 0.32, 0.11);
INSERT INTO candidate (Candidate_ID, People_ID, Poll_Source, Date, Support_rate, Consider_rate, Oppose_rate, Unsure_rate) VALUES (4, 3, 'Ipsos', '2020-01-04', 0.45, 0.18, 0.15, 0.22);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT poll_source FROM (SELECT candidate_id, people_id, poll_source, date, support_rate, unsure_rate AS consider_rate, oppose_rate, unsure_rate, candidate_id_other, poll_source_other, date_other, support_rate_other, oppose_rate_other, unsure_rate_other FROM (SELECT candidate_id, candidate_id AS people_id, poll_source, date, support_rate, consider_rate, oppose_rate, unsure_rate, candidate_id_other, poll_source_other, date_other, support_rate_other, oppose_rate_other, unsure_rate_other FROM (SELECT LHS.candidate_id AS candidate_id, LHS.people_id AS people_id, LHS.poll_source AS poll_source, LHS.date AS date, LHS.support_rate AS support_rate, LHS.consider_rate AS consider_rate, LHS.oppose_rate AS oppose_rate, LHS.unsure_rate AS unsure_rate, RHS.candidate_id AS candidate_id_other, RHS.poll_source AS poll_source_other, RHS.date AS date_other, RHS.support_rate AS support_rate_other, RHS.oppose_rate AS oppose_rate_other, RHS.unsure_rate AS unsure_rate_other FROM candidate AS LHS INNER JOIN candidate AS RHS ON (LHS.candidate_id = RHS.people_id AND LHS.unsure_rate = RHS.consider_rate)))) ORDER BY poll_source;

/*
Gold Result:
('Gallup',)
*/

-- Prediction Query
SELECT poll_source FROM candidate ORDER BY oppose_rate DESC, candidate.candidate_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Rasmussen',)
*/