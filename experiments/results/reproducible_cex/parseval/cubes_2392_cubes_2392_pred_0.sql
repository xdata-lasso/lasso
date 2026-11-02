-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: mountain --
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1, '5k5swwqcgs', 5000.0, 171.746906, 'n8c4pgu7v', 'mou_a22549');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (2, 'e4', 5000.0, 779.409124, 'hria2ypuzhs', 'mou_a22549');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (3, 'rwbbp6luhvd', 5000.0, 179.378884, 'ilbnp', 'mou_a22549');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (4, 'mdpos', 4999.99, 133.007885, '5u', 'w6kl');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (5, 'a9', NULL, 877.276439, '00t5c4ecigc', 'e376nium52');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (6, 'zbuo4nrqrof', 5000.0, 586.906897, 'p5s5bbp', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM mountain WHERE (height >= 5000.0) ORDER BY country, mountain.mountain_id NULLS LAST;

/*
Gold Result:
(None,)
('mou_a22549',)
('mou_a22549',)
('mou_a22549',)
*/

-- Prediction Query
SELECT Country FROM mountain WHERE Height > 5000;

/*
Prediction Result:
*/