-- Schema DDL
CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER PRIMARY KEY, "Order_Year" INTEGER, "Manufacturer" TEXT, "Model" TEXT, "Fleet_Series" TEXT, "Powertrain" TEXT, "Fuel_Propulsion" TEXT);

CREATE TABLE "pilot" ("Pilot_ID" INTEGER PRIMARY KEY, "Pilot_name" TEXT, "Rank" INTEGER, "Age" INTEGER, "Nationality" TEXT, "Position" TEXT, "Join_Year" INTEGER, "Team" TEXT);

CREATE TABLE "pilot_record" ("Pilot_ID" INTEGER, "Aircraft_ID" INTEGER, "Date" TEXT, "Record_ID" INTEGER, PRIMARY KEY ("Pilot_ID", "Aircraft_ID", "Date"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Pilot_ID") REFERENCES "pilot" ("Pilot_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: pilot --
INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (1, 'pil_85e37f', 1, 1, 'pil_a6374d', 'pil_099507', 1, 'pil_d75c9f');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483647, 'pil_7f4df2', 1, 1, 'pil_ade1ad', 'pil_e85be7', 1, 'pil_68bcba');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-1, '5k5swwqcgs', 247012447, 7719, '8c4pgu7vfe', 'hria2ypu', 1644814318, 'sr');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (0, 'wbbp6luhvdlt', -841692980, 0, 'bnp', 'mdpos', -1576219117, '5u');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483644, 'w6kl', 1620389964, 546571701, '0t5c4ecigc', 'e376nium52', 1, 'zbuo4nrqrof');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483643, 'qyp5s5bbp0', 743312762, -1822992503, 'liqa1', 'ryytoo3', 1, '9hl7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT join_year FROM (SELECT * FROM (SELECT * FROM pilot ORDER BY age DESC, pilot.pilot_id NULLS LAST) LIMIT 1);

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT Join_Year FROM pilot ORDER BY Rank ASC, pilot.pilot_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(-1576219117,)
*/