-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (7, NULL, 5000, NULL, NULL, '16');
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (6, '13', 5001, 14, '15', '16');
INSERT INTO "climber" ("climber_id", "mountain_id", "name", "country", "time", "points") VALUES (9, 6, '16', '16', '16', 16);
INSERT INTO "climber" ("climber_id", "mountain_id", "name", "country", "time", "points") VALUES (8, 6, '16', '16', '16', 16);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM mountain WHERE (height >= 5000.0) ORDER BY country, mountain.mountain_id NULLS LAST;

/*
Gold Result:
('16',)
('16',)
*/

-- Prediction Query
SELECT Country FROM mountain WHERE Height > 5000;

/*
Prediction Result:
('16',)
*/