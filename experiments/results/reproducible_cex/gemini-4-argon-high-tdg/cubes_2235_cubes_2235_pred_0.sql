-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (1, 'Alice Smith', 'NY', 'Liberty', '1950-2020');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (2, 'Bob Jones', 'CA', 'Progress', '1960-');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (3, 'Bob Jones', 'TX', 'Progress', '1965-');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (4, 'Charlie Brown', 'OH', 'Heritage', '1940-2010');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (5, 'Charlie Brown', 'PA', 'Heritage', '1945-2015');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (6, 'Charlie Brown', 'VA', 'Heritage', '1970-');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (7, 'David Clark', 'FL', 'Alliance', '1930-2000');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (8, 'David Clark', 'GA', 'Alliance', '1935-2005');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (9, 'David Clark', 'NC', 'Alliance', '1955-');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (10, 'David Clark', 'SC', 'Alliance', '1980-');
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (1, 1, '2000-11-07', 15000.0, 52.5, 1.0, 1.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (2, 2, '2002-11-05', 12000.0, 48.0, 1.0, 1.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (3, 4, '2004-11-02', 18000.0, 60.0, 1.0, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT party FROM (SELECT name, party, COUNT(*) AS n FROM representative GROUP BY name, party) WHERE (n < 3) ORDER BY party;

/*
Gold Result:
('Liberty',)
('Progress',)
*/

-- Prediction Query
SELECT Party FROM representative GROUP BY Party HAVING COUNT(*) >= 3;

/*
Prediction Result:
('Alliance',)
('Heritage',)
*/