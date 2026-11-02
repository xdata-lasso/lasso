-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests ORDER BY "name" (ASC vs DESC) and tie-breaking ORDER BY "capacity" (ASC vs DESC) when stadium names are identical.
INSERT INTO "stadium" ("ID", "name", "Capacity", "City", "Country", "Opening_year") VALUES (1, 'B Pool', 8000, 'Tokyo', 'Japan', 2019);
INSERT INTO "stadium" ("ID", "name", "Capacity", "City", "Country", "Opening_year") VALUES (2, 'A Pool', 9000, 'Sydney', 'Australia', 2000);
INSERT INTO "stadium" ("ID", "name", "Capacity", "City", "Country", "Opening_year") VALUES (3, 'A Pool', 4000, 'Melbourne', 'Australia', 2005);
INSERT INTO "event" ("ID", "Stadium_ID", "Name", "Year") VALUES (1, 1, 'World Junior', '2021');
INSERT INTO "event" ("ID", "Stadium_ID", "Name", "Year") VALUES (2, 2, 'World Junior', '2019');
INSERT INTO "event" ("ID", "Stadium_ID", "Name", "Year") VALUES (3, 3, 'World Junior', '2018');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "capacity" FROM (SELECT "LHS"."id" AS "id", "LHS"."name" AS "name", "LHS"."capacity" AS "capacity", "LHS"."city" AS "city", "LHS"."country" AS "country", "LHS"."opening_year" AS "opening_year", "RHS"."id" AS "id_other", "RHS"."name" AS "name_other", "RHS"."year" AS "year" FROM "stadium" AS "LHS" INNER JOIN (SELECT * FROM "event" WHERE ("name" = 'World Junior')) AS RHS ON (LHS.id = RHS.stadium_id)) ORDER BY name, "name" NULLS LAST, "capacity" NULLS LAST;

/*
Gold Result:
('A Pool', 4000)
('A Pool', 9000)
('B Pool', 8000)
*/

-- Prediction Query
SELECT t1.name, t1.capacity FROM stadium AS t1 JOIN event AS t2 ON t1.id = t2.stadium_id WHERE t2.name = 'World Junior';

/*
Prediction Result:
('B Pool', 8000)
('A Pool', 9000)
('A Pool', 4000)
*/