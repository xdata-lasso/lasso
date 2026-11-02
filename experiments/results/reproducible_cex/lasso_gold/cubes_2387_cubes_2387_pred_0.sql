-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1059, 'Deborah Richards', 1060.5, 1061.5, 'water', 'Uganda');
INSERT INTO "mountain" ("mountain_id", "name", "height", "prominence", "range", "country") VALUES (1069, 'Kendra Maddox DVM', 1070.5, 1071.5, 'activity', 'Uganda');
INSERT INTO "climber" ("climber_id", "mountain_id", "name", "country", "time", "points") VALUES (1062, 1059, 'Heidi Osborn', 'Burundi', 'Mr', 1063.5);
INSERT INTO "climber" ("climber_id", "mountain_id", "name", "country", "time", "points") VALUES (1067, 1059, 'Jennifer Brown', 'Hong Kong', 'pick', 1068.5);
INSERT INTO "climber" ("climber_id", "mountain_id", "name", "country", "time", "points") VALUES (1072, 1069, 'Ashley Dyer', 'Sao Tome and Principe', 'example', 1073.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "time" FROM (SELECT "LHS"."mountain_id" AS "mountain_id", "LHS"."name" AS "name", "LHS"."height" AS "height", "LHS"."prominence" AS "prominence", "LHS"."range" AS "range", "LHS"."country" AS "country", "RHS"."climber_id" AS "climber_id", "RHS"."name" AS "name_other", "RHS"."country" AS "country_other", "RHS"."time" AS "time", "RHS"."points" AS "points" FROM "mountain" AS "LHS" INNER JOIN "climber" AS "RHS" ON ("LHS"."mountain_id" = "RHS"."mountain_id")) WHERE ("country" = 'Uganda') ORDER BY TIME, "time" NULLS LAST;

/*
Gold Result:
('Mr',)
('example',)
('pick',)
*/

-- Prediction Query
SELECT T1.Time FROM climber AS T1 JOIN mountain AS T2 ON T1.Mountain_ID = T2.Mountain_ID WHERE T2.Country = 'Uganda';

/*
Prediction Result:
('Mr',)
('pick',)
('example',)
*/