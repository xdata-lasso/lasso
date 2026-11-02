-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: mountain --
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (-2147483648, '5k5swwqcgs', 171.746906, 557.512061, 'mou_4446e5', '8c4pgu7vfe');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (-2147483647, 'hria2ypu', 882.963176, 841.297061, 'mou_ce3387', 'rwbbp');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (-2147483646, 'luhvdltti', 182.319045, 998.421621, 'mou_4446e5', 'prmd');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (-2147483645, 'posiie5unw6k', 768.216462, 83.204633, 'mou_74b2d2', '9');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (-2147483644, '00t5c4e', 950.466571, 796.740316, 'mou_ce3387', 'gce');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (-2147483643, '76nium52', 816.814398, 396.776796, 'mou_3ed74e', 'uo4nrqrofqy');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (-2147483642, '5s5b', 22.720462, 990.777211, 'mou_4446e5', '02eutliqa11r');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (-2147483641, 'ytoo3o9', 111.926013, 731.301441, NULL, '72klex14ji7z');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT RANGE FROM (SELECT RANGE FROM mountain INTERSECT SELECT RANGE FROM mountain) ORDER BY RANGE;

/*
Gold Result:
(None,)
('mou_3ed74e',)
('mou_4446e5',)
('mou_74b2d2',)
('mou_ce3387',)
*/

-- Prediction Query
SELECT DISTINCT RANGE FROM mountain ORDER BY Prominence DESC, RANGE NULLS LAST LIMIT 3;

/*
Prediction Result:
('mou_ce3387',)
(None,)
('mou_4446e5',)
*/