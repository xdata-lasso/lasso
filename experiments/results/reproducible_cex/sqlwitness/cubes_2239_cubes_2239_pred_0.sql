-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO representative (representative_id, name, state, party, lifespan) VALUES (1, 'Republican', 'default1', 'Republican', 'default2'), (0, NULL, 'Republican', 'default1', NULL), (2, 'default2', 'Republican', 'default2', 'default1'), (3, 'default1', NULL, 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "representative" WHERE ("party" <> 'Republican') ORDER BY name, representative.representative_id NULLS LAST;

/*
Gold Result:
(None,)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT Name FROM Representative WHERE Party <> 'Republican';

/*
Prediction Result:
(None,)
('default2',)
('default1',)
*/