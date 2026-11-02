-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (1014, 'Jonathan Johnson', 'Illinois', 'sense', 'rate');
INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (1020, 'Connie Lawrence', 'Alabama', 'song', 'sure');
INSERT INTO "election" ("election_id", "representative_id", "date", "votes", "vote_percent", "seats", "place") VALUES (1015, 1014, 'collection', 1017.5, 1017.5, 1018.5, 1019.5);
INSERT INTO "election" ("election_id", "representative_id", "date", "votes", "vote_percent", "seats", "place") VALUES (1021, 1020, 'science', 1016.5, 1018.5, 1019.5, 1020.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT votes FROM election ORDER BY votes, election.election_id NULLS LAST;

/*
Gold Result:
(1016.5,)
(1017.5,)
*/

-- Prediction Query
SELECT Votes FROM election ORDER BY Votes DESC, election.election_id NULLS LAST;

/*
Prediction Result:
(1017.5,)
(1016.5,)
*/