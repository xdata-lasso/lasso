-- Schema DDL
CREATE TABLE "candidate" ("Candidate_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Poll_Source" TEXT, "Date" TEXT, "Support_rate" REAL, "Consider_rate" REAL, "Oppose_rate" REAL, "Unsure_rate" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Sex" TEXT, "Name" TEXT, "Date_of_Birth" TEXT, "Height" REAL, "Weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (1, 'M', 'John', '1990-01-01', 180.0, 75.0);
INSERT INTO candidate (Candidate_ID, People_ID, Poll_Source, Date, Support_rate, Consider_rate, Oppose_rate, Unsure_rate) VALUES (1, 1, 'Source A', '2020-01-01', 10.0, 20.0, 30.0, 50.0);
INSERT INTO candidate (Candidate_ID, People_ID, Poll_Source, Date, Support_rate, Consider_rate, Oppose_rate, Unsure_rate) VALUES (2, 1, 'Source B', '2020-01-02', 50.0, 20.0, 20.0, 10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT support_rate, consider_rate, oppose_rate FROM candidate ORDER BY support_rate, candidate.candidate_id NULLS LAST;

/*
Gold Result:
(10.0, 20.0, 30.0)
(50.0, 20.0, 20.0)
*/

-- Prediction Query
SELECT Support_rate, Consider_rate, Oppose_rate FROM candidate ORDER BY unsure_rate, candidate.candidate_id NULLS LAST;

/*
Prediction Result:
(50.0, 20.0, 20.0)
(10.0, 20.0, 30.0)
*/