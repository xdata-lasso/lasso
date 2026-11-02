-- Schema DDL
CREATE TABLE "pilot" ("Pilot_Id" INTEGER(11) PRIMARY KEY, "Name" TEXT(50), "Age" INTEGER(11));

CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER(11) PRIMARY KEY, "Aircraft" TEXT(50), "Description" TEXT(50), "Max_Gross_Weight" TEXT(50), "Total_disk_area" TEXT(50), "Max_disk_Loading" TEXT(50));

CREATE TABLE "match" ("Round" REAL PRIMARY KEY, "Winning_Pilot" TEXT, "Winning_Aircraft" TEXT, "Location" TEXT, "Country" TEXT, "Date" TEXT, "Fastest_Qualifying" TEXT, FOREIGN KEY ("Winning_Pilot") REFERENCES "pilot" ("Pilot_Id"), FOREIGN KEY ("Winning_Aircraft") REFERENCES "aircraft" ("Aircraft_ID"));

CREATE TABLE "airport" ("Airport_ID" INTEGER PRIMARY KEY, "Airport_Name" TEXT, "Total_Passengers" REAL, "%_Change_2007" TEXT, "International_Passengers" REAL, "Domestic_Passengers" REAL, "Transit_Passengers" REAL, "Aircraft_Movements" REAL, "Freight_Metric_Tonnes" REAL);

CREATE TABLE "airport_aircraft" ("Airport_ID" INTEGER, "Aircraft_ID" INTEGER, "ID" INTEGER, PRIMARY KEY ("Airport_ID", "Aircraft_ID"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Airport_ID") REFERENCES "airport" ("Airport_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "aircraft" ("Aircraft_ID", "Aircraft", "Description", "Max_Gross_Weight", "Total_disk_area", "Max_disk_Loading") VALUES (3, 'Robinson R-22', 'Light utility helicopter', '1,370 lb', '497 ft²', '2.6 lb/ft²');
INSERT INTO "aircraft" ("Aircraft_ID", "Aircraft", "Description", "Max_Gross_Weight", "Total_disk_area", "Max_disk_Loading") VALUES (1, 'Bell 206B3', 'Turboshaft utility', '3,200 lb', '872 ft²', '3.7 lb/ft²');
INSERT INTO "aircraft" ("Aircraft_ID", "Aircraft", "Description", "Max_Gross_Weight", "Total_disk_area", "Max_disk_Loading") VALUES (2, 'CH-47D Chinook', 'Tandem rotor heavy-lift', '50,000 lb', '5,655 ft²', '8.8 lb/ft²');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT description FROM aircraft ORDER BY description, aircraft.aircraft_id NULLS LAST;

/*
Gold Result:
('Light utility helicopter',)
('Tandem rotor heavy-lift',)
('Turboshaft utility',)
*/

-- Prediction Query
SELECT Description FROM aircraft;

/*
Prediction Result:
('Light utility helicopter',)
('Turboshaft utility',)
('Tandem rotor heavy-lift',)
*/