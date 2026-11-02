-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: country --
INSERT INTO "country" ("country_id", "name", "population", "area", "languages") VALUES (-2147483648, '5k5swwqcgs', 247012447, -1980249628, 'gu7v');

-- Inserting into table: roller_coaster --
INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (1, -2147483648, 'e4', 'hria2ypuzhs', 663.049759, 100.0, 'wbbp6luhvdlt', 'ilbnp', 'rol_e99b65');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (2, -2147483648, 'dpos', 'ie5', 327.753528, 100.0, 'w6kl', 'a9', 'rol_e99b65');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (3, -2147483648, '00t5c4ecigc', 'e376nium52', 816.814398, 100.0, 'buo4nrq', 'rofqyp5s5b', 'rol_e99b65');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (4, -2147483648, 'eutliqa11r', 'ytoo3o9', 111.926013, 99.99, '72klex14ji7z', 'au2dwy', 'q13py');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (5, -2147483648, '5sw', 'qcgsk9', 206.939346, 3300.01, '8c4pgu7vfe', 'hria2ypu', 'hsrwbbp');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT status FROM roller_coaster WHERE (height <= 3300.0 AND height >= 100.0) ORDER BY status, roller_coaster.roller_coaster_id NULLS LAST;

/*
Gold Result:
('rol_e99b65',)
('rol_e99b65',)
('rol_e99b65',)
*/

-- Prediction Query
SELECT Status FROM roller_coaster WHERE LENGTH > 3300 OR Height > 100;

/*
Prediction Result:
('hsrwbbp',)
*/