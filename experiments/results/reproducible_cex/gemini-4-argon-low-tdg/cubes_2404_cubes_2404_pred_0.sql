-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "stadium" ("ID", "name", "Capacity", "City", "Country", "Opening_year") VALUES (1, 'Aquatics Centre', 17500, 'London', 'UK', 2011);
INSERT INTO "stadium" ("ID", "name", "Capacity", "City", "Country", "Opening_year") VALUES (2, 'Water Cube', 17000, 'Beijing', 'China', 2008);
INSERT INTO "stadium" ("ID", "name", "Capacity", "City", "Country", "Opening_year") VALUES (3, 'Tokyo Aquatics', 15000, 'Tokyo', 'Japan', 2020);
INSERT INTO "swimmer" ("ID", "name", "Nationality", "meter_100", "meter_200", "meter_300", "meter_400", "meter_500", "meter_600", "meter_700", "Time") VALUES (1, 'Michael Phelps', 'USA', 47.51, '1:42.96', '2:40.00', '3:40.00', '4:40.00', '5:40.00', '6:40.00', '2008');
INSERT INTO "swimmer" ("ID", "name", "Nationality", "meter_100", "meter_200", "meter_300", "meter_400", "meter_500", "meter_600", "meter_700", "Time") VALUES (2, 'Ian Thorpe', 'Australia', 48.56, '1:44.06', '2:41.00', '3:40.08', '4:41.00', '5:41.00', '6:41.00', '2000');
INSERT INTO "event" ("ID", "Stadium_ID", "Name", "Year") VALUES (2, 2, 'Zero Relay', '2020');
INSERT INTO "event" ("ID", "Stadium_ID", "Name", "Year") VALUES (5, 3, 'Butterfly 200m', '1996');
INSERT INTO "event" ("ID", "Stadium_ID", "Name", "Year") VALUES (10, 1, 'Alpha Sprint', '2004');
INSERT INTO "record" ("Swimmer_ID", "Event_ID", "ID", "Result") VALUES (1, 2, 100, 'Win');
INSERT INTO "record" ("Swimmer_ID", "Event_ID", "ID", "Result") VALUES (2, 5, 200, 'Loss');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM event ORDER BY id DESC) LIMIT 1);

/*
Gold Result:
('Alpha Sprint',)
*/

-- Prediction Query
SELECT name FROM event ORDER BY YEAR DESC, event.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Zero Relay',)
*/