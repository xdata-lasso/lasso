-- Schema DDL
CREATE TABLE "pilot" ("Pilot_Id" INTEGER(11) PRIMARY KEY, "Name" TEXT(50), "Age" INTEGER(11));

CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER(11) PRIMARY KEY, "Aircraft" TEXT(50), "Description" TEXT(50), "Max_Gross_Weight" TEXT(50), "Total_disk_area" TEXT(50), "Max_disk_Loading" TEXT(50));

CREATE TABLE "match" ("Round" REAL PRIMARY KEY, "Winning_Pilot" TEXT, "Winning_Aircraft" TEXT, "Location" TEXT, "Country" TEXT, "Date" TEXT, "Fastest_Qualifying" TEXT, FOREIGN KEY ("Winning_Pilot") REFERENCES "pilot" ("Pilot_Id"), FOREIGN KEY ("Winning_Aircraft") REFERENCES "aircraft" ("Aircraft_ID"));

CREATE TABLE "airport" ("Airport_ID" INTEGER PRIMARY KEY, "Airport_Name" TEXT, "Total_Passengers" REAL, "%_Change_2007" TEXT, "International_Passengers" REAL, "Domestic_Passengers" REAL, "Transit_Passengers" REAL, "Aircraft_Movements" REAL, "Freight_Metric_Tonnes" REAL);

CREATE TABLE "airport_aircraft" ("Airport_ID" INTEGER, "Aircraft_ID" INTEGER, "ID" INTEGER, PRIMARY KEY ("Airport_ID", "Aircraft_ID"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Airport_ID") REFERENCES "airport" ("Airport_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO pilot (Pilot_Id, Name, Age) VALUES (3, 'Charlie', 25);
INSERT INTO pilot (Pilot_Id, Name, Age) VALUES (1, 'Delta', 45);
INSERT INTO pilot (Pilot_Id, Name, Age) VALUES (5, 'Alpha', 30);
INSERT INTO pilot (Pilot_Id, Name, Age) VALUES (2, 'Bravo', 19);
INSERT INTO pilot (Pilot_Id, Name, Age) VALUES (4, 'Alpha', 60);
INSERT INTO aircraft (Aircraft_ID, Aircraft, Description, Max_Gross_Weight, Total_disk_area, Max_disk_Loading) VALUES (101, 'Edge 540', 'Aerobatic', '816 kg', '10 m2', '81 kg/m2');
INSERT INTO aircraft (Aircraft_ID, Aircraft, Description, Max_Gross_Weight, Total_disk_area, Max_disk_Loading) VALUES (102, 'MXS-R', 'Carbon', '800 kg', '9 m2', '88 kg/m2');
INSERT INTO match (Round, Winning_Pilot, Winning_Aircraft, Location, Country, Date, Fastest_Qualifying) VALUES (1.0, 3, 101, 'Abu Dhabi', 'UAE', '2020-03-01', 'Charlie');
INSERT INTO match (Round, Winning_Pilot, Winning_Aircraft, Location, Country, Date, Fastest_Qualifying) VALUES (2.0, 3, 101, 'Kazan', 'Russia', '2020-06-15', 'Alpha');
INSERT INTO match (Round, Winning_Pilot, Winning_Aircraft, Location, Country, Date, Fastest_Qualifying) VALUES (3.0, 5, 102, 'Budapest', 'Hungary', '2020-07-20', 'Bravo');
INSERT INTO airport (Airport_ID, Airport_Name, Total_Passengers, "%_Change_2007", International_Passengers, Domestic_Passengers, Transit_Passengers, Aircraft_Movements, Freight_Metric_Tonnes) VALUES (10, 'Heathrow', 67000000.0, '1.5%', 60000000.0, 5000000.0, 2000000.0, 470000.0, 1300000.0);
INSERT INTO airport_aircraft (Airport_ID, Aircraft_ID, ID) VALUES (10, 101, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM pilot ORDER BY name, pilot.pilot_id NULLS LAST;

/*
Gold Result:
('Alpha',)
('Alpha',)
('Bravo',)
('Charlie',)
('Delta',)
*/

-- Prediction Query
SELECT Name FROM pilot ORDER BY Age DESC, pilot.pilot_id NULLS LAST;

/*
Prediction Result:
('Alpha',)
('Delta',)
('Alpha',)
('Charlie',)
('Bravo',)
*/