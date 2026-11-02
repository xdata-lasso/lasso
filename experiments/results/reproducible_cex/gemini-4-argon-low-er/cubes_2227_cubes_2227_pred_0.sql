-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (1, 'Rep A', 'NY', 'Dem', '1950-');
INSERT INTO "election" ("Election_ID", "Representative_ID", "Date", "Votes", "Vote_Percent", "Seats", "Place") VALUES (1, 1, '2022', 100.0, 50.0, 1.0, 1.0);
INSERT INTO "election" ("Election_ID", "Representative_ID", "Date", "Votes", "Vote_Percent", "Seats", "Place") VALUES (2, 1, '2020', 200.0, 60.0, 1.0, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, vote_percent FROM election ORDER BY date, election.election_id NULLS LAST;

/*
Gold Result:
('2020', 60.0)
('2022', 50.0)
*/

-- Prediction Query
SELECT Date, Vote_Percent FROM election;

/*
Prediction Result:
('2022', 50.0)
('2020', 60.0)
*/