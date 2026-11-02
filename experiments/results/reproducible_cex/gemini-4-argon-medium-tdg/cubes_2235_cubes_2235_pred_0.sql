-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary conditions for count (n = 1, 2, 3, 4), ORDER BY party, and DISTINCT party elimination.
-- Also includes a Representative without an Election to kill mutants that unnecessarily INNER JOIN the election table.
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (1, 'Alice', 'NY', 'Whig', '1900-1980');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (2, 'Bob', 'CA', 'Federalist', '1910-1990');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (3, 'Bob', 'CA', 'Federalist', '1910-1990');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (4, 'Charlie', 'TX', 'Democratic', '1920-2000');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (5, 'Charlie', 'TX', 'Democratic', '1920-2000');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (6, 'Charlie', 'TX', 'Democratic', '1920-2000');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (7, 'David', 'FL', 'Republican', '1930-2010');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (8, 'David', 'FL', 'Republican', '1930-2010');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (9, 'David', 'FL', 'Republican', '1930-2010');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (10, 'David', 'FL', 'Republican', '1930-2010');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (11, 'Eve', 'OH', 'Whig', '1940-2020');
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (101, 2, '1950', 1000.0, 50.0, 1.0, 1.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (102, 4, '1960', 2000.0, 60.0, 1.0, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT party FROM (SELECT name, party, COUNT(*) AS n FROM representative GROUP BY name, party) WHERE (n < 3) ORDER BY party;

/*
Gold Result:
('Federalist',)
('Whig',)
*/

-- Prediction Query
SELECT Party FROM representative GROUP BY Party HAVING COUNT(*) >= 3;

/*
Prediction Result:
('Democratic',)
('Republican',)
*/