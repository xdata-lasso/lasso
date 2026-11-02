-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: country --
INSERT INTO "country" ("country_id", "name", "population", "area", "languages") VALUES (1, '5k5swwqcgs', 247012447, -1980249628, 'gu7v');

-- Inserting into table: roller_coaster --
INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (1, 1, 'rol_14198b', 'rol_676e6f', 1.0, 1.0, 'rol_d86724', 'rol_c494f7', 'rol_816215');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483647, 1, 'rol_ff1dd3', 'rol_c6f343', 1.0, 1.0, 'rol_377370', 'rol_84c5af', 'rol_4178cb');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (2, 1, '4h', 'ia2yp', 718.397869, 324.940703, 'hsrwbbp', 'luhvdltti', 'bnp');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (3, 1, 'mdpos', 'ie5', 327.753528, 218.301157, 'klfa9000t', 'c4ecigce', '76nium52');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483644, 1, 'u', '4nrq', 597.420508, 220.906948, 'q_1_7b8b2c', 'qy', '5s5b');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (-2147483643, 1, '02eu', 'liqa1', 982.938576, 274.580687, 'q_1_7b8b2c', 'ytoo3o9', 'l7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT speed FROM (SELECT * FROM (SELECT * FROM roller_coaster ORDER BY country_id DESC, roller_coaster.roller_coaster_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('rol_377370',)
*/

-- Prediction Query
SELECT Speed FROM roller_coaster ORDER BY LENGTH DESC, roller_coaster.roller_coaster_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('q_1_7b8b2c',)
*/