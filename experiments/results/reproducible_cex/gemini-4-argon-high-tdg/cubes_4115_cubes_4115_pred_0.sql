-- Schema DDL
CREATE TABLE "candidate" ("Candidate_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Poll_Source" TEXT, "Date" TEXT, "Support_rate" REAL, "Consider_rate" REAL, "Oppose_rate" REAL, "Unsure_rate" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Sex" TEXT, "Name" TEXT, "Date_of_Birth" TEXT, "Height" REAL, "Weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (1, 'F', 'Zoe Washburn', '1985-04-12', 170.0, 60.0);
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (2, 'F', 'Alice Morgan', '1978-09-01', 165.0, 55.0);
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (3, 'M', 'Bob Vance', '1969-12-19', 180.0, 88.0);
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (4, 'M', 'Aaron Burr', '1975-02-06', 172.0, 70.0);
INSERT INTO candidate (Candidate_ID, People_ID, Poll_Source, Date, Support_rate, Consider_rate, Oppose_rate, Unsure_rate) VALUES (1, 1, 'Source A', '2023-05-01', 0.85, 0.05, 0.05, 0.05);
INSERT INTO candidate (Candidate_ID, People_ID, Poll_Source, Date, Support_rate, Consider_rate, Oppose_rate, Unsure_rate) VALUES (2, 2, 'Source B', '2023-05-02', 0.85, 0.10, 0.03, 0.02);
INSERT INTO candidate (Candidate_ID, People_ID, Poll_Source, Date, Support_rate, Consider_rate, Oppose_rate, Unsure_rate) VALUES (3, 3, 'Source C', '2023-05-03', 0.85, 0.08, 0.04, 0.03);
INSERT INTO candidate (Candidate_ID, People_ID, Poll_Source, Date, Support_rate, Consider_rate, Oppose_rate, Unsure_rate) VALUES (4, 4, 'Source D', '2023-05-04', 0.40, 0.30, 0.20, 0.10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, sex FROM (SELECT LHS.candidate_id AS candidate_id, LHS.people_id AS people_id, LHS.poll_source AS poll_source, LHS.date AS date, LHS.support_rate AS support_rate, LHS.consider_rate AS consider_rate, LHS.oppose_rate AS oppose_rate, LHS.unsure_rate AS unsure_rate, LHS.sex AS sex, LHS.name AS name, LHS.date_of_birth AS date_of_birth, LHS.height AS height, LHS.weight AS weight FROM (SELECT LHS.candidate_id AS candidate_id, LHS.people_id AS people_id, LHS.poll_source AS poll_source, LHS.date AS date, LHS.support_rate AS support_rate, LHS.consider_rate AS consider_rate, LHS.oppose_rate AS oppose_rate, LHS.unsure_rate AS unsure_rate, RHS.sex AS sex, RHS.name AS name, RHS.date_of_birth AS date_of_birth, RHS.height AS height, RHS.weight AS weight FROM candidate AS LHS INNER JOIN people AS RHS ON (LHS.people_id = RHS.people_id)) AS LHS INNER JOIN (SELECT MAX(support_rate) AS support_rate FROM candidate) AS RHS ON (LHS.support_rate = RHS.support_rate)) ORDER BY name, sex NULLS LAST;

/*
Gold Result:
('Alice Morgan', 'F')
('Bob Vance', 'M')
('Zoe Washburn', 'F')
*/

-- Prediction Query
SELECT t1.name, t1.sex FROM people AS t1 JOIN candidate AS t2 ON t1.people_id = t2.people_id ORDER BY t2.support_rate DESC, t1.people_id NULLS LAST, t2.candidate_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Zoe Washburn', 'F')
*/