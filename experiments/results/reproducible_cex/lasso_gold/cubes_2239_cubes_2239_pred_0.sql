-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (1015, 'Frederick Tate', 'Ohio', 'shoulder', 'election');
INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (1016, 'Andrea Reid', 'South Dakota', 'rise', 'onto');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "representative" WHERE ("party" <> 'Republican') ORDER BY name, representative.representative_id NULLS LAST;

/*
Gold Result:
('Andrea Reid',)
('Frederick Tate',)
*/

-- Prediction Query
SELECT Name FROM Representative WHERE Party <> 'Republican';

/*
Prediction Result:
('Frederick Tate',)
('Andrea Reid',)
*/