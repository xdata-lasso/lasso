-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic EXISTS (semi-join) behavior vs INNER JOIN (multiplicity) and LEFT JOIN (unmatched rows), plus ORDER BY Name vs ORDER BY Representative_ID.
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (1, 'Zack', 'NY', 'Dem', '1950-');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (2, 'Alice', 'CA', 'Rep', '1960-');
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (3, 'Bob', 'TX', 'Ind', '1970-');
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (101, 1, '2020-11-03', 1000.0, 50.0, 1.0, 1.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (102, 1, '2022-11-08', 1200.0, 55.0, 1.0, 1.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (103, 2, '2020-11-03', 800.0, 45.0, 0.0, 2.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM representative AS LHS WHERE EXISTS(SELECT 1 FROM election AS RHS WHERE (LHS.representative_id = RHS.representative_id))) ORDER BY name;

/*
Gold Result:
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT T2.Name FROM election AS T1 JOIN representative AS T2 ON T1.Representative_ID = T2.Representative_ID ORDER BY votes DESC, T1.election_id NULLS LAST, T2.representative_id NULLS LAST;

/*
Prediction Result:
('Zack',)
('Zack',)
('Alice',)
*/