-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "swimmer" ("id", "name", "nationality", "meter_100", "meter_200", "meter_300", "meter_400", "meter_500", "meter_600", "meter_700", "time") VALUES (9, '16', '16', 16, '16', '16', '16', '16', '16', '16', '16');
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (11, '14', 15, '16', '17', -635);
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (10, '16', 16, '16', '16', NULL);
INSERT INTO "event" ("id", "stadium_id", "name", "year") VALUES (12, 10, '16', '16');
INSERT INTO "record" ("swimmer_id", "event_id", "id", "result") VALUES (9, 12, 16, '16');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS count_distinct_city_ FROM stadium WHERE (opening_year < 2006) ORDER BY count_distinct_city_;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT city) FROM stadium WHERE opening_year < 2006;

/*
Prediction Result:
(1,)
*/