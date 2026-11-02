-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: mountain --
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1, 'mou_d50f22', 5000.0, 1.0, '5k5swwqcgs', '9n8');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (-2147483647, 'mou_d50f22', 5000.0, 1.0, '4', 'gu7v');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (2, 'e4', 5000.0, 1000.0, 'hria2ypuzhs', 'rwbbp6luhvd');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (3, 'tti', 5000.0, NULL, 'bnp', 'mdpos');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (4, 'ie5', 4999.99, 1.0, 'nw6klf', 'a9000t5c4eci');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (5, 'gce376nium52', 4999.99, 1000.0, 'zbuo4nrqrof', 'qyp5s5bbp0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM mountain WHERE (height >= 5000.0 AND prominence <> 1000.0) ORDER BY name, mountain.mountain_id NULLS LAST;

/*
Gold Result:
('mou_d50f22',)
('mou_d50f22',)
*/

-- Prediction Query
SELECT Name FROM mountain WHERE Height > 5000 OR Prominence > 1000;

/*
Prediction Result:
*/