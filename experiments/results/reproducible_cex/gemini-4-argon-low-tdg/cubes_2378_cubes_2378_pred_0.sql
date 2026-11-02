-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (1, 'Zugspitze', 2962.0, 1746.0, 'Alps', 'Germany');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (2, 'Alpspitze', 2628.0, 165.0, 'Alps', 'Austria');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (3, 'Mont Blanc', 4808.0, 4695.0, 'Alps', 'West Germany');
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (10, 1, 'Hans', 'West Germany', '10:00', 100.0);
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (11, 1, 'Fritz', 'West Germany', '11:00', 95.0);
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (12, 2, 'Klaus', 'West Germany', '09:30', 110.0);
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (13, 3, 'Pierre', 'France', '12:00', 80.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "name_other" AS "name" FROM (SELECT "LHS"."climber_id" AS "climber_id", "LHS"."name" AS "name", "LHS"."country" AS "country", "LHS"."time" AS "time", "LHS"."points" AS "points", "LHS"."mountain_id" AS "mountain_id", "RHS"."name" AS "name_other", "RHS"."height" AS "height", "RHS"."prominence" AS "prominence", "RHS"."range" AS "range", "RHS"."country" AS "country_other" FROM "climber" AS "LHS" INNER JOIN "mountain" AS "RHS" ON ("LHS"."mountain_id" = "RHS"."mountain_id")) WHERE ("country" = 'West Germany') ORDER BY name;

/*
Gold Result:
('Alpspitze',)
('Zugspitze',)
*/

-- Prediction Query
SELECT DISTINCT T2.Name FROM climber AS T1 JOIN mountain AS T2 ON T1.Mountain_ID = T2.Mountain_ID WHERE T1.Country = 'West Germany';

/*
Prediction Result:
('Zugspitze',)
('Alpspitze',)
*/