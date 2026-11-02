-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "election" ("Election_ID", "Votes") VALUES (1, 10.0);
INSERT INTO "election" ("Election_ID", "Votes") VALUES (2, 20.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT votes FROM election ORDER BY votes, election.election_id NULLS LAST;

/*
Gold Result:
(10.0,)
(20.0,)
*/

-- Prediction Query
SELECT Votes FROM election ORDER BY Votes DESC, election.election_id NULLS LAST;

/*
Prediction Result:
(20.0,)
(10.0,)
*/