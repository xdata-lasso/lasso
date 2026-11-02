-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: stadium --
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (1, 'sta_b2f520', 1, 'sta_a00455', 'sta_e06599', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483647, 'sta_6920a3', 1, 'sta_9690b3', 'sta_2f59e2', 1);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483646, 'q_1_a9969b', -55602865, 'swwqcgsk', '9n8c4pgu7v', -1865039888);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-2147483645, 'q_1_a9969b', 1160656988, 'ia2yp', 'uzhsrwbbp6lu', 1019800248);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (-1, 'dlttil', 429706943, 'rmdp', 'siie', -7719);

INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (0, 'unw6klfa', 1419861592, '4ecigce376n', 'um5', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM stadium ORDER BY opening_year, stadium.id NULLS LAST) LIMIT 1);

/*
Gold Result:
('q_1_a9969b',)
*/

-- Prediction Query
SELECT name FROM stadium ORDER BY capacity DESC, stadium.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('unw6klfa',)
*/