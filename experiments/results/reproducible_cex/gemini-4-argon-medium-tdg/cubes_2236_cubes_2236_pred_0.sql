-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic filtering (New York, Indiana, other states, NULL states), duplicate lifespans (to catch DISTINCT mutants), and NULL lifespans.
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (1, 'John Doe', 'New York', 'Democratic', '1920-2000');
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (2, 'Jane Smith', 'Indiana', 'Republican', '1910-1990');
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (3, 'Bob Johnson', 'Ohio', 'Democratic', '1900-1980');
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (4, 'Alice Williams', 'New York', 'Republican', '1910-1990');
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (5, 'Charlie Brown', NULL, 'Independent', '1930-2010');
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (6, 'David Miller', 'Indiana', 'Democratic', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "lifespan" FROM "representative" WHERE ("state" = 'New York' OR "state" = 'Indiana') ORDER BY lifespan, representative.representative_id NULLS LAST;

/*
Gold Result:
(None,)
('1910-1990',)
('1910-1990',)
('1920-2000',)
*/

-- Prediction Query
SELECT Lifespan FROM representative WHERE State = 'New York' OR State = 'Indiana';

/*
Prediction Result:
('1920-2000',)
('1910-1990',)
('1910-1990',)
(None,)
*/