-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (1, 'Ben Nevis', 1345.0, 1344.0, 'Grampian', 'United Kingdom');
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (1, 1, 'Pierre', 'France', '11:00', 200.0);
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (2, 1, 'Hans', 'Germany', '12:00', 250.0);
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