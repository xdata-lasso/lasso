-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (1014, 'Jonathan Johnson', 'Illinois', 'sense', 'rate');
INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (1020, 'Connie Lawrence', 'Alabama', 'song', 'sure');
INSERT INTO "election" ("election_id", "representative_id", "date", "votes", "vote_percent", "seats", "place") VALUES (1015, 1014, 'science', 1016.5, 1017.5, 1018.5, 1019.5);
INSERT INTO "election" ("election_id", "representative_id", "date", "votes", "vote_percent", "seats", "place") VALUES (1021, 1020, 'save', 1017.5, 1018.5, 1019.5, 1020.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, vote_percent FROM election ORDER BY date, election.election_id NULLS LAST;

/*
Gold Result:
('save', 1018.5)
('science', 1017.5)
*/

-- Prediction Query
SELECT Date, Vote_Percent FROM election;

/*
Prediction Result:
('science', 1017.5)
('save', 1018.5)
*/