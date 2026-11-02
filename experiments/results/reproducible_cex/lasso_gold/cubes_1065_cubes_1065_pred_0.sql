-- Schema DDL
CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER PRIMARY KEY, "Order_Year" INTEGER, "Manufacturer" TEXT, "Model" TEXT, "Fleet_Series" TEXT, "Powertrain" TEXT, "Fuel_Propulsion" TEXT);

CREATE TABLE "pilot" ("Pilot_ID" INTEGER PRIMARY KEY, "Pilot_name" TEXT, "Rank" INTEGER, "Age" INTEGER, "Nationality" TEXT, "Position" TEXT, "Join_Year" INTEGER, "Team" TEXT);

CREATE TABLE "pilot_record" ("Pilot_ID" INTEGER, "Aircraft_ID" INTEGER, "Date" TEXT, "Record_ID" INTEGER, PRIMARY KEY ("Pilot_ID", "Aircraft_ID", "Date"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Pilot_ID") REFERENCES "pilot" ("Pilot_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (1001, 'Allison Hill', 1005, 1009, 'Anguilla', 'rate', 1013, 'discussion');
INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (1002, 'Noah Rhodes', 1012.0, 1018.0, 'Monaco', 'science', 1028.0, 'list');
INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (1003, 'Angie Henderson', 1019.0, 1027.0, 'Congo', 'offer', 1043.0, 'perform');
INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (1004, 'Daniel Wagner', 1026.0, 1036.0, 'Saint Barthelemy', 'kind', 1058.0, 'fall');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT join_year FROM (SELECT * FROM (SELECT * FROM pilot ORDER BY age DESC, pilot.pilot_id NULLS LAST) LIMIT 1);

/*
Gold Result:
(1058,)
*/

-- Prediction Query
SELECT Join_Year FROM pilot ORDER BY Rank ASC, pilot.pilot_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1013,)
*/