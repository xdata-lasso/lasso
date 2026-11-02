-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "stadium" ("ID", "name", "Capacity", "City", "Country", "Opening_year") VALUES (100, 'Aquatic Center', 15000, 'London', 'UK', 2011);
INSERT INTO "event" ("ID", "Stadium_ID", "Name", "Year") VALUES (10, 100, '100m Freestyle', '2020');
INSERT INTO "event" ("ID", "Stadium_ID", "Name", "Year") VALUES (20, 100, '200m Butterfly', '2020');
INSERT INTO "swimmer" ("ID", "name", "Nationality", "meter_100", "meter_200", "meter_300", "meter_400", "meter_500", "meter_600", "meter_700", "Time") VALUES (1, 'Zoe', 'USA', 52.1, '1:55.0', '2:58.0', '4:01.0', '5:05.0', '6:10.0', '7:15.0', '52.1');
INSERT INTO "swimmer" ("ID", "name", "Nationality", "meter_100", "meter_200", "meter_300", "meter_400", "meter_500", "meter_600", "meter_700", "Time") VALUES (2, 'Alice', 'AUS', 51.8, '1:54.2', '2:57.1', '4:00.5', '5:04.0', '6:08.0', '7:12.0', '51.8');
INSERT INTO "swimmer" ("ID", "name", "Nationality", "meter_100", "meter_200", "meter_300", "meter_400", "meter_500", "meter_600", "meter_700", "Time") VALUES (3, 'Bob', 'CAN', 53.0, '1:56.5', '2:59.0', '4:03.0', '5:07.0', '6:12.0', '7:18.0', '53.0');
INSERT INTO "swimmer" ("ID", "name", "Nationality", "meter_100", "meter_200", "meter_300", "meter_400", "meter_500", "meter_600", "meter_700", "Time") VALUES (4, 'Charlie', 'FRA', 52.5, '1:55.8', '2:58.5', '4:02.0', '5:06.0', '6:11.0', '7:16.0', '52.5');
INSERT INTO "swimmer" ("ID", "name", "Nationality", "meter_100", "meter_200", "meter_300", "meter_400", "meter_500", "meter_600", "meter_700", "Time") VALUES (5, 'Diana', 'GER', 54.0, '1:58.0', '3:01.0', '4:05.0', '5:10.0', '6:15.0', '7:20.0', '54.0');
INSERT INTO "record" ("Swimmer_ID", "Event_ID", "ID", "Result") VALUES (1, 10, 501, 'Win');
INSERT INTO "record" ("Swimmer_ID", "Event_ID", "ID", "Result") VALUES (2, 20, 502, 'Win');
INSERT INTO "record" ("Swimmer_ID", "Event_ID", "ID", "Result") VALUES (3, 10, 503, 'Loss');
INSERT INTO "record" ("Swimmer_ID", "Event_ID", "ID", "Result") VALUES (4, 20, 504, 'Draw');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "id", "name", "nationality", "meter_100", "meter_200", "meter_300", "meter_400", "meter_500", "meter_600", "meter_700", "time", "id_other", "result", "event_id", "id" AS "swimmer_id" FROM (SELECT "LHS"."id" AS "id", "LHS"."name" AS "name", "LHS"."nationality" AS "nationality", "LHS"."meter_100" AS "meter_100", "LHS"."meter_200" AS "meter_200", "LHS"."meter_300" AS "meter_300", "LHS"."meter_400" AS "meter_400", "LHS"."meter_500" AS "meter_500", "LHS"."meter_600" AS "meter_600", "LHS"."meter_700" AS "meter_700", "LHS"."time" AS "time", "RHS"."id" AS "id_other", "RHS"."result" AS "result", "RHS"."event_id" AS "event_id" FROM "swimmer" AS "LHS" INNER JOIN "record" AS "RHS" ON ("LHS"."id" = "RHS"."swimmer_id"))) WHERE ("result" = 'Win') ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Alice',)
('Zoe',)
*/

-- Prediction Query
SELECT t1.name FROM swimmer AS t1 JOIN record AS t2 ON t1.id = t2.swimmer_id WHERE RESULT = 'Win';

/*
Prediction Result:
('Zoe',)
('Alice',)
*/