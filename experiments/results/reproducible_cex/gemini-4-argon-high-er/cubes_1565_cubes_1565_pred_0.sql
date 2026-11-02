-- Schema DDL
CREATE TABLE "candidate" ("Candidate_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Poll_Source" TEXT, "Date" TEXT, "Support_rate" REAL, "Consider_rate" REAL, "Oppose_rate" REAL, "Unsure_rate" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Sex" TEXT, "Name" TEXT, "Date_of_Birth" TEXT, "Height" REAL, "Weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (1, 'M', 'John Doe', '1980-01-01', 180.0, 75.0);
INSERT INTO candidate (Candidate_ID, People_ID, Poll_Source, Date, Support_rate, Consider_rate, Oppose_rate, Unsure_rate) VALUES (1, 1, 'Source A', '2023-01-01', 0.2, 0.2, 0.5, 0.5);
INSERT INTO candidate (Candidate_ID, People_ID, Poll_Source, Date, Support_rate, Consider_rate, Oppose_rate, Unsure_rate) VALUES (2, 1, 'Source B', '2023-01-02', 0.2, 0.2, 0.1, 0.1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT candidate_id FROM (SELECT * FROM (SELECT * FROM candidate ORDER BY unsure_rate DESC, candidate.candidate_id NULLS LAST) LIMIT 1);

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT Candidate_ID FROM candidate ORDER BY oppose_rate, candidate.candidate_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(2,)
*/