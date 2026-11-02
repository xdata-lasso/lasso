-- Schema DDL
CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "Representative_ID" INTEGER, "Date" TEXT, "Votes" REAL, "Vote_Percent" REAL, "Seats" REAL, "Place" REAL, FOREIGN KEY ("Representative_ID") REFERENCES "representative" ("Representative_ID"));

CREATE TABLE "representative" ("Representative_ID" INTEGER PRIMARY KEY, "Name" TEXT, "State" TEXT, "Party" TEXT, "Lifespan" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests DISTINCT, ORDER BY ASC/DESC, NULLS LAST, WHERE filtering (New York, Pennsylvania, others, NULLs), and INNER JOIN vs No-JOIN (no election rows for some representatives)
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (1, 'Alice Smith', 'Pennsylvania', 'Whig', '1800-1870');
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (2, 'Bob Jones', 'Pennsylvania', 'Democratic', '1810-1880');
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (3, 'Charlie Brown', 'Pennsylvania', 'Democratic', '1820-1890');
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (4, 'David Wilson', 'Pennsylvania', NULL, '1830-1900');
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (5, 'Eve Davis', 'New York', 'Federalist', '1790-1860');
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (6, 'Frank Miller', 'Ohio', 'Republican', '1840-1910');
INSERT INTO "representative" ("Representative_ID", "Name", "State", "Party", "Lifespan") VALUES (7, 'Grace Taylor', NULL, 'Independent', '1850-1920');
INSERT INTO "election" ("Election_ID", "Representative_ID", "Date", "Votes", "Vote_Percent", "Seats", "Place") VALUES (101, 2, '1842', 5000.0, 55.5, 1.0, 1.0);
INSERT INTO "election" ("Election_ID", "Representative_ID", "Date", "Votes", "Vote_Percent", "Seats", "Place") VALUES (102, 5, '1830', 4000.0, 48.0, 1.0, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "party" FROM "representative" WHERE ("state" <> 'New York' AND "state" = 'Pennsylvania') ORDER BY party, "party" NULLS LAST;

/*
Gold Result:
(None,)
('Democratic',)
('Whig',)
*/

-- Prediction Query
SELECT Party FROM representative WHERE State = 'New York' INTERSECT SELECT Party FROM representative WHERE State = 'Pennsylvania';

/*
Prediction Result:
*/