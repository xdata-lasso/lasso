-- Schema DDL
CREATE TABLE "candidate" ("Candidate_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Poll_Source" TEXT, "Date" TEXT, "Support_rate" REAL, "Consider_rate" REAL, "Oppose_rate" REAL, "Unsure_rate" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Sex" TEXT, "Name" TEXT, "Date_of_Birth" TEXT, "Height" REAL, "Weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (1, 'M', 'Charlie', '1985-03-15', 180.5, 75.0);
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (2, 'F', 'Alice', '1992-07-22', 165.0, 58.5);
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (3, 'M', 'Bob', '1978-11-05', 172.0, 82.0);
INSERT INTO candidate (Candidate_ID, People_ID, Poll_Source, Date, Support_rate, Consider_rate, Oppose_rate, Unsure_rate) VALUES (2, 1, 'Source A', '2024-01-10', 0.45, 0.25, 0.20, 0.10);
INSERT INTO candidate (Candidate_ID, People_ID, Poll_Source, Date, Support_rate, Consider_rate, Oppose_rate, Unsure_rate) VALUES (3, 2, 'Source B', '2024-01-12', 0.55, 0.20, 0.15, 0.10);
INSERT INTO candidate (Candidate_ID, People_ID, Poll_Source, Date, Support_rate, Consider_rate, Oppose_rate, Unsure_rate) VALUES (4, NULL, 'Source C', '2024-01-15', 0.30, 0.30, 0.30, 0.10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.people_id AS people_id, LHS.sex AS sex, LHS.name AS name, LHS.date_of_birth AS date_of_birth, LHS.height AS height, LHS.weight AS weight, RHS.candidate_id AS candidate_id, RHS.poll_source AS poll_source, RHS.date AS date, RHS.support_rate AS support_rate, RHS.consider_rate AS consider_rate, RHS.oppose_rate AS oppose_rate, RHS.unsure_rate AS unsure_rate FROM people AS LHS INNER JOIN candidate AS RHS ON (LHS.people_id = RHS.people_id)) ORDER BY name;

/*
Gold Result:
('Alice',)
('Charlie',)
*/

-- Prediction Query
SELECT t1.name FROM people AS t1 JOIN candidate AS t2 ON t1.people_id = t2.people_id WHERE t2.support_rate < t2.oppose_rate;

/*
Prediction Result:
*/