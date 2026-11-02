-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (101, 'John Doe', 'NY', 'Dem', '1950-2020');
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (1, 101, '2020-11', 5000.0, 55.5, 1.0, 2.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (2, 101, '2020-11', 3000.0, 33.3, 0.0, 3.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (3, 101, '2020-11', 4000.0, 44.4, 2.0, 1.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (4, 101, '2018-11', 6000.0, 60.0, 1.0, 1.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (5, 101, '2022-11', 2000.0, 20.0, 0.0, 2.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, vote_percent FROM election ORDER BY date, election.election_id NULLS LAST;

/*
Gold Result:
('2018-11', 60.0)
('2020-11', 55.5)
('2020-11', 33.3)
('2020-11', 44.4)
('2022-11', 20.0)
*/

-- Prediction Query
SELECT Date, Vote_Percent FROM election;

/*
Prediction Result:
('2020-11', 55.5)
('2020-11', 33.3)
('2020-11', 44.4)
('2018-11', 60.0)
('2022-11', 20.0)
*/