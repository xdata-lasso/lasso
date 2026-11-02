-- Schema DDL
CREATE TABLE "candidate" ("Candidate_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Poll_Source" TEXT, "Date" TEXT, "Support_rate" REAL, "Consider_rate" REAL, "Oppose_rate" REAL, "Unsure_rate" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Sex" TEXT, "Name" TEXT, "Date_of_Birth" TEXT, "Height" REAL, "Weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "people" ("People_ID", "Sex", "Name", "Date_of_Birth", "Height", "Weight") VALUES (1, 'F', 'Zack', '1980-01-01', 170.0, 65.0);
INSERT INTO "people" ("People_ID", "Sex", "Name", "Date_of_Birth", "Height", "Weight") VALUES (2, 'M', 'Alice', '1990-02-02', 180.0, 75.0);
INSERT INTO "people" ("People_ID", "Sex", "Name", "Date_of_Birth", "Height", "Weight") VALUES (3, 'M', 'Bob', '1985-03-03', 175.0, 70.0);
INSERT INTO "people" ("People_ID", "Sex", "Name", "Date_of_Birth", "Height", "Weight") VALUES (4, 'F', 'Alice', '1995-04-04', 165.0, 55.0);
INSERT INTO "candidate" ("Candidate_ID", "People_ID", "Poll_Source", "Date", "Support_rate", "Consider_rate", "Oppose_rate", "Unsure_rate") VALUES (10, 1, 'SourceA', '2023-01-01', 0.4, 0.2, 0.3, 0.1);
INSERT INTO "candidate" ("Candidate_ID", "People_ID", "Poll_Source", "Date", "Support_rate", "Consider_rate", "Oppose_rate", "Unsure_rate") VALUES (11, 1, 'SourceB', '2023-02-01', 0.5, 0.1, 0.3, 0.1);
INSERT INTO "candidate" ("Candidate_ID", "People_ID", "Poll_Source", "Date", "Support_rate", "Consider_rate", "Oppose_rate", "Unsure_rate") VALUES (12, 2, 'SourceA', '2023-01-01', 0.6, 0.2, 0.1, 0.1);
INSERT INTO "candidate" ("Candidate_ID", "People_ID", "Poll_Source", "Date", "Support_rate", "Consider_rate", "Oppose_rate", "Unsure_rate") VALUES (13, 4, 'SourceC', '2023-03-01', 0.3, 0.3, 0.3, 0.1);
INSERT INTO "candidate" ("Candidate_ID", "People_ID", "Poll_Source", "Date", "Support_rate", "Consider_rate", "Oppose_rate", "Unsure_rate") VALUES (14, NULL, 'SourceD', '2023-04-01', 0.2, 0.2, 0.5, 0.1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.people_id AS people_id, LHS.sex AS sex, LHS.name AS name, LHS.date_of_birth AS date_of_birth, LHS.height AS height, LHS.weight AS weight, RHS.candidate_id AS candidate_id, RHS.poll_source AS poll_source, RHS.date AS date, RHS.support_rate AS support_rate, RHS.consider_rate AS consider_rate, RHS.oppose_rate AS oppose_rate, RHS.unsure_rate AS unsure_rate FROM people AS LHS INNER JOIN candidate AS RHS ON (LHS.people_id = RHS.people_id)) ORDER BY name;

/*
Gold Result:
('Alice',)
('Alice',)
('Zack',)
('Zack',)
*/

-- Prediction Query
SELECT t1.name FROM people AS t1 JOIN candidate AS t2 ON t1.people_id = t2.people_id WHERE t2.support_rate < t2.oppose_rate;

/*
Prediction Result:
*/