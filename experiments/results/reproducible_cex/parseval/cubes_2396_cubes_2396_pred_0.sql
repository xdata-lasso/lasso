-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: stadium --
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (2, '5k5swwqcgs', 50000, '9n8', 'sta_d954c7', 1610062532);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (3, 'pgu7vfe4', 50000, 'hria2ypuzhs', 'sta_d954c7', 700293388);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (4, 'wbbp6luhvdlt', 50001, 'ilbnp', 'mdpos', -1576219117);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (5, '5k5swwqcgs', 60000, '9n8', '4', -734455130);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (6, '5k5swwqcgs', NULL, '9n8', '4', -734455130);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (7, '4h', NULL, 'ia2yp', 'uzhsrwbbp6lu', 1019800248);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (8, 'dlttil', NULL, 'n', 'rmdp', 2026480202);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (9, 'ie5', NULL, 'nw6klf', 'a9000t5c4eci', 1149850321);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT country FROM stadium WHERE (capacity < 60000 AND capacity <= 50000) ORDER BY country;

/*
Gold Result:
('sta_d954c7',)
*/

-- Prediction Query
SELECT country FROM stadium WHERE capacity > 60000 INTERSECT SELECT country FROM stadium WHERE capacity < 50000;

/*
Prediction Result:
*/