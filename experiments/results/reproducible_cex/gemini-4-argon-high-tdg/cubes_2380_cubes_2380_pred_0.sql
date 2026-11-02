-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (1, 'Snowdon', 1085.0, 1038.0, 'Snowdonia', 'United Kingdom');
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (1, 1, 'Liam Tremblay', 'Canada', '03:20', 55.0);
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (2, 1, 'Noah Kelly', 'Australia', '02:50', 70.0);
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