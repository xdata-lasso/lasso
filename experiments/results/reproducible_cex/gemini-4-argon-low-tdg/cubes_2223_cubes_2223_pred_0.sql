-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests boundary conditions for Votes (>= 10000.0, = 10000.0, < 10000.0, NULL) and representatives with no elections.
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (1, 'Charlie', 'NY', 'Dem', '1950-2020');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (2, 'Alice', 'CA', 'Rep', '1960-');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (3, 'Bob', 'TX', 'Ind', '1970-');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (4, 'David', 'FL', 'Dem', '1980-');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (5, 'Eve', 'WA', 'Rep', '1955-');
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (101, 1, '2020-11-03', 10000.0, 50.0, 1.0, 1.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (102, 2, '2020-11-03', 9999.9, 49.9, 0.0, 2.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (103, 3, '2020-11-03', 15000.5, 60.0, 1.0, 1.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (104, 4, '2020-11-03', NULL, 0.0, 0.0, 3.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM representative AS LHS WHERE EXISTS(SELECT 1 FROM (SELECT * FROM election WHERE (votes >= 10000.0)) AS RHS WHERE (LHS.representative_id = RHS.representative_id))) ORDER BY name;

/*
Gold Result:
('Bob',)
('Charlie',)
*/

-- Prediction Query
SELECT T2.Name FROM election AS T1 JOIN representative AS T2 ON T1.Representative_ID = T2.Representative_ID WHERE Votes > 10000;

/*
Prediction Result:
('Bob',)
*/