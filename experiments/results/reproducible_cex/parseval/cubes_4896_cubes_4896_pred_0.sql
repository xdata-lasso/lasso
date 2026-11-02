-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: mountain --
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (2, '5k5swwqcgs', 171.746906, 557.512061, 'mou_1a202e', '8c4pgu7vfe');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (3, 'hria2ypu', 882.963176, 841.297061, 'mou_1a202e', 'rwbbp');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (4, 'luhvdltti', 182.319045, 998.421621, NULL, 'prmd');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (-2147483645, 'posiie5unw6k', 768.216462, 83.204633, 'C', '9');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (-2147483644, '00t5c4e', 950.466571, 796.740316, 'A', 'gce');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (-2147483643, '76nium52', 816.814398, 396.776796, 'O', 'uo4nrqrofqy');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (-2147483642, '5s5b', 22.720462, 990.777211, 'A', '02eutliqa11r');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT RANGE FROM mountain ORDER BY RANGE;

/*
Gold Result:
(None,)
('A',)
('C',)
('O',)
('mou_1a202e',)
*/

-- Prediction Query
SELECT DISTINCT RANGE FROM mountain ORDER BY Prominence DESC, RANGE NULLS LAST LIMIT 3;

/*
Prediction Result:
(None,)
('A',)
('mou_1a202e',)
*/