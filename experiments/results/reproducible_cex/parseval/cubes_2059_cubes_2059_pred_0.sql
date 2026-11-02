-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: country --
INSERT INTO "country" ("country_id", "name", "population", "area", "languages") VALUES (-2147483648, '5k5swwqcgs', 247012447, -1980249628, 'gu7v');

-- Inserting into table: roller_coaster --
INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (2, -2147483648, 'e4', 'hria2ypuzhs', 663.049759, 711.020062, 'b', 'p6luhvdlttil', 'rol_a478e9');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (3, -2147483648, 'nprmdposii', '5u', 933.422701, 345.718563, 'klfa9000t', 'c4ecigce', 'rol_a478e9');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (4, -2147483648, '5sw', 'qcgsk9', 206.939346, 604.777832, '4', 'gu7v', 'e4');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (5, -2147483648, 'ia2yp', 'uzhsrwbbp6lu', 737.440743, 334.878198, 'l', 'tilbn', 'rmdp');

INSERT INTO "roller_coaster" ("roller_coaster_id", "country_id", "name", "park", "length", "height", "speed", "opened", "status") VALUES (6, -2147483648, 'siie5unw6k', 'fa9', 877.276439, 627.258639, '0t5c4ecigc', 'e376nium52', 'zbuo4nrqrof');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT status, COUNT(*) OVER () AS count___ FROM roller_coaster ORDER BY status, count___ NULLS LAST;

/*
Gold Result:
('e4', 5)
('rmdp', 5)
('rol_a478e9', 5)
('zbuo4nrqrof', 5)
*/

-- Prediction Query
SELECT Status, COUNT(*) FROM roller_coaster GROUP BY Status;

/*
Prediction Result:
('e4', 1)
('rmdp', 1)
('rol_a478e9', 2)
('zbuo4nrqrof', 1)
*/