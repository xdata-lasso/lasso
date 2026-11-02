-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (1, 'K2', 8611.0, 4017.0, 'Karakoram', 'Pakistan');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (2, 'Eiger', 3967.0, 362.0, 'Alps', 'Switzerland');
INSERT INTO "mountain" ("Mountain_ID", "Name", "Height", "Prominence", "Range", "Country") VALUES (3, 'Annapurna', 8091.0, 2984.0, 'Himalayas', 'Nepal');
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (1, 1, 'Zeta', 'West Germany', '15:00', 50.0);
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (2, 2, 'Mid', 'West Germany', '14:00', 60.0);
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Name", "Country", "Time", "Points") VALUES (3, 3, 'Alpha', 'West Germany', '13:00', 70.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "name_other" AS "name" FROM (SELECT "LHS"."climber_id" AS "climber_id", "LHS"."name" AS "name", "LHS"."country" AS "country", "LHS"."time" AS "time", "LHS"."points" AS "points", "LHS"."mountain_id" AS "mountain_id", "RHS"."name" AS "name_other", "RHS"."height" AS "height", "RHS"."prominence" AS "prominence", "RHS"."range" AS "range", "RHS"."country" AS "country_other" FROM "climber" AS "LHS" INNER JOIN "mountain" AS "RHS" ON ("LHS"."mountain_id" = "RHS"."mountain_id")) WHERE ("country" = 'West Germany') ORDER BY name;

/*
Gold Result:
('Annapurna',)
('Eiger',)
('K2',)
*/

-- Prediction Query
SELECT DISTINCT T2.Name FROM climber AS T1 JOIN mountain AS T2 ON T1.Mountain_ID = T2.Mountain_ID WHERE T1.Country = 'West Germany';

/*
Prediction Result:
('K2',)
('Eiger',)
('Annapurna',)
*/