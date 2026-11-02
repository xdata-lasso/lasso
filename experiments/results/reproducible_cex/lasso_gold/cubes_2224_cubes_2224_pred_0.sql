-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (1004, 'Daniel Wagner', 'Alaska', 'option', 'decide');
INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (1005, 'Abigail Shaffer', 'New Hampshire', 'perform', 'fall');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, party FROM representative ORDER BY name, representative.representative_id NULLS LAST;

/*
Gold Result:
('Abigail Shaffer', 'perform')
('Daniel Wagner', 'option')
*/

-- Prediction Query
SELECT Name, Party FROM representative;

/*
Prediction Result:
('Daniel Wagner', 'option')
('Abigail Shaffer', 'perform')
*/