-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1028, 'Corey Jones', 1029.5, 1030.5, 'recently', 'Denmark');
INSERT INTO "climber" ("climber_id", "mountain_id", "name", "country", "time", "points") VALUES (1031, 1028, 'United Kingdom', 'Tokelau', 'spring', 1032.5);
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