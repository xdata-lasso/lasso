-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1072, 'Gina Carter', 1073.5, 1074.5, 'coach', 'Korea');
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1082, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "climber" ("climber_id", "mountain_id", "name", "country", "time", "points") VALUES (1075, 1072, 'Nathan Cortez', 'West Germany', 'month', 1076.5);
INSERT INTO "climber" ("climber_id", "mountain_id", "name", "country", "time", "points") VALUES (1077, 1082, 'Nathan Cortez', 'West Germany', 'month', 1076.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "name_other" AS "name" FROM (SELECT "LHS"."climber_id" AS "climber_id", "LHS"."name" AS "name", "LHS"."country" AS "country", "LHS"."time" AS "time", "LHS"."points" AS "points", "LHS"."mountain_id" AS "mountain_id", "RHS"."name" AS "name_other", "RHS"."height" AS "height", "RHS"."prominence" AS "prominence", "RHS"."range" AS "range", "RHS"."country" AS "country_other" FROM "climber" AS "LHS" INNER JOIN "mountain" AS "RHS" ON ("LHS"."mountain_id" = "RHS"."mountain_id")) WHERE ("country" = 'West Germany') ORDER BY name;

/*
Gold Result:
(None,)
('Gina Carter',)
*/

-- Prediction Query
SELECT DISTINCT T2.Name FROM climber AS T1 JOIN mountain AS T2 ON T1.Mountain_ID = T2.Mountain_ID WHERE T1.Country = 'West Germany';

/*
Prediction Result:
('Gina Carter',)
(None,)
*/