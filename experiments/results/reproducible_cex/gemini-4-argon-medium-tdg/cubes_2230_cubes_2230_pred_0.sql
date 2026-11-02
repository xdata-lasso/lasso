-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (1, 'Alice Smith', 'California', 'Democrat', '1950-2020');
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (2, 'Bob Jones', 'Texas', 'Republican', '1965-present');
INSERT INTO "election" ("Election_ID", "Representative_ID", "Date", "Votes", "Vote_Percent", "Seats", "Place") VALUES (10, 1, '2020-11-03', 5000.5, 50.5, 1.0, 1.0);
INSERT INTO "election" ("Election_ID", "Representative_ID", "Date", "Votes", "Vote_Percent", "Seats", "Place") VALUES (2, 1, '2018-11-06', 100.0, 99.0, 2.0, 2.0);
INSERT INTO "election" ("Election_ID", "Representative_ID", "Date", "Votes", "Vote_Percent", "Seats", "Place") VALUES (5, 2, '2016-11-08', 100.0, 10.0, 3.0, 3.0);
INSERT INTO "election" ("Election_ID", "Representative_ID", "Date", "Votes", "Vote_Percent", "Seats", "Place") VALUES (20, NULL, '2014-11-04', 50.0, 5.0, 0.0, 4.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT votes FROM election ORDER BY votes, election.election_id NULLS LAST;

/*
Gold Result:
(50.0,)
(100.0,)
(100.0,)
(5000.5,)
*/

-- Prediction Query
SELECT Votes FROM election ORDER BY Votes DESC, election.election_id NULLS LAST;

/*
Prediction Result:
(5000.5,)
(100.0,)
(100.0,)
(50.0,)
*/