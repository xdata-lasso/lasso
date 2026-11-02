-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (1, 'Alice Smith', 'Pennsylvania', 'Republican', '1950-2020');
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (2, 'Bob Jones', 'Pennsylvania', 'Democratic', '1960-');
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (3, 'Charlie Brown', 'Pennsylvania', 'Democratic', '1955-2010');
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (4, 'Diana Prince', 'Pennsylvania', NULL, '1970-');
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (5, 'Evan Wright', 'New York', 'Green', '1980-');
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (6, 'Fiona Gallagher', 'Ohio', 'Libertarian', '1985-');
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (7, 'George Clark', NULL, 'Independent', '1940-2000');
INSERT INTO "election" ("Election_ID", "Representative_ID", "Date", "Votes", "Vote_Percent", "Seats", "Place") VALUES (101, 1, '2020-11-03', 50000.0, 55.5, 1.0, 1.0);
INSERT INTO "election" ("Election_ID", "Representative_ID", "Date", "Votes", "Vote_Percent", "Seats", "Place") VALUES (102, 1, '2022-11-08', 52000.0, 56.0, 1.0, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "party" FROM "representative" WHERE ("state" <> 'New York' AND "state" = 'Pennsylvania') ORDER BY party, "party" NULLS LAST;

/*
Gold Result:
(None,)
('Democratic',)
('Republican',)
*/

-- Prediction Query
SELECT Party FROM representative WHERE State = 'New York' INTERSECT SELECT Party FROM representative WHERE State = 'Pennsylvania';

/*
Prediction Result:
*/