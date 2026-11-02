-- Schema DDL
CREATE TABLE "candidate" ("Candidate_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Poll_Source" TEXT, "Date" TEXT, "Support_rate" REAL, "Consider_rate" REAL, "Oppose_rate" REAL, "Unsure_rate" REAL, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Sex" TEXT, "Name" TEXT, "Date_of_Birth" TEXT, "Height" REAL, "Weight" REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (1, 'M', 'John Doe', '1970-01-15', 180.5, 78.2);
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (2, 'F', 'Jane Smith', '1982-05-20', 165.0, 60.0);
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (3, 'M', 'Robert Brown', '1965-11-03', 175.2, 85.0);
INSERT INTO people (People_ID, Sex, Name, Date_of_Birth, Height, Weight) VALUES (4, 'F', 'Emily Davis', '1978-08-12', 170.0, 64.5);
INSERT INTO candidate (Candidate_ID, People_ID, Poll_Source, Date, Support_rate, Consider_rate, Oppose_rate, Unsure_rate) VALUES (30, 1, 'Gallup', '2023-01-10', 45.5, 20.1, 25.4, 9.0);
INSERT INTO candidate (Candidate_ID, People_ID, Poll_Source, Date, Support_rate, Consider_rate, Oppose_rate, Unsure_rate) VALUES (10, 2, 'Pew', '2023-02-15', 25.0, 40.2, 30.8, 4.0);
INSERT INTO candidate (Candidate_ID, People_ID, Poll_Source, Date, Support_rate, Consider_rate, Oppose_rate, Unsure_rate) VALUES (20, 3, 'YouGov', '2023-03-20', 25.0, 15.5, 10.2, 49.3);
INSERT INTO candidate (Candidate_ID, People_ID, Poll_Source, Date, Support_rate, Consider_rate, Oppose_rate, Unsure_rate) VALUES (5, 4, 'Ipsos', '2023-04-05', 60.2, 12.3, 18.5, 9.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT support_rate, consider_rate, oppose_rate FROM candidate ORDER BY support_rate, candidate.candidate_id NULLS LAST;

/*
Gold Result:
(25.0, 40.2, 30.8)
(25.0, 15.5, 10.2)
(45.5, 20.1, 25.4)
(60.2, 12.3, 18.5)
*/

-- Prediction Query
SELECT Support_rate, Consider_rate, Oppose_rate FROM candidate ORDER BY unsure_rate, candidate.candidate_id NULLS LAST;

/*
Prediction Result:
(25.0, 40.2, 30.8)
(60.2, 12.3, 18.5)
(45.5, 20.1, 25.4)
(25.0, 15.5, 10.2)
*/