-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "swimmer" ("ID", "name", "Nationality", "meter_100", "meter_200", "meter_300", "meter_400", "meter_500", "meter_600", "meter_700", "Time") VALUES (1, 'Swimmer A', 'Australia', 50.0, '1:50.00', '2:50.00', '3:50.00', '4:50.00', '5:50.00', '6:50.00', '2010');
INSERT INTO "swimmer" ("ID", "name", "Nationality", "meter_100", "meter_200", "meter_300", "meter_400", "meter_500", "meter_600", "meter_700", "Time") VALUES (2, 'Swimmer B', 'Australia', 50.0, '1:50.00', '2:50.00', '3:50.00', '4:50.00', '5:50.00', '6:50.00', '2010');
INSERT INTO "swimmer" ("ID", "name", "Nationality", "meter_100", "meter_200", "meter_300", "meter_400", "meter_500", "meter_600", "meter_700", "Time") VALUES (3, 'Swimmer C', 'Australia', 51.0, '1:48.00', '2:55.00', '3:55.00', '4:55.00', '5:55.00', '6:55.00', '2012');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "meter_200", "meter_300" FROM "swimmer" WHERE ("nationality" = 'Australia') ORDER BY meter_200, swimmer.id NULLS LAST;

/*
Gold Result:
('1:48.00', '2:55.00')
('1:50.00', '2:50.00')
('1:50.00', '2:50.00')
*/

-- Prediction Query
SELECT meter_200, meter_300 FROM swimmer WHERE nationality = 'Australia';

/*
Prediction Result:
('1:50.00', '2:50.00')
('1:50.00', '2:50.00')
('1:48.00', '2:55.00')
*/