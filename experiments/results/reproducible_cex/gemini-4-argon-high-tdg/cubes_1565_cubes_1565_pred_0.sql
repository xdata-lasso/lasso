-- Schema DDL
CREATE TABLE "candidate" ("Candidate_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Poll_Source" TEXT, "Date" TEXT, "Support_rate" REAL, "Consider_rate" REAL, "Oppose_rate" REAL, "Unsure_rate" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Sex" TEXT, "Name" TEXT, "Date_of_Birth" TEXT, "Height" REAL, "Weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (101, 'M', 'Alice Smith', '1980-05-12', 175.0, 70.0);
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (102, 'F', 'Bob Jones', '1975-11-23', 162.5, 58.0);
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (103, 'M', 'Charlie Brown', '1990-02-01', 180.0, 82.5);
INSERT INTO candidate (Candidate_ID, People_ID, Poll_Source, Date, Support_rate, Consider_rate, Oppose_rate, Unsure_rate) VALUES (1, 103, 'AAA Poll', '2020-01-01', 0.80, 0.10, 0.05, 0.05);
INSERT INTO candidate (Candidate_ID, People_ID, Poll_Source, Date, Support_rate, Consider_rate, Oppose_rate, Unsure_rate) VALUES (2, 101, 'MMM Poll', '2021-06-15', 0.15, 0.70, 0.10, 0.45);
INSERT INTO candidate (Candidate_ID, People_ID, Poll_Source, Date, Support_rate, Consider_rate, Oppose_rate, Unsure_rate) VALUES (3, 102, 'FFF Poll', '2022-03-10', 0.10, 0.10, 0.15, 0.65);
INSERT INTO candidate (Candidate_ID, People_ID, Poll_Source, Date, Support_rate, Consider_rate, Oppose_rate, Unsure_rate) VALUES (4, 101, 'ZZZ Poll', '2023-12-31', 0.02, 0.03, 0.90, 0.40);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT candidate_id FROM (SELECT * FROM (SELECT * FROM candidate ORDER BY unsure_rate DESC, candidate.candidate_id NULLS LAST) LIMIT 1);

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT Candidate_ID FROM candidate ORDER BY oppose_rate, candidate.candidate_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1,)
*/