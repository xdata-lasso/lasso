-- Schema DDL
CREATE TABLE "candidate" ("Candidate_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Poll_Source" TEXT, "Date" TEXT, "Support_rate" REAL, "Consider_rate" REAL, "Oppose_rate" REAL, "Unsure_rate" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Sex" TEXT, "Name" TEXT, "Date_of_Birth" TEXT, "Height" REAL, "Weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (1, 'M', 'Zoe', '1980-01-01', 160.0, 90.0);
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (2, 'F', 'Alice', '2000-12-31', 175.5, 65.0);
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (3, 'M', 'Bob', '1990-06-15', 185.0, 55.0);
INSERT INTO candidate (Candidate_ID, People_ID, Poll_Source, Date, Support_rate, Consider_rate, Oppose_rate, Unsure_rate) VALUES (10, 1, 'Poll A', '2020-01-01', 0.45, 0.25, 0.20, 0.10);
INSERT INTO candidate (Candidate_ID, People_ID, Poll_Source, Date, Support_rate, Consider_rate, Oppose_rate, Unsure_rate) VALUES (11, 1, 'Poll B', '2020-02-01', 0.50, 0.20, 0.20, 0.10);
INSERT INTO candidate (Candidate_ID, People_ID, Poll_Source, Date, Support_rate, Consider_rate, Oppose_rate, Unsure_rate) VALUES (12, 3, 'Poll A', '2020-01-01', 0.30, 0.30, 0.30, 0.10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM people ORDER BY name, people.people_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Bob',)
('Zoe',)
*/

-- Prediction Query
SELECT name FROM people ORDER BY date_of_birth, people.people_id NULLS LAST;

/*
Prediction Result:
('Zoe',)
('Bob',)
('Alice',)
*/