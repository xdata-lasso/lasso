-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (10, 'Alice', 'NY', 'Dem', '1950-2020');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (20, 'Bob', 'CA', 'Rep', '1940-2010');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (30, 'Charlie', 'TX', 'Ind', '1940-2010');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (40, 'David', 'FL', 'Dem', '1930-2000');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (50, 'Eve', 'WA', 'Rep', NULL);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (1, 10, '2000', 1000.0, 50.0, 1.0, 1.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (2, 10, '2004', 1200.0, 55.0, 1.0, 1.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (3, 20, '1998', 800.0, 45.0, 0.0, 2.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (4, 30, '1998', 900.0, 55.0, 1.0, 1.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (5, 50, '2002', 500.0, 30.0, 0.0, 3.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT lifespan FROM (SELECT * FROM representative AS LHS WHERE EXISTS(SELECT 1 FROM election AS RHS WHERE (LHS.representative_id = RHS.representative_id))) ORDER BY lifespan;

/*
Gold Result:
(None,)
('1940-2010',)
('1940-2010',)
('1950-2020',)
*/

-- Prediction Query
SELECT T2.Lifespan FROM election AS T1 JOIN representative AS T2 ON T1.Representative_ID = T2.Representative_ID ORDER BY Vote_Percent DESC, T1.election_id NULLS LAST, T2.representative_id NULLS LAST;

/*
Prediction Result:
('1950-2020',)
('1940-2010',)
('1950-2020',)
('1940-2010',)
(None,)
*/