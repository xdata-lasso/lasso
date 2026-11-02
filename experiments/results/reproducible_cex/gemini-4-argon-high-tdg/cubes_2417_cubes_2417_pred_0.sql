-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (1, 'Swimmer_By_SwimmerID', 'USA', 50.1, '1:45', '2:40', '3:35', '4:30', '5:25', '6:20', '2020');
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (2, 'Swimmer_By_EventID', 'UK', 51.2, '1:46', '2:41', '3:36', '4:31', '5:26', '6:21', '2021');
INSERT INTO swimmer (ID, name, Nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, Time) VALUES (3, 'Swimmer_By_RecordID', 'CAN', 52.3, '1:47', '2:42', '3:37', '4:32', '5:27', '6:22', '2022');
INSERT INTO stadium (ID, name, Capacity, City, Country, Opening_year) VALUES (10, 'Olympic Pool', 15000, 'London', 'UK', 2012);
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (1, 10, 'Event_One', '2020');
INSERT INTO event (ID, Stadium_ID, Name, Year) VALUES (2, 10, 'Event_Two', '2021');
INSERT INTO record (Swimmer_ID, Event_ID, ID, Result) VALUES (1, 2, 3, 'Loss');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "name" FROM (SELECT "id", "name", "nationality", "meter_100", "meter_200", "meter_300", "meter_400", "meter_500", "meter_600", "meter_700", "time", "id_other", "result", "swimmer_id", "id" AS "event_id" FROM (SELECT "LHS"."id" AS "id", "LHS"."name" AS "name", "LHS"."nationality" AS "nationality", "LHS"."meter_100" AS "meter_100", "LHS"."meter_200" AS "meter_200", "LHS"."meter_300" AS "meter_300", "LHS"."meter_400" AS "meter_400", "LHS"."meter_500" AS "meter_500", "LHS"."meter_600" AS "meter_600", "LHS"."meter_700" AS "meter_700", "LHS"."time" AS "time", "RHS"."id" AS "id_other", "RHS"."result" AS "result", "RHS"."swimmer_id" AS "swimmer_id" FROM "swimmer" AS "LHS" INNER JOIN "record" AS "RHS" ON ("LHS"."id" = "RHS"."event_id"))) WHERE ("result" <> 'Win' OR "result" = 'Loss') ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Swimmer_By_EventID',)
*/

-- Prediction Query
SELECT t1.name FROM swimmer AS t1 JOIN record AS t2 ON t1.id = t2.swimmer_id WHERE RESULT = 'Win' INTERSECT SELECT t1.name FROM swimmer AS t1 JOIN record AS t2 ON t1.id = t2.swimmer_id WHERE RESULT = 'Loss';

/*
Prediction Result:
*/