-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "stadium" ("ID", "name", "Capacity", "City", "Country", "Opening_year") VALUES (1, 'Sydney Aquatic Centre', 17000, 'Sydney', 'Australia', 1994);
INSERT INTO "stadium" ("ID", "name", "Capacity", "City", "Country", "Opening_year") VALUES (2, 'London Aquatics Centre', 17500, 'London', 'UK', 2011);
INSERT INTO "event" ("ID", "Stadium_ID", "Name", "Year") VALUES (10, 1, 'Summer Finals', '2000');
INSERT INTO "event" ("ID", "Stadium_ID", "Name", "Year") VALUES (20, 2, 'World Championship', '2012');
INSERT INTO "swimmer" ("ID", "name", "Nationality", "meter_100", "meter_200", "meter_300", "meter_400", "meter_500", "meter_600", "meter_700", "Time") VALUES (1, 'Ian Thorpe', 'Australia', 48.5, '1:45.0', '2:42.0', '3:40.0', '4:38.0', '5:36.0', '6:34.0', '7:32.0');
INSERT INTO "swimmer" ("ID", "name", "Nationality", "meter_100", "meter_200", "meter_300", "meter_400", "meter_500", "meter_600", "meter_700", "Time") VALUES (2, 'Grant Hackett', 'Australia', 47.0, '1:46.5', '2:40.0', '3:42.0', '4:35.0', '5:30.0', '6:25.0', '7:20.0');
INSERT INTO "swimmer" ("ID", "name", "Nationality", "meter_100", "meter_200", "meter_300", "meter_400", "meter_500", "meter_600", "meter_700", "Time") VALUES (3, 'Michael Phelps', 'USA', 47.5, '1:42.9', '2:38.0', '3:35.0', '4:30.0', '5:28.0', '6:22.0', '7:15.0');
INSERT INTO "swimmer" ("ID", "name", "Nationality", "meter_100", "meter_200", "meter_300", "meter_400", "meter_500", "meter_600", "meter_700", "Time") VALUES (4, 'Kyle Chalmers', 'Australia', 49.9, '1:44.1', '2:49.0', '3:49.0', '4:49.0', '5:49.0', '6:49.0', '7:49.0');
INSERT INTO "record" ("Swimmer_ID", "Event_ID", "ID", "Result") VALUES (1, 10, 100, 'Win');
INSERT INTO "record" ("Swimmer_ID", "Event_ID", "ID", "Result") VALUES (1, 20, 101, 'Win');
INSERT INTO "record" ("Swimmer_ID", "Event_ID", "ID", "Result") VALUES (3, 10, 102, 'Win');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "meter_200", "meter_300" FROM "swimmer" WHERE ("nationality" = 'Australia') ORDER BY meter_200, swimmer.id NULLS LAST;

/*
Gold Result:
('1:44.1', '2:49.0')
('1:45.0', '2:42.0')
('1:46.5', '2:40.0')
*/

-- Prediction Query
SELECT meter_200, meter_300 FROM swimmer WHERE nationality = 'Australia';

/*
Prediction Result:
('1:45.0', '2:42.0')
('1:46.5', '2:40.0')
('1:44.1', '2:49.0')
*/