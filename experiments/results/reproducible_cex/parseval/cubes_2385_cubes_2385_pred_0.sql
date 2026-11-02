-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: mountain --
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1, '5k5swwqcgs', 5601.0, 171.746906, 'n8c4pgu7v', 'mou_979e7f');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (-2147483647, 'e4', 5601.0, 779.409124, 'hria2ypuzhs', 'mou_979e7f');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (2, 'rwbbp6luhvd', 5200.0, 179.378884, 'ilbnp', 'mdpos');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (3, '5k5swwqcgs', 5600.0, 171.746906, 'n8c4pgu7v', 'e4');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (4, 'hria2ypuzhs', NULL, 663.049759, 'wbbp6luhvdlt', 'ilbnp');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (5, 'mdpos', NULL, 133.007885, '5u', 'w6kl');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM mountain WHERE (height > 5600.0 OR height = 5200.0) ORDER BY country, mountain.mountain_id NULLS LAST;

/*
Gold Result:
('mdpos',)
('mou_979e7f',)
('mou_979e7f',)
*/

-- Prediction Query
SELECT Country FROM mountain WHERE Height > 5600 INTERSECT SELECT Country FROM mountain WHERE Height < 5200;

/*
Prediction Result:
*/