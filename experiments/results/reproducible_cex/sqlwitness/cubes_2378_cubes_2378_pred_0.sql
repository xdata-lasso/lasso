-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO mountain (mountain_id, name, height, prominence, range, country) VALUES (0, 'West Germany', NULL, NULL, NULL, 'default2'), (1, 'default2', NULL, 1.0, NULL, NULL), (2, NULL, 1.0, NULL, 'default1', 'West Germany'), (3, 'default2', 0.0, 0.0, 'West Germany', 'default2'), (4, 'default2', NULL, 1.0, 'West Germany', 'West Germany'), (5, 'default2', 1.0, 1.0, 'default2', 'default2'), (6, 'West Germany', 0.0, 1.0, 'default2', 'default1');
INSERT INTO climber (climber_id, mountain_id, name, country, time, points) VALUES (1, 1, 'default2', 'default1', 'West Germany', NULL), (0, NULL, NULL, 'default1', NULL, 1.0), (2, 3, 'West Germany', 'West Germany', 'default2', NULL), (3, 4, 'default2', 'default2', 'default1', NULL), (4, 0, 'default1', 'West Germany', 'West Germany', 1.0), (5, 1, 'default2', 'default1', NULL, 0.0), (6, 4, 'West Germany', 'default1', NULL, 0.0), (7, 4, 'West Germany', 'West Germany', 'default1', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "name_other" AS "name" FROM (SELECT "LHS"."climber_id" AS "climber_id", "LHS"."name" AS "name", "LHS"."country" AS "country", "LHS"."time" AS "time", "LHS"."points" AS "points", "LHS"."mountain_id" AS "mountain_id", "RHS"."name" AS "name_other", "RHS"."height" AS "height", "RHS"."prominence" AS "prominence", "RHS"."range" AS "range", "RHS"."country" AS "country_other" FROM "climber" AS "LHS" INNER JOIN "mountain" AS "RHS" ON ("LHS"."mountain_id" = "RHS"."mountain_id")) WHERE ("country" = 'West Germany') ORDER BY name;

/*
Gold Result:
('West Germany',)
('default2',)
*/

-- Prediction Query
SELECT DISTINCT T2.Name FROM climber AS T1 JOIN mountain AS T2 ON T1.Mountain_ID = T2.Mountain_ID WHERE T1.Country = 'West Germany';

/*
Prediction Result:
('default2',)
('West Germany',)
*/