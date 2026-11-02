-- Schema DDL
CREATE TABLE "pilot" ("Pilot_Id" INTEGER(11) PRIMARY KEY, "Name" TEXT(50), "Age" INTEGER(11));

CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER(11) PRIMARY KEY, "Aircraft" TEXT(50), "Description" TEXT(50), "Max_Gross_Weight" TEXT(50), "Total_disk_area" TEXT(50), "Max_disk_Loading" TEXT(50));

CREATE TABLE "match" ("Round" REAL PRIMARY KEY, "Winning_Pilot" TEXT, "Winning_Aircraft" TEXT, "Location" TEXT, "Country" TEXT, "Date" TEXT, "Fastest_Qualifying" TEXT, FOREIGN KEY ("Winning_Pilot") REFERENCES "pilot" ("Pilot_Id"), FOREIGN KEY ("Winning_Aircraft") REFERENCES "aircraft" ("Aircraft_ID"));

CREATE TABLE "airport" ("Airport_ID" INTEGER PRIMARY KEY, "Airport_Name" TEXT, "Total_Passengers" REAL, "%_Change_2007" TEXT, "International_Passengers" REAL, "Domestic_Passengers" REAL, "Transit_Passengers" REAL, "Aircraft_Movements" REAL, "Freight_Metric_Tonnes" REAL);

CREATE TABLE "airport_aircraft" ("Airport_ID" INTEGER, "Aircraft_ID" INTEGER, "ID" INTEGER, PRIMARY KEY ("Airport_ID", "Aircraft_ID"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Airport_ID") REFERENCES "airport" ("Airport_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (ASC vs DESC), duplicates (SELECT vs SELECT DISTINCT), and anti-correlated PKs vs Description
INSERT INTO "aircraft" ("Aircraft_ID", "Aircraft", "Description", "Max_Gross_Weight", "Total_disk_area", "Max_disk_Loading") VALUES (1, 'Boeing 747', 'Z-Type Heavy', '800000', '100', '8000');
INSERT INTO "aircraft" ("Aircraft_ID", "Aircraft", "Description", "Max_Gross_Weight", "Total_disk_area", "Max_disk_Loading") VALUES (2, 'Airbus A320', 'M-Type Medium', '170000', '50', '3400');
INSERT INTO "aircraft" ("Aircraft_ID", "Aircraft", "Description", "Max_Gross_Weight", "Total_disk_area", "Max_disk_Loading") VALUES (3, 'Cessna 172', 'A-Type Light', '2450', '10', '245');
INSERT INTO "aircraft" ("Aircraft_ID", "Aircraft", "Description", "Max_Gross_Weight", "Total_disk_area", "Max_disk_Loading") VALUES (4, 'Piper PA-28', 'A-Type Light', '2550', '11', '231');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT description FROM aircraft ORDER BY description, aircraft.aircraft_id NULLS LAST;

/*
Gold Result:
('A-Type Light',)
('A-Type Light',)
('M-Type Medium',)
('Z-Type Heavy',)
*/

-- Prediction Query
SELECT Description FROM aircraft;

/*
Prediction Result:
('Z-Type Heavy',)
('M-Type Medium',)
('A-Type Light',)
('A-Type Light',)
*/