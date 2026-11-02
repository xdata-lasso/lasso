-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (1014, 'Michael Miles', 'New York', 'none', 'election');
INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (1015, 'Andrea Reid', 'Indiana', 'shoulder', 'common');
INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (1016, 'Devin Schaefer', 'New York', 'special', 'arrive');
INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (1017, 'Colleen Nguyen', 'Indiana', 'stand', 'drop');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "lifespan" FROM "representative" WHERE ("state" = 'New York' OR "state" = 'Indiana') ORDER BY lifespan, representative.representative_id NULLS LAST;

/*
Gold Result:
('arrive',)
('common',)
('drop',)
('election',)
*/

-- Prediction Query
SELECT Lifespan FROM representative WHERE State = 'New York' OR State = 'Indiana';

/*
Prediction Result:
('election',)
('common',)
('arrive',)
('drop',)
*/