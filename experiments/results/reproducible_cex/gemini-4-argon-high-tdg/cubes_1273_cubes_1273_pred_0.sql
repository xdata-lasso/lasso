-- Schema DDL
CREATE TABLE "pilot" ("Pilot_Id" INTEGER(11) PRIMARY KEY, "Name" TEXT(50), "Age" INTEGER(11));

CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER(11) PRIMARY KEY, "Aircraft" TEXT(50), "Description" TEXT(50), "Max_Gross_Weight" TEXT(50), "Total_disk_area" TEXT(50), "Max_disk_Loading" TEXT(50));

CREATE TABLE "match" ("Round" REAL PRIMARY KEY, "Winning_Pilot" TEXT, "Winning_Aircraft" TEXT, "Location" TEXT, "Country" TEXT, "Date" TEXT, "Fastest_Qualifying" TEXT, FOREIGN KEY ("Winning_Pilot") REFERENCES "pilot" ("Pilot_Id"), FOREIGN KEY ("Winning_Aircraft") REFERENCES "aircraft" ("Aircraft_ID"));

CREATE TABLE "airport" ("Airport_ID" INTEGER PRIMARY KEY, "Airport_Name" TEXT, "Total_Passengers" REAL, "%_Change_2007" TEXT, "International_Passengers" REAL, "Domestic_Passengers" REAL, "Transit_Passengers" REAL, "Aircraft_Movements" REAL, "Freight_Metric_Tonnes" REAL);

CREATE TABLE "airport_aircraft" ("Airport_ID" INTEGER, "Aircraft_ID" INTEGER, "ID" INTEGER, PRIMARY KEY ("Airport_ID", "Aircraft_ID"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Airport_ID") REFERENCES "airport" ("Airport_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "aircraft" ("Aircraft_ID", "Aircraft", "Description", "Max_Gross_Weight", "Total_disk_area", "Max_disk_Loading") VALUES (101, 'Airbus A380', 'Double-deck', '575000', '845', '680');
INSERT INTO "aircraft" ("Aircraft_ID", "Aircraft", "Description", "Max_Gross_Weight", "Total_disk_area", "Max_disk_Loading") VALUES (102, 'Boeing 777', 'Twin-engine', '350000', '427', '820');
INSERT INTO "airport" ("Airport_ID", "Airport_Name", "Total_Passengers", "%_Change_2007", "International_Passengers", "Domestic_Passengers", "Transit_Passengers", "Aircraft_Movements", "Freight_Metric_Tonnes") VALUES (10, 'London Heathrow', 600.0, '1%', 500.0, 100.0, 10.0, 50.0, 5.0);
INSERT INTO "airport" ("Airport_ID", "Airport_Name", "Total_Passengers", "%_Change_2007", "International_Passengers", "Domestic_Passengers", "Transit_Passengers", "Aircraft_Movements", "Freight_Metric_Tonnes") VALUES (20, 'London Heathrow', 600.0, '2%', 200.0, 400.0, 20.0, 60.0, 6.0);
INSERT INTO "airport" ("Airport_ID", "Airport_Name", "Total_Passengers", "%_Change_2007", "International_Passengers", "Domestic_Passengers", "Transit_Passengers", "Aircraft_Movements", "Freight_Metric_Tonnes") VALUES (30, 'London Heathrow', 650.0, '3%', 200.0, 400.0, 50.0, 70.0, 7.0);
INSERT INTO "airport" ("Airport_ID", "Airport_Name", "Total_Passengers", "%_Change_2007", "International_Passengers", "Domestic_Passengers", "Transit_Passengers", "Aircraft_Movements", "Freight_Metric_Tonnes") VALUES (15, 'London Heathrow', 450.0, '4%', 300.0, 150.0, 15.0, 45.0, 4.5);
INSERT INTO "airport" ("Airport_ID", "Airport_Name", "Total_Passengers", "%_Change_2007", "International_Passengers", "Domestic_Passengers", "Transit_Passengers", "Aircraft_Movements", "Freight_Metric_Tonnes") VALUES (5, 'London Heathrow', 550.0, '5%', 300.0, 250.0, 25.0, 55.0, 5.5);
INSERT INTO "airport" ("Airport_ID", "Airport_Name", "Total_Passengers", "%_Change_2007", "International_Passengers", "Domestic_Passengers", "Transit_Passengers", "Aircraft_Movements", "Freight_Metric_Tonnes") VALUES (25, 'London Stansted', 400.0, '6%', 300.0, 100.0, 5.0, 35.0, 3.5);
INSERT INTO "airport_aircraft" ("Airport_ID", "Aircraft_ID", "ID") VALUES (10, 101, 1);
INSERT INTO "airport_aircraft" ("Airport_ID", "Aircraft_ID", "ID") VALUES (10, 102, 2);
INSERT INTO "airport_aircraft" ("Airport_ID", "Aircraft_ID", "ID") VALUES (20, 101, 3);
INSERT INTO "airport_aircraft" ("Airport_ID", "Aircraft_ID", "ID") VALUES (30, 101, 4);
INSERT INTO "airport_aircraft" ("Airport_ID", "Aircraft_ID", "ID") VALUES (15, 101, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "international_passengers", "domestic_passengers" FROM "airport" WHERE ("airport_name" = 'London Heathrow') ORDER BY international_passengers, airport.airport_id NULLS LAST;

/*
Gold Result:
(200.0, 400.0)
(200.0, 400.0)
(300.0, 250.0)
(300.0, 150.0)
(500.0, 100.0)
*/

-- Prediction Query
SELECT International_Passengers, Domestic_Passengers FROM airport WHERE Airport_Name = 'London Heathrow';

/*
Prediction Result:
(300.0, 250.0)
(500.0, 100.0)
(300.0, 150.0)
(200.0, 400.0)
(200.0, 400.0)
*/