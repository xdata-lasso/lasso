-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (10, 'John Doe', 'New York', 'Democratic', '1950-2020');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (20, 'Jane Smith', 'Pennsylvania', 'Republican', '1965-present');
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (3, 10, '1942', 1500.5, 48.2, 1.0, 2.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (1, 20, '1942', 1500.5, 48.2, 1.0, 2.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (2, 10, '1942', 2000.0, 51.8, 2.0, 1.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (4, 20, '1938', 950.0, 60.5, 3.0, 4.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (5, 10, '1946', 800.0, 19.2, 4.0, 5.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, vote_percent FROM election ORDER BY date, election.election_id NULLS LAST;

/*
Gold Result:
('1938', 60.5)
('1942', 48.2)
('1942', 51.8)
('1942', 48.2)
('1946', 19.2)
*/

-- Prediction Query
SELECT Date, Vote_Percent FROM election;

/*
Prediction Result:
('1942', 48.2)
('1942', 51.8)
('1942', 48.2)
('1938', 60.5)
('1946', 19.2)
*/