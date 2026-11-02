-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (1, 'John Smith', 'New York', 'Democratic', '1920-1995');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (2, 'Mary Johnson', 'Indiana', 'Republican', '1905-1980');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (3, 'Robert Williams', 'New York', 'Republican', '1905-1980');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (4, 'Patricia Brown', 'California', 'Democratic', '1910-1990');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (5, 'Michael Davis', 'Ohio', 'Independent', '1890-1960');
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (101, 2, '1950-11-07', 45000.0, 52.5, 1.0, 1.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (102, 2, '1952-11-04', 48000.0, 55.0, 1.0, 1.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (103, 3, '1948-11-02', 39000.0, 49.0, 1.0, 1.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (104, 4, '1960-11-08', 60000.0, 61.2, 1.0, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "lifespan" FROM "representative" WHERE ("state" = 'New York' OR "state" = 'Indiana') ORDER BY lifespan, representative.representative_id NULLS LAST;

/*
Gold Result:
('1905-1980',)
('1905-1980',)
('1920-1995',)
*/

-- Prediction Query
SELECT Lifespan FROM representative WHERE State = 'New York' OR State = 'Indiana';

/*
Prediction Result:
('1920-1995',)
('1905-1980',)
('1905-1980',)
*/