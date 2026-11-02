-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (8, 'United Kingdom12', 12, 12, 'United Kingdom12', 'United Kingdom12');
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (7, 'United Kingdom12', 12, 12, 'United Kingdom12', 'United Kingdom12');
INSERT INTO "climber" ("climber_id", "mountain_id", "name", "country", "time", "points") VALUES (10, NULL, 'United Kingdom12', 'United Kingdom12', 'United Kingdom12', NULL);
INSERT INTO "climber" ("climber_id", "mountain_id", "name", "country", "time", "points") VALUES (9, NULL, 'United Kingdom12', 'United Kingdom11', 'United Kingdom12', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "points" AS "max_points_" FROM (SELECT "country", MAX("points") AS "points" FROM "climber" GROUP BY "country") WHERE ("country" = 'United Kingdom') ORDER BY max_points_;

/*
Gold Result:
*/

-- Prediction Query
SELECT MAX(Points) FROM climber WHERE Country = 'United Kingdom';

/*
Prediction Result:
(None,)
*/