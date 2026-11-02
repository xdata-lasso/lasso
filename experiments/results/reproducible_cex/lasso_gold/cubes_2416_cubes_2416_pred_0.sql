-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (1035, 'Colleen Nguyen', 1038, 'Jasonfort', 'Samoa', 1041);
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (1036, 'Amy Underwood', 1045.0, 'Wilkersonmouth', 'Monaco', 1054.0);
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (1037, 'Jennifer Jones', 1052.0, 'West Donald', 'Mauritania', 1067.0);
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (1044, 'Kevin Hurst', NULL, 'East Courtneychester', 'Pitcairn Islands', 1050);
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (1045, 'Daniel Bright', NULL, 'South Patrickmouth', 'Saint Helena', 1063.0);
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (1046, 'Ann Williams', NULL, 'Tashatown', 'Brazil', 1076.0);
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (1053, 'Kimberly Adams', 1056, 'Teresaburgh', 'Central African Republic', 1059);
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (1054, 'Ashley Graham', 1063.0, 'Port Colleenhaven', 'Mauritius', 1072.0);
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (1055, 'Troy Liu', 1070.0, 'East Nathaniel', 'Zimbabwe', 1085.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT id, name, capacity, city, country, opening_year, AVG(capacity) OVER () AS meancapacity FROM stadium) WHERE (meancapacity > capacity) ORDER BY name;

/*
Gold Result:
('Amy Underwood',)
('Colleen Nguyen',)
('Jennifer Jones',)
*/

-- Prediction Query
SELECT name FROM stadium WHERE capacity < (SELECT AVG(capacity) FROM stadium);

/*
Prediction Result:
('Colleen Nguyen',)
('Amy Underwood',)
('Jennifer Jones',)
*/