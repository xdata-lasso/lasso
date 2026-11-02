-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (1015, 'Jonathan Johnson', 'Illinois', 'sense', 'rate');
INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (1027, 'Gina Moore', 'Wisconsin', 'great', 'blue');
INSERT INTO "election" ("election_id", "representative_id", "date", "votes", "vote_percent", "seats", "place") VALUES (1016, 1015, 'science', 1017.5, 1018.5, 1019.5, 1020.5);
INSERT INTO "election" ("election_id", "representative_id", "date", "votes", "vote_percent", "seats", "place") VALUES (1022, 1015, 'collection', 1023.5, 1024.5, 1025.5, 1026.5);
INSERT INTO "election" ("election_id", "representative_id", "date", "votes", "vote_percent", "seats", "place") VALUES (1028, 1027, 'best', 1029.5, 1030.5, 1031.5, 1032.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT lifespan FROM (SELECT * FROM representative AS LHS WHERE EXISTS(SELECT 1 FROM election AS RHS WHERE (LHS.representative_id = RHS.representative_id))) ORDER BY lifespan;

/*
Gold Result:
('blue',)
('rate',)
*/

-- Prediction Query
SELECT T2.Lifespan FROM election AS T1 JOIN representative AS T2 ON T1.Representative_ID = T2.Representative_ID ORDER BY Vote_Percent DESC, T1.election_id NULLS LAST, T2.representative_id NULLS LAST;

/*
Prediction Result:
('blue',)
('rate',)
('rate',)
*/