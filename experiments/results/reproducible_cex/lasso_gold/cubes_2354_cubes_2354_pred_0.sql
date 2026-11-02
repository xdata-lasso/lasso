-- Schema DDL
CREATE TABLE "county_public_safety" ("County_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Police_officers" INTEGER, "Residents_per_officer" INTEGER, "Case_burden" INTEGER, "Crime_rate" REAL, "Police_force" TEXT, "Location" TEXT);

CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "County_ID" INTEGER, "Name" TEXT, "White" REAL, "Black" REAL, "Amerindian" REAL, "Asian" REAL, "Multiracial" REAL, "Hispanic" REAL, FOREIGN KEY ("County_ID") REFERENCES "county_public_safety" ("County_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (1032, 'Leah Smith', 1060, 1064, 1068, 1072, 1076.5, 'message', '6311 Gomez Loop
Shieldston, TX 86150');
INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (1033, 'Rebecca Henderson', 1043.0, 1049.0, 1055.0, 1061.0, 1067.5, 'clear', '809 Burns Creek
Natashaport, IA 08093');
INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (1034, 'James Ferrell', 1050.0, 1058.0, 1066.0, 1074.0, 1082.5, 'clear', '71822 Arroyo Expressway
Allisonchester, IL 71187');
INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (1035, 'Tricia Valencia', 1057.0, 1067.0, 1077.0, 1087.0, 1097.5, 'clear', '465 Lam Mission
East Jeffreymouth, AK 77611');
INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (1056, 'Anthony Rodriguez', 1036, 1040, 1044, 1048, 1052.5, 'message', '514 Moore Alley Suite 828
Port Colleenhaven, PA 26572');
INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (1057, 'Amy Jones', 1067.0, 1073.0, 1079.0, 1085.0, 1091.5, 'clear', 'Unit 1065 Box 1333
DPO AP 59301');
INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (1058, 'Gary Palmer', 1074.0, 1082.0, 1090.0, 1098.0, 1106.5, 'clear', '7317 Brent Plains
North Sarabury, GA 53770');
INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (1059, 'John Ryan', 1081.0, 1091.0, 1101.0, 1111.0, 1121.5, 'clear', '0260 Baker Tunnel
Mitchellside, TN 94664');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM county_public_safety ORDER BY police_force DESC, county_public_safety.county_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Leah Smith',)
*/

-- Prediction Query
SELECT Name FROM county_public_safety ORDER BY Population DESC, county_public_safety.county_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('John Ryan',)
*/