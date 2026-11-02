-- Schema DDL
CREATE TABLE "pilot" ("Pilot_Id" INTEGER(11) PRIMARY KEY, "Name" TEXT(50), "Age" INTEGER(11));

CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER(11) PRIMARY KEY, "Aircraft" TEXT(50), "Description" TEXT(50), "Max_Gross_Weight" TEXT(50), "Total_disk_area" TEXT(50), "Max_disk_Loading" TEXT(50));

CREATE TABLE "match" ("Round" REAL PRIMARY KEY, "Winning_Pilot" TEXT, "Winning_Aircraft" TEXT, "Location" TEXT, "Country" TEXT, "Date" TEXT, "Fastest_Qualifying" TEXT, FOREIGN KEY ("Winning_Pilot") REFERENCES "pilot" ("Pilot_Id"), FOREIGN KEY ("Winning_Aircraft") REFERENCES "aircraft" ("Aircraft_ID"));

CREATE TABLE "airport" ("Airport_ID" INTEGER PRIMARY KEY, "Airport_Name" TEXT, "Total_Passengers" REAL, "%_Change_2007" TEXT, "International_Passengers" REAL, "Domestic_Passengers" REAL, "Transit_Passengers" REAL, "Aircraft_Movements" REAL, "Freight_Metric_Tonnes" REAL);

CREATE TABLE "airport_aircraft" ("Airport_ID" INTEGER, "Aircraft_ID" INTEGER, "ID" INTEGER, PRIMARY KEY ("Airport_ID", "Aircraft_ID"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Airport_ID") REFERENCES "airport" ("Airport_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO aircraft (Aircraft_ID, Aircraft, Description, Max_Gross_Weight, Total_disk_area, Max_disk_Loading) VALUES (1, 'Robinson R-22', 'Light Utility Helicopter', '1,370 lb (621 kg)', '497 ft² (46.2 m²)', '2.6 lb/ft² (13 kg/m²)');
INSERT INTO aircraft (Aircraft_ID, Aircraft, Description, Max_Gross_Weight, Total_disk_area, Max_disk_Loading) VALUES (2, 'Bell 206B3 JetRanger', 'Turboshaft Utility', '3,200 lb (1,451 kg)', '872 ft² (81.1 m²)', '3.7 lb/ft² (18 kg/m²)');
INSERT INTO aircraft (Aircraft_ID, Aircraft, Description, Max_Gross_Weight, Total_disk_area, Max_disk_Loading) VALUES (3, 'CH-47D Chinook', 'Tandem Rotor Heavy Lift', '50,000 lb (22,680 kg)', '5,655 ft² (526 m²)', '8.8 lb/ft² (43 kg/m²)');
INSERT INTO aircraft (Aircraft_ID, Aircraft, Description, Max_Gross_Weight, Total_disk_area, Max_disk_Loading) VALUES (4, 'Mil Mi-26', 'Heavy Transport Helicopter', '123,500 lb (56,000 kg)', '8,495 ft² (789 m²)', '14.5 lb/ft² (71 kg/m²)');
INSERT INTO aircraft (Aircraft_ID, Aircraft, Description, Max_Gross_Weight, Total_disk_area, Max_disk_Loading) VALUES (5, 'Schweizer 300C', 'Light Utility Helicopter', '2,050 lb (930 kg)', '565 ft² (52.5 m²)', '3.6 lb/ft² (18 kg/m²)');
INSERT INTO pilot (Pilot_Id, Name, Age) VALUES (1, 'Paul Bonhomme', 45);
INSERT INTO match (Round, Winning_Pilot, Winning_Aircraft, Location, Country, Date, Fastest_Qualifying) VALUES (1.0, 1, 1, 'Abu Dhabi', 'UAE', '2008-04-11', 'Paul Bonhomme');
INSERT INTO airport (Airport_ID, Airport_Name, Total_Passengers, "%_Change_2007", International_Passengers, Domestic_Passengers, Transit_Passengers, Aircraft_Movements, Freight_Metric_Tonnes) VALUES (1, 'London Heathrow', 67054745.0, '-1.5%', 61344438.0, 5562516.0, 147791.0, 478693.0, 1397054.0);
INSERT INTO airport_aircraft (Airport_ID, Aircraft_ID, ID) VALUES (1, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT description FROM aircraft ORDER BY description, aircraft.aircraft_id NULLS LAST;

/*
Gold Result:
('Heavy Transport Helicopter',)
('Light Utility Helicopter',)
('Light Utility Helicopter',)
('Tandem Rotor Heavy Lift',)
('Turboshaft Utility',)
*/

-- Prediction Query
SELECT Description FROM aircraft;

/*
Prediction Result:
('Light Utility Helicopter',)
('Turboshaft Utility',)
('Tandem Rotor Heavy Lift',)
('Heavy Transport Helicopter',)
('Light Utility Helicopter',)
*/