-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: representative --
INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (2, '5k5swwqcgs', 'Pennsylvania', 'rep_af38e6', '9n8');

INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (3, '4', 'Pennsylvania', 'rep_af38e6', 'gu7v');

INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (4, 'e4', 'rep_16d61f', 'hria2ypuzhs', 'rwbbp6luhvd');

INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (5, '5k5swwqcgs', 'New York', '9n8', '4');

INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (6, '5k5swwqcgs', NULL, '9n8', '4');

INSERT INTO "representative" ("representative_id", "name", "state", "party", "lifespan") VALUES (7, 'gu7v', NULL, 'e4', 'hria2ypuzhs');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "party" FROM "representative" WHERE ("state" <> 'New York' AND "state" = 'Pennsylvania') ORDER BY party, "party" NULLS LAST;

/*
Gold Result:
('rep_af38e6',)
*/

-- Prediction Query
SELECT Party FROM representative WHERE State = 'New York' INTERSECT SELECT Party FROM representative WHERE State = 'Pennsylvania';

/*
Prediction Result:
*/