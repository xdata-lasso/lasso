-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "swimmer" ("ID", "name", "Nationality", "meter_100", "meter_200", "meter_300", "meter_400", "meter_500", "meter_600", "meter_700", "Time") VALUES (1, 'Michael Phelps', 'USA', 47.5, '1:42.96', '2:40.00', '3:40.00', '4:40.00', '5:40.00', '6:40.00', '2008');
INSERT INTO "swimmer" ("ID", "name", "Nationality", "meter_100", "meter_200", "meter_300", "meter_400", "meter_500", "meter_600", "meter_700", "Time") VALUES (2, 'Ian Thorpe', 'Australia', 48.5, '1:44.06', '2:41.00', '3:40.08', '4:41.00', '5:41.00', '6:41.00', '2000');
INSERT INTO "stadium" ("ID", "name", "Capacity", "City", "Country", "Opening_year") VALUES (10, 'Aquatic Center', 17000, 'Beijing', 'China', 2008);
INSERT INTO "event" ("ID", "Stadium_ID", "Name", "Year") VALUES (1, 10, '200m Butterfly', '2008');
INSERT INTO "event" ("ID", "Stadium_ID", "Name", "Year") VALUES (2, 10, '100m Freestyle', '2004');
INSERT INTO "event" ("ID", "Stadium_ID", "Name", "Year") VALUES (3, NULL, '100m Freestyle', '2012');
INSERT INTO "record" ("Swimmer_ID", "Event_ID", "ID", "Result") VALUES (1, 1, 101, 'Win');
INSERT INTO "record" ("Swimmer_ID", "Event_ID", "ID", "Result") VALUES (2, 1, 102, 'Loss');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM event ORDER BY name, event.id NULLS LAST;

/*
Gold Result:
('100m Freestyle',)
('100m Freestyle',)
('200m Butterfly',)
*/

-- Prediction Query
SELECT name FROM event ORDER BY YEAR DESC, event.id NULLS LAST;

/*
Prediction Result:
('100m Freestyle',)
('200m Butterfly',)
('100m Freestyle',)
*/