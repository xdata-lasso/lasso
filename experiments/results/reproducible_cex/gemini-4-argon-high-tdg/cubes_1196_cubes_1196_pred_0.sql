-- Schema DDL
CREATE TABLE "captain" ("Captain_ID" INTEGER PRIMARY KEY, "Ship_ID" INTEGER, "Name" TEXT, "age" TEXT, "Class" TEXT, "Rank" TEXT, FOREIGN KEY ("Ship_ID") REFERENCES "Ship" ("Ship_ID"));

CREATE TABLE "Ship" ("Ship_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Type" TEXT, "Built_Year" REAL, "Class" TEXT, "Flag" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (1, 'HMS Speedy', 'Cutter', 1782.0, 'Frigate', 'UK');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (2, 'HMS Pickle', 'Schooner', 1799.0, 'Cutter', 'UK');
INSERT INTO "Ship" ("Ship_ID", "Name", "Type", "Built_Year", "Class", "Flag") VALUES (3, 'HMS Sophie', 'Brig', 1809.0, 'Armed schooner', 'France');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (1, 1, 'Thomas Cochrane', '28', 'Cutter', 'Captain');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (2, 1, 'Jack Aubrey', '32', 'Cutter', 'Captain');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (3, 1, 'William Bush', '29', 'Cutter', 'Lieutenant');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (4, 2, 'James Dillon', '30', 'Armed schooner', 'Commander');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (5, 2, 'john Lapenotiere', '35', 'Armed schooner', 'Captain');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (6, 2, 'Horatio Nelson', '45', 'Frigate', 'Admiral');
INSERT INTO "captain" ("Captain_ID", "Ship_ID", "Name", "age", "Class", "Rank") VALUES (7, 3, 'Edward Pellew', '40', 'Sloop', 'Ensign');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "rank" FROM "captain" WHERE ("class" = 'Cutter' OR "class" = 'Armed schooner') ORDER BY rank, "rank" NULLS LAST;

/*
Gold Result:
('Captain',)
('Commander',)
('Lieutenant',)
*/

-- Prediction Query
SELECT rank FROM captain WHERE CLASS = 'Cutter' INTERSECT SELECT rank FROM captain WHERE CLASS = 'Armed schooner';

/*
Prediction Result:
('Captain',)
*/