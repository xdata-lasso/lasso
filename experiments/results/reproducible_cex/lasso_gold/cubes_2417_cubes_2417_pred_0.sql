-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (1001, 'Allison Hill', 1002, 'East Jill', 'Philippines', 1003);
INSERT INTO "swimmer" ("id", "name", "nationality", "meter_100", "meter_200", "meter_300", "meter_400", "meter_500", "meter_600", "meter_700", "time") VALUES (1004, 'Kimberly Garza', 'Antigua and Barbuda', 1005.5, 'all', 'better', 'discover', 'early', 'mouth', 'play', 'agreement');
INSERT INTO "swimmer" ("id", "name", "nationality", "meter_100", "meter_200", "meter_300", "meter_400", "meter_500", "meter_600", "meter_700", "time") VALUES (1006, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "event" ("id", "stadium_id", "name", "year") VALUES (1004, 1001, 'Michelle Miles', 'kind');
INSERT INTO "record" ("swimmer_id", "event_id", "id", "result") VALUES (1006, 1004, 1007, 'Loss');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "name" FROM (SELECT "id", "name", "nationality", "meter_100", "meter_200", "meter_300", "meter_400", "meter_500", "meter_600", "meter_700", "time", "id_other", "result", "swimmer_id", "id" AS "event_id" FROM (SELECT "LHS"."id" AS "id", "LHS"."name" AS "name", "LHS"."nationality" AS "nationality", "LHS"."meter_100" AS "meter_100", "LHS"."meter_200" AS "meter_200", "LHS"."meter_300" AS "meter_300", "LHS"."meter_400" AS "meter_400", "LHS"."meter_500" AS "meter_500", "LHS"."meter_600" AS "meter_600", "LHS"."meter_700" AS "meter_700", "LHS"."time" AS "time", "RHS"."id" AS "id_other", "RHS"."result" AS "result", "RHS"."swimmer_id" AS "swimmer_id" FROM "swimmer" AS "LHS" INNER JOIN "record" AS "RHS" ON ("LHS"."id" = "RHS"."event_id"))) WHERE ("result" <> 'Win' OR "result" = 'Loss') ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Kimberly Garza',)
*/

-- Prediction Query
SELECT t1.name FROM swimmer AS t1 JOIN record AS t2 ON t1.id = t2.swimmer_id WHERE RESULT = 'Win' INTERSECT SELECT t1.name FROM swimmer AS t1 JOIN record AS t2 ON t1.id = t2.swimmer_id WHERE RESULT = 'Loss';

/*
Prediction Result:
*/