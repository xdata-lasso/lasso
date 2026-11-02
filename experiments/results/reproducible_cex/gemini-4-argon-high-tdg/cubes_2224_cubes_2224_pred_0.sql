-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (10, 'Zelda Vance', 'NC', 'Democratic', '1830-1894');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (20, 'Adam Smith', 'NY', 'Federalist', '1790-1850');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (30, 'John Adams', 'MA', 'Whig', '1800-1860');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (40, 'John Adams', 'PA', 'Anti-Masonic', '1805-1870');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (50, 'Adam Smith', 'VA', 'Federalist', '1810-1880');
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (1, 20, '1820-11-01', 5000.0, 55.5, 1.0, 1.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (2, 20, '1822-11-01', 6200.0, 60.0, 1.0, 1.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (3, 30, '1832-11-01', 3100.0, 42.0, 0.0, 2.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, party FROM representative ORDER BY name, representative.representative_id NULLS LAST;

/*
Gold Result:
('Adam Smith', 'Federalist')
('Adam Smith', 'Federalist')
('John Adams', 'Whig')
('John Adams', 'Anti-Masonic')
('Zelda Vance', 'Democratic')
*/

-- Prediction Query
SELECT Name, Party FROM representative;

/*
Prediction Result:
('Zelda Vance', 'Democratic')
('Adam Smith', 'Federalist')
('John Adams', 'Whig')
('John Adams', 'Anti-Masonic')
('Adam Smith', 'Federalist')
*/