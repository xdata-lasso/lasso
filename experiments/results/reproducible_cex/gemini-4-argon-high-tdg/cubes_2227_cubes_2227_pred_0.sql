-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (1, 'Alice Smith', 'NY', 'Democratic', '1900-1980');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (2, 'Bob Jones', 'CA', 'Republican', '1910-1990');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (3, 'Carol White', 'TX', 'Independent', '1920-2000');
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (1, 3, '1946', 300.0, 50.5, 3.0, 2.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (2, 1, '1946', 100.0, 20.0, 1.0, 3.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (3, 2, '1946', 200.0, 80.0, 2.0, 1.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (4, 1, '1942', 450.0, 65.2, 5.0, 1.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (5, 2, '1950', 150.0, 33.3, 4.0, 4.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, vote_percent FROM election ORDER BY date, election.election_id NULLS LAST;

/*
Gold Result:
('1942', 65.2)
('1946', 50.5)
('1946', 20.0)
('1946', 80.0)
('1950', 33.3)
*/

-- Prediction Query
SELECT Date, Vote_Percent FROM election;

/*
Prediction Result:
('1946', 50.5)
('1946', 20.0)
('1946', 80.0)
('1942', 65.2)
('1950', 33.3)
*/