-- Schema DDL
CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER PRIMARY KEY, "Order_Year" INTEGER, "Manufacturer" TEXT, "Model" TEXT, "Fleet_Series" TEXT, "Powertrain" TEXT, "Fuel_Propulsion" TEXT);

CREATE TABLE "pilot" ("Pilot_ID" INTEGER PRIMARY KEY, "Pilot_name" TEXT, "Rank" INTEGER, "Age" INTEGER, "Nationality" TEXT, "Position" TEXT, "Join_Year" INTEGER, "Team" TEXT);

CREATE TABLE "pilot_record" ("Pilot_ID" INTEGER, "Aircraft_ID" INTEGER, "Date" TEXT, "Record_ID" INTEGER, PRIMARY KEY ("Pilot_ID", "Aircraft_ID", "Date"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Pilot_ID") REFERENCES "pilot" ("Pilot_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: pilot --
INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (1, '5k5swwqcgs', 247012447, -1980249628, 'gu7v', 'pil_a400fb', 1999, 'e4');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483647, 'hria2ypuzhs', 700293388, 906324270, 'b', 'pil_a400fb', 1999, 'p6luhvdlttil');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (2, '5k5swwqcgs', 247012447, -1980249628, 'gu7v', 'e4', 2000, 'hria2ypuzhs');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (3, 'rwbbp6luhvd', -1377057208, -841692980, 'bnp', 'mdpos', 2005, 'ie5');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (4, 'nw6klf', 1038707349, 1419861592, '4ecigce376n', 'um5', NULL, 'zbuo4nrq');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (5, 'rofqyp5s5b', 2107872094, 882961052, '2eutliqa11r', 'ytoo3o9', NULL, 'l7');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (6, 'klex14ji', -453362185, 481163439, '2dwyrq', '3pyu78d', NULL, '9rljsl0b4');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (7, 'p5qi2rk', -705985602, 537874887, 'z0f8jegd21vy', '9uxj4hwbdvl', NULL, 'h2gn');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (8, 'q', -664193365, -1070063173, 'x5hncprjtu0', 'z', NULL, '9fjgq8n2f');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT POSITION FROM pilot WHERE (join_year < 2000 AND join_year < 2005) ORDER BY POSITION, pilot.pilot_id NULLS LAST;

/*
Gold Result:
('pil_a400fb',)
('pil_a400fb',)
*/

-- Prediction Query
SELECT POSITION FROM pilot WHERE Join_Year < 2000 INTERSECT SELECT POSITION FROM pilot WHERE Join_Year > 2005;

/*
Prediction Result:
*/