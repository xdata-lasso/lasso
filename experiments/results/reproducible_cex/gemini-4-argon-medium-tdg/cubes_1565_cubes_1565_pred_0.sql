-- Schema DDL
CREATE TABLE "candidate" ("Candidate_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Poll_Source" TEXT, "Date" TEXT, "Support_rate" REAL, "Consider_rate" REAL, "Oppose_rate" REAL, "Unsure_rate" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Sex" TEXT, "Name" TEXT, "Date_of_Birth" TEXT, "Height" REAL, "Weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- General comprehensive dataset where each column's maximum and minimum belongs to a distinct candidate, and Candidate_ID differs from People_ID.
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (101, 'F', 'Alice', '1980-01-01', 165.0, 60.0);
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (102, 'M', 'Bob', '1975-05-12', 180.0, 80.0);
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (103, 'F', 'Charlie', '1990-11-23', 170.0, 65.0);
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (104, 'M', 'David', '1985-07-19', 175.0, 75.0);
INSERT INTO candidate (Candidate_ID, People_ID, Poll_Source, Date, Support_rate, Consider_rate, Oppose_rate, Unsure_rate) VALUES (1, 104, 'SourceA', '2023-01-01', 0.90, 0.20, 0.20, 0.30);
INSERT INTO candidate (Candidate_ID, People_ID, Poll_Source, Date, Support_rate, Consider_rate, Oppose_rate, Unsure_rate) VALUES (2, 103, 'SourceB', '2023-01-02', 0.20, 0.90, 0.20, 0.40);
INSERT INTO candidate (Candidate_ID, People_ID, Poll_Source, Date, Support_rate, Consider_rate, Oppose_rate, Unsure_rate) VALUES (3, 102, 'SourceC', '2023-01-03', 0.20, 0.20, 0.90, 0.85);
INSERT INTO candidate (Candidate_ID, People_ID, Poll_Source, Date, Support_rate, Consider_rate, Oppose_rate, Unsure_rate) VALUES (4, 101, 'SourceD', '2023-01-04', 0.10, 0.10, 0.10, 0.10);
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
(4,)
*/