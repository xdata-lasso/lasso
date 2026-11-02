-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (1014, 'Stacey Ward', 'Colorado', 'sea', 'available');
INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (1015, 'Jamie Chavez', 'Illinois', 'top', 'early');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM representative AS LHS WHERE NOT EXISTS(SELECT 1 FROM election AS RHS WHERE (LHS.representative_id = RHS.representative_id))) ORDER BY name;

/*
Gold Result:
('Jamie Chavez',)
('Stacey Ward',)
*/

-- Prediction Query
SELECT Name FROM representative WHERE NOT Representative_ID IN (SELECT Representative_ID FROM election);

/*
Prediction Result:
('Stacey Ward',)
('Jamie Chavez',)
*/