-- Schema DDL
CREATE TABLE "perpetrator" ("Perpetrator_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Date" TEXT, "Year" REAL, "Location" TEXT, "Country" TEXT, "Killed" INTEGER, "Injured" INTEGER, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Home Town" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "name", "height", "weight", "home town") VALUES (1101, 'Adam Jones', 1104.5, 1107.5, 'North Kyle');
INSERT INTO "people" ("people_id", "name", "height", "weight", "home town") VALUES (1102, 'Stephanie Gardner', 1111.5, 1116.5, 'West Jasonbury');
INSERT INTO "people" ("people_id", "name", "height", "weight", "home town") VALUES (1103, 'Lauren Hernandez', 1118.5, 1125.5, 'West Kimberlychester');
INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (1110, 1101, 'pressure', 1113.5, 'PSC 3226, Box 0256
APO AP 96846', 'Mozambique', NULL, 1119);
INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (1111, 1101, 'so', 1122.5, '16073 Lisa Mount Suite 433
Lake Jamesmouth, KY 09600', 'Argentina', NULL, 1136.0);
INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (1112, 1101, 'clear', 1131.5, 'Unit 4586 Box 8501
DPO AA 23906', 'Botswana', NULL, 1153.0);
INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (1122, 1101, 'pick', 1125.5, '9816 Jonathan Station Suite 088
West Ryan, TN 43780', 'Mexico', NULL, 1131);
INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (1123, 1101, 'leader', 1134.5, '484 Nguyen Square
Angelaborough, MT 87654', 'Syrian Arab Republic', NULL, 1148.0);
INSERT INTO "perpetrator" ("perpetrator_id", "people_id", "date", "year", "location", "country", "killed", "injured") VALUES (1124, 1101, 'hair', 1143.5, 'USNS Gilbert
FPO AA 53726', 'Afghanistan', NULL, 1165.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT LOCATION FROM (SELECT LHS.perpetrator_id AS perpetrator_id, LHS.people_id AS people_id, LHS.date AS date, LHS.year AS YEAR, LHS.location AS LOCATION, LHS.country AS country, LHS.killed AS killed, LHS.injured AS injured, LHS.maxkilled AS maxkilled, RHS.perpetrator_id AS perpetrator_id_other, RHS.people_id AS people_id_other, RHS.date AS date_other, RHS.year AS year_other, RHS.location AS location_other, RHS.country AS country_other, RHS.killed AS killed_other, RHS.injured AS injured_other, RHS.maxkilled AS maxkilled_other FROM (SELECT perpetrator_id, people_id, date, YEAR, LOCATION, country, killed, injured, MAX(killed) OVER () AS maxkilled FROM perpetrator) AS LHS CROSS JOIN (SELECT perpetrator_id, people_id, date, YEAR, LOCATION, country, killed, injured, MAX(killed) OVER () AS maxkilled FROM perpetrator) AS RHS) WHERE (killed >= maxkilled_other OR maxkilled <> maxkilled_other) ORDER BY LOCATION;

/*
Gold Result:
*/

-- Prediction Query
SELECT LOCATION FROM perpetrator ORDER BY Killed DESC, perpetrator.perpetrator_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('PSC 3226, Box 0256\nAPO AP 96846',)
*/