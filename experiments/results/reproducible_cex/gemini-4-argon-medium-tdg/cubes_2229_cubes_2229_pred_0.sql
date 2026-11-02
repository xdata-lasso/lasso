-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (1, 'Zack', 'NY', 'Dem', '1950-');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (2, 'Alice', 'CA', 'Rep', '1960-');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (3, 'Bob', 'TX', 'Ind', '1970-');
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (101, 2, '2020-11-03', 5000.0, 55.5, 1.0, 1.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (102, 2, '2022-11-08', 6000.0, 60.0, 1.0, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM representative AS LHS WHERE NOT EXISTS(SELECT 1 FROM election AS RHS WHERE (LHS.representative_id = RHS.representative_id))) ORDER BY name;

/*
Gold Result:
('Bob',)
('Zack',)
*/

-- Prediction Query
SELECT Name FROM representative WHERE NOT Representative_ID IN (SELECT Representative_ID FROM election);

/*
Prediction Result:
('Zack',)
('Bob',)
*/