-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO representative (Representative_ID, Name, State, Party, Lifespan) VALUES (1, 'Alice', 'NY', 'Dem', '1950-');
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (1, 1, '2020', 100.0, 50.0, 1.0, 1.0);
INSERT INTO election (Election_ID, Representative_ID, Date, Votes, Vote_Percent, Seats, Place) VALUES (2, 1, '2022', 200.0, 60.0, 1.0, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM representative AS LHS WHERE EXISTS(SELECT 1 FROM election AS RHS WHERE (LHS.representative_id = RHS.representative_id))) ORDER BY name;

/*
Gold Result:
('Alice',)
*/

-- Prediction Query
SELECT T2.Name FROM election AS T1 JOIN representative AS T2 ON T1.Representative_ID = T2.Representative_ID ORDER BY votes DESC, T1.election_id NULLS LAST, T2.representative_id NULLS LAST;

/*
Prediction Result:
('Alice',)
('Alice',)
*/