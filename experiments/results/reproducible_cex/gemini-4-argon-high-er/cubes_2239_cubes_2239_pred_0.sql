-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (1, 'Bob', 'NY', 'Democrat', '1900-1980');
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (2, 'Alice', 'CA', 'Democrat', '1910-1990');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "representative" WHERE ("party" <> 'Republican') ORDER BY name, representative.representative_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Bob',)
*/

-- Prediction Query
SELECT Name FROM Representative WHERE Party <> 'Republican';

/*
Prediction Result:
('Bob',)
('Alice',)
*/