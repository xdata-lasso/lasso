-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (1, 'John Doe', 'New York', 'Democratic', 'B');
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (2, 'Jane Doe', 'Indiana', 'Republican', 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "lifespan" FROM "representative" WHERE ("state" = 'New York' OR "state" = 'Indiana') ORDER BY lifespan, representative.representative_id NULLS LAST;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT Lifespan FROM representative WHERE State = 'New York' OR State = 'Indiana';

/*
Prediction Result:
('B',)
('A',)
*/