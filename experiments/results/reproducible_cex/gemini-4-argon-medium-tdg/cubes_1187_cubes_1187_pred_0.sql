-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic GROUP BY, COUNT(*), ORDER BY count___ ASC, tie-breaking by rank ASC, and NULLS LAST for rank.
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (1, 'Enterprise', 'Carrier', 1990.0, 'A', 'USA');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (1, 1, 'Kirk', '40', 'A', 'Admiral');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (2, 1, 'Picard', '50', 'A', 'Captain');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (3, 1, 'Sisko', '45', 'A', 'Captain');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (4, 1, 'Janeway', '42', 'A', 'Commander');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (5, 1, 'Archer', '48', 'A', 'Commander');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (6, 1, 'Pike', '55', 'A', NULL);
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (7, 1, 'Lorca', '46', 'A', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, rank FROM (SELECT rank, COUNT(*) AS n FROM captain GROUP BY rank) ORDER BY count___, rank NULLS LAST;

/*
Gold Result:
(1, 'Admiral')
(2, 'Captain')
(2, 'Commander')
(2, None)
*/

-- Prediction Query
SELECT COUNT(*), rank FROM captain GROUP BY rank;

/*
Prediction Result:
(2, None)
(1, 'Admiral')
(2, 'Captain')
(2, 'Commander')
*/