-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: mountain --
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1, 'mou_266535', 1.0, 1.0, 'mou_1e5e5e', 'mou_850eca');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (-2147483647, 'mou_5bf953', 1.0, 1.0, 'mou_9027c2', 'mou_8462b9');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (-2147483646, 'q_1_659836', 582.588439, 680.190136, 'k5swwqcg', 'k9n8c');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (-2147483645, 'q_1_659836', 475.173408, 935.695299, 'u7vfe4hria2y', 'uzhs');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (-1, 'rwbbp6luhvd', 179.378884, 304.02808, 'bnp', 'mdpos');

INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (0, 'ie5', 327.753528, 218.301157, 'klfa9000t', 'c4ecigce');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM mountain ORDER BY mountain_id) LIMIT 1);

/*
Gold Result:
('mou_5bf953',)
*/

-- Prediction Query
SELECT Name FROM mountain ORDER BY Height DESC, mountain.mountain_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('q_1_659836',)
*/