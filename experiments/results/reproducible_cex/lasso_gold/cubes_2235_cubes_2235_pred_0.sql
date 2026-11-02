-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (1001, 'Allison Hill', 'Iowa', 'blue', 'require');
INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (1002, 'Allison Hill', 'Florida', 'blue', 'sit');
INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (1003, 'Allison Hill', 'West Virginia', 'blue', 'wait');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT party FROM (SELECT name, party, COUNT(*) AS n FROM representative GROUP BY name, party) WHERE (n < 3) ORDER BY party;

/*
Gold Result:
*/

-- Prediction Query
SELECT Party FROM representative GROUP BY Party HAVING COUNT(*) >= 3;

/*
Prediction Result:
('blue',)
*/