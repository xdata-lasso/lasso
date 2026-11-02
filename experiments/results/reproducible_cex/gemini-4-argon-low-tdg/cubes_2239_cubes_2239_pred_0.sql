-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (1, 'Alice Smith', 'NY', 'Democrat', '1950-2020');
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (2, 'Bob Jones', 'TX', 'Republican', '1960-2021');
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (3, 'Alice Smith', 'CA', 'Independent', '1970-');
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (4, 'Charlie Brown', 'OH', 'Whig', '1800-1850');
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (5, NULL, 'FL', 'Democrat', '1980-');
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (6, 'Bob Jones', 'PA', NULL, '1955-');
INSERT INTO "election" ("Election_ID", "Representative_ID", "Date", "Votes", "Vote_Percent", "Seats", "Place") VALUES (101, 1, '2020-11-03', 50000.0, 55.5, 1.0, 1.0);
INSERT INTO "election" ("Election_ID", "Representative_ID", "Date", "Votes", "Vote_Percent", "Seats", "Place") VALUES (102, 1, '2018-11-06', 48000.0, 52.0, 1.0, 1.0);
INSERT INTO "election" ("Election_ID", "Representative_ID", "Date", "Votes", "Vote_Percent", "Seats", "Place") VALUES (103, 2, '2020-11-03', 60000.0, 60.0, 1.0, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "representative" WHERE ("party" <> 'Republican') ORDER BY name, representative.representative_id NULLS LAST;

/*
Gold Result:
(None,)
('Alice Smith',)
('Alice Smith',)
('Charlie Brown',)
*/

-- Prediction Query
SELECT Name FROM Representative WHERE Party <> 'Republican';

/*
Prediction Result:
('Alice Smith',)
('Alice Smith',)
('Charlie Brown',)
(None,)
*/