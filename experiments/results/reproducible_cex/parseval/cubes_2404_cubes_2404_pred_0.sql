-- Schema DDL
CREATE TABLE "swimmer" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Nationality" TEXT, "meter_100" REAL, "meter_200" TEXT, "meter_300" TEXT, "meter_400" TEXT, "meter_500" TEXT, "meter_600" TEXT, "meter_700" TEXT, "Time" TEXT);

CREATE TABLE "stadium" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "Capacity" INTEGER, "City" TEXT, "Country" TEXT, "Opening_year" INTEGER);

CREATE TABLE "event" ("ID" INTEGER PRIMARY KEY, "Stadium_ID" INTEGER, "Name" TEXT, "Year" TEXT, FOREIGN KEY ("Stadium_ID") REFERENCES "stadium" ("ID"));

CREATE TABLE "record" ("Swimmer_ID" INTEGER, "Event_ID" INTEGER, "ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Swimmer_ID", "Event_ID"), FOREIGN KEY ("Swimmer_ID") REFERENCES "swimmer" ("ID"), FOREIGN KEY ("Event_ID") REFERENCES "event" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: stadium --
INSERT INTO "stadium" ("id", "name", "capacity", "city", "country", "opening_year") VALUES (1, '5k5swwqcgs', 247012447, '8c4pgu7vfe', 'hria2ypu', 1644814318);

-- Inserting into table: event --
INSERT INTO "event" ("id", "stadium_id", "name", "year") VALUES (1, 1, 'eve_e9b69b', 'eve_3e8043');

INSERT INTO "event" ("id", "stadium_id", "name", "year") VALUES (-2147483647, 1, 'eve_8e73f5', 'eve_00f13a');

INSERT INTO "event" ("id", "stadium_id", "name", "year") VALUES (-2147483646, 1, 'q_1_81c6cd', 'rwbbp');

INSERT INTO "event" ("id", "stadium_id", "name", "year") VALUES (-2147483645, 1, 'q_1_81c6cd', 'hvdltt');

INSERT INTO "event" ("id", "stadium_id", "name", "year") VALUES (2, 1, 'bnp', 'mdpos');

INSERT INTO "event" ("id", "stadium_id", "name", "year") VALUES (-2147483648, 1, 'e5u', 'w6kl');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM event ORDER BY id DESC) LIMIT 1);

/*
Gold Result:
('bnp',)
*/

-- Prediction Query
SELECT name FROM event ORDER BY YEAR DESC, event.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('e5u',)
*/