-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (10, 'Mount Stanley', 5109.0, 3951.0, 'Rwenzori', 'Uganda');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (20, 'Mount Elgon', 4321.0, 2458.0, 'Elgon', 'Uganda');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (30, 'Mount Moroto', 3083.0, 1818.0, 'Karamoja', 'Uganda');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (40, 'Mount Kenya', 5199.0, 3825.0, 'Eastern Rift', 'Kenya');
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (1, 10, 'Alice', 'Kenya', '45:10', 100.0);
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (2, 10, 'Bob', 'Uganda', '12:30', 250.0);
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (3, 20, 'Charlie', 'Tanzania', '12:30', 180.0);
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (4, 20, 'Diana', 'Uganda', '28:05', 300.0);
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (10, 40, 'Edward', 'Uganda', '05:00', 400.0);
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (20, 40, 'Fiona', 'Kenya', '19:45', 150.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "time" FROM (SELECT "LHS"."mountain_id" AS "mountain_id", "LHS"."name" AS "name", "LHS"."height" AS "height", "LHS"."prominence" AS "prominence", "LHS"."range" AS "range", "LHS"."country" AS "country", "RHS"."climber_id" AS "climber_id", "RHS"."name" AS "name_other", "RHS"."country" AS "country_other", "RHS"."time" AS "time", "RHS"."points" AS "points" FROM "mountain" AS "LHS" INNER JOIN "climber" AS "RHS" ON ("LHS"."mountain_id" = "RHS"."mountain_id")) WHERE ("country" = 'Uganda') ORDER BY TIME, "time" NULLS LAST;

/*
Gold Result:
('12:30',)
('12:30',)
('28:05',)
('45:10',)
*/

-- Prediction Query
SELECT T1.Time FROM climber AS T1 JOIN mountain AS T2 ON T1.Mountain_ID = T2.Mountain_ID WHERE T2.Country = 'Uganda';

/*
Prediction Result:
('45:10',)
('12:30',)
('12:30',)
('28:05',)
*/