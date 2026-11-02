-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary conditions for n < 3 (n = 1, 2, 3, 4), ORDER BY party, and DISTINCT party.
-- Also tests mutants that drop 'name' from GROUP BY (since Party B has 3 total rows, but split across two names: 2 and 1).
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (1, 'Alice', 'NY', 'Party Z', '1900-1980');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (2, 'Bob', 'CA', 'Party B', '1910-1990');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (3, 'Bob', 'TX', 'Party B', '1910-1990');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (4, 'Charlie', 'FL', 'Party B', '1920-2000');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (5, 'David', 'OH', 'Party A', '1930-2010');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (6, 'David', 'PA', 'Party A', '1930-2010');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (7, 'David', 'IL', 'Party A', '1930-2010');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (8, 'Eve', 'WA', 'Party C', '1940-2020');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (9, 'Eve', 'OR', 'Party C', '1940-2020');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (10, 'Eve', 'NV', 'Party C', '1940-2020');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (11, 'Eve', 'ID', 'Party C', '1940-2020');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT party FROM (SELECT name, party, COUNT(*) AS n FROM representative GROUP BY name, party) WHERE (n < 3) ORDER BY party;

/*
Gold Result:
('Party B',)
('Party Z',)
*/

-- Prediction Query
SELECT Party FROM representative GROUP BY Party HAVING COUNT(*) >= 3;

/*
Prediction Result:
('Party A',)
('Party B',)
('Party C',)
*/