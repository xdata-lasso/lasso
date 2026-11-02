-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: swimmer --
INSERT INTO "swimmer" ("id", "name", "nationality", "meter_100", "meter_200", "meter_300", "meter_400", "meter_500", "meter_600", "meter_700", "time") VALUES (1, 'swi_eea8c8', 'swi_212ff5', 1.0, 'swi_641589', 'swi_368ff0', 'swi_d19346', 'swi_0742f8', 'swi_a458ad', 'swi_93f94c', 'swi_6e0380');

INSERT INTO "swimmer" ("id", "name", "nationality", "meter_100", "meter_200", "meter_300", "meter_400", "meter_500", "meter_600", "meter_700", "time") VALUES (-2147483647, 'swi_1e26a0', 'swi_f1831f', 1.0, 'swi_4721b1', 'swi_625ffe', 'swi_2a61df', 'swi_dcb470', 'swi_7fea59', 'swi_58f54e', 'swi_530df5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nationality, id AS count___ FROM (SELECT * FROM (SELECT * FROM (SELECT id, name, nationality, meter_100, meter_200, meter_300, meter_400, meter_500, meter_600, meter_700, TIME, COUNT(*) OVER () AS n FROM swimmer) ORDER BY meter_600 DESC) LIMIT 1);

/*
Gold Result:
('swi_212ff5', 1)
*/

-- Prediction Query
SELECT nationality, COUNT(*) FROM swimmer GROUP BY nationality HAVING COUNT(*) > 1;

/*
Prediction Result:
*/