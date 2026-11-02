-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (1, 'Henry Clay', 'Kentucky', 'Whig', '1777-1852');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (2, 'Daniel Webster', 'Massachusetts', 'Whig', '1782-1852');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (3, 'Andrew Jackson', 'Tennessee', 'Democratic', '1767-1845');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (4, 'Abraham Lincoln', 'Illinois', 'Republican', '1809-1865');
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (10, 4, '1846-08-03', 6340.0, 55.5, 1.0, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT party FROM (SELECT * FROM representative AS LHS WHERE NOT EXISTS(SELECT 1 FROM election AS RHS WHERE (LHS.representative_id = RHS.representative_id))) ORDER BY party;

/*
Gold Result:
('Democratic',)
('Whig',)
*/

-- Prediction Query
SELECT T2.Party FROM election AS T1 JOIN representative AS T2 ON T1.Representative_ID = T2.Representative_ID ORDER BY votes ASC, T1.election_id NULLS LAST, T2.representative_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Republican',)
*/