-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mountain" ("Mountain_ID", "Country") VALUES (1, 'Uganda');
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Time") VALUES (1, 1, 'B');
INSERT INTO "climber" ("Climber_ID", "Mountain_ID", "Time") VALUES (2, 1, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "time" FROM (SELECT "LHS"."mountain_id" AS "mountain_id", "LHS"."name" AS "name", "LHS"."height" AS "height", "LHS"."prominence" AS "prominence", "LHS"."range" AS "range", "LHS"."country" AS "country", "RHS"."climber_id" AS "climber_id", "RHS"."name" AS "name_other", "RHS"."country" AS "country_other", "RHS"."time" AS "time", "RHS"."points" AS "points" FROM "mountain" AS "LHS" INNER JOIN "climber" AS "RHS" ON ("LHS"."mountain_id" = "RHS"."mountain_id")) WHERE ("country" = 'Uganda') ORDER BY TIME, "time" NULLS LAST;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT T1.Time FROM climber AS T1 JOIN mountain AS T2 ON T1.Mountain_ID = T2.Mountain_ID WHERE T2.Country = 'Uganda';

/*
Prediction Result:
('B',)
('A',)
*/