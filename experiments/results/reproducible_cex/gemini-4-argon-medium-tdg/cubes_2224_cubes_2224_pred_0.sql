-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (10, 'Charlie', 'NY', 'Democratic', '1950-2020');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (20, 'Alice', 'CA', 'Republican', '1960-');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (5, 'Bob', 'TX', 'Independent', '1970-');
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (1, 10, '2000-11-07', 15000.0, 55.5, 1.0, 1.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (2, 10, '2002-11-05', 18000.0, 60.0, 1.0, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, party FROM representative ORDER BY name, representative.representative_id NULLS LAST;

/*
Gold Result:
('Alice', 'Republican')
('Bob', 'Independent')
('Charlie', 'Democratic')
*/

-- Prediction Query
SELECT Name, Party FROM representative;

/*
Prediction Result:
('Bob', 'Independent')
('Charlie', 'Democratic')
('Alice', 'Republican')
*/