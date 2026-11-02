-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO representative (representative_id, name, state, party, lifespan) VALUES (1, 'default1', 'default2', 'default2', 'default2'), (0, 'Pennsylvania', 'default1', 'default1', 'default2'), (2, 'default2', 'Pennsylvania', 'default2', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "party" FROM "representative" WHERE ("state" <> 'New York' AND "state" = 'Pennsylvania') ORDER BY party, "party" NULLS LAST;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT Party FROM representative WHERE State = 'New York' INTERSECT SELECT Party FROM representative WHERE State = 'Pennsylvania';

/*
Prediction Result:
*/