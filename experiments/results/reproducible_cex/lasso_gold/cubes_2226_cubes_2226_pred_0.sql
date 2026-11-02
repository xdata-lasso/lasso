-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (1034, 'James Howard', 'Minnesota', 'PM', 'everything');
INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (1046, 'Lisa Hensley', 'Oregon', 'dark', 'sea');
INSERT INTO "election" ("election_id", "representative_id", "date", "votes", "vote_percent", "seats", "place") VALUES (1035, 1034, 'surface', 1036.5, 1037.5, 1038.5, 1039.5);
INSERT INTO "election" ("election_id", "representative_id", "date", "votes", "vote_percent", "seats", "place") VALUES (1041, 1034, 'finally', 1042.5, 1043.5, 1044.5, 1045.5);
INSERT INTO "election" ("election_id", "representative_id", "date", "votes", "vote_percent", "seats", "place") VALUES (1047, 1046, 'available', 1048.5, 1049.5, 1050.5, 1051.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, date FROM (SELECT LHS.election_id AS election_id, LHS.representative_id AS representative_id, LHS.date AS date, LHS.votes AS votes, LHS.vote_percent AS vote_percent, LHS.seats AS seats, LHS.place AS place, RHS.name AS name, RHS.state AS state, RHS.party AS party, RHS.lifespan AS lifespan FROM election AS LHS INNER JOIN representative AS RHS ON (LHS.representative_id = RHS.representative_id)) ORDER BY name, date NULLS LAST;

/*
Gold Result:
('James Howard', 'finally')
('James Howard', 'surface')
('Lisa Hensley', 'available')
*/

-- Prediction Query
SELECT T2.Name, T1.Date FROM election AS T1 JOIN representative AS T2 ON T1.Representative_ID = T2.Representative_ID;

/*
Prediction Result:
('James Howard', 'surface')
('James Howard', 'finally')
('Lisa Hensley', 'available')
*/