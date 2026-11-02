-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (1, 'Alice Smith', 'Pennsylvania', 'Whig', '1800-1870');
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (2, 'Bob Jones', 'Pennsylvania', 'Republican', '1850-1920');
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (3, 'Charlie Brown', 'Pennsylvania', 'Democratic', '1820-1890');
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (4, 'David Wilson', 'Pennsylvania', 'Republican', '1860-1930');
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (5, 'Eve Adams', 'New York', 'Federalist', '1790-1860');
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (6, 'Frank Miller', 'Ohio', 'Green', '1900-1980');
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (7, 'Grace Lee', NULL, 'Independent', '1910-1990');
INSERT INTO "election" ("Election_ID", "Representative_ID", "Date", "Votes", "Vote_Percent", "Seats", "Place") VALUES (101, 1, '1840-11-01', 5000.0, 55.5, 1.0, 1.0);
INSERT INTO "election" ("Election_ID", "Representative_ID", "Date", "Votes", "Vote_Percent", "Seats", "Place") VALUES (102, 1, '1842-11-01', 4800.0, 52.0, 1.0, 1.0);
INSERT INTO "election" ("Election_ID", "Representative_ID", "Date", "Votes", "Vote_Percent", "Seats", "Place") VALUES (103, 2, '1888-11-01', 12000.0, 60.0, 1.0, 1.0);
INSERT INTO "election" ("Election_ID", "Representative_ID", "Date", "Votes", "Vote_Percent", "Seats", "Place") VALUES (104, 5, '1828-11-01', 3000.0, 45.0, 0.0, 2.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "party" FROM "representative" WHERE ("state" <> 'New York' AND "state" = 'Pennsylvania') ORDER BY party, "party" NULLS LAST;

/*
Gold Result:
('Democratic',)
('Republican',)
('Whig',)
*/

-- Prediction Query
SELECT Party FROM representative WHERE State = 'New York' INTERSECT SELECT Party FROM representative WHERE State = 'Pennsylvania';

/*
Prediction Result:
*/