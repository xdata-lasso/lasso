-- Schema DDL
CREATE TABLE "pilot" ("Pilot_Id" INTEGER(11) PRIMARY KEY, "Name" TEXT(50), "Age" INTEGER(11));

CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER(11) PRIMARY KEY, "Aircraft" TEXT(50), "Description" TEXT(50), "Max_Gross_Weight" TEXT(50), "Total_disk_area" TEXT(50), "Max_disk_Loading" TEXT(50));

CREATE TABLE "match" ("Round" REAL PRIMARY KEY, "Winning_Pilot" TEXT, "Winning_Aircraft" TEXT, "Location" TEXT, "Country" TEXT, "Date" TEXT, "Fastest_Qualifying" TEXT, FOREIGN KEY ("Winning_Pilot") REFERENCES "pilot" ("Pilot_Id"), FOREIGN KEY ("Winning_Aircraft") REFERENCES "aircraft" ("Aircraft_ID"));

CREATE TABLE "airport" ("Airport_ID" INTEGER PRIMARY KEY, "Airport_Name" TEXT, "Total_Passengers" REAL, "%_Change_2007" TEXT, "International_Passengers" REAL, "Domestic_Passengers" REAL, "Transit_Passengers" REAL, "Aircraft_Movements" REAL, "Freight_Metric_Tonnes" REAL);

CREATE TABLE "airport_aircraft" ("Airport_ID" INTEGER, "Aircraft_ID" INTEGER, "ID" INTEGER, PRIMARY KEY ("Airport_ID", "Aircraft_ID"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Airport_ID") REFERENCES "airport" ("Airport_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests ORDER BY international_passengers ASC, tie-breaking with airport_id ASC, NULL handling in ordering, and DISTINCT vs ALL mutations.
INSERT INTO "airport" ("Airport_ID", "Airport_Name", "Total_Passengers", "%_Change_2007", "International_Passengers", "Domestic_Passengers", "Transit_Passengers", "Aircraft_Movements", "Freight_Metric_Tonnes") VALUES (10, 'London Heathrow', 5000.0, '1.0%', 3000.0, 2000.0, 100.0, 50.0, 10.0);
INSERT INTO "airport" ("Airport_ID", "Airport_Name", "Total_Passengers", "%_Change_2007", "International_Passengers", "Domestic_Passengers", "Transit_Passengers", "Aircraft_Movements", "Freight_Metric_Tonnes") VALUES (5, 'London Heathrow', 2000.0, '2.0%', 1000.0, 900.0, 100.0, 20.0, 5.0);
INSERT INTO "airport" ("Airport_ID", "Airport_Name", "Total_Passengers", "%_Change_2007", "International_Passengers", "Domestic_Passengers", "Transit_Passengers", "Aircraft_Movements", "Freight_Metric_Tonnes") VALUES (20, 'London Heathrow', 3000.0, '3.0%', 1000.0, 800.0, 200.0, 30.0, 8.0);
INSERT INTO "airport" ("Airport_ID", "Airport_Name", "Total_Passengers", "%_Change_2007", "International_Passengers", "Domestic_Passengers", "Transit_Passengers", "Aircraft_Movements", "Freight_Metric_Tonnes") VALUES (15, 'London Heathrow', 4000.0, '4.0%', 3000.0, 2000.0, 100.0, 40.0, 12.0);
INSERT INTO "airport" ("Airport_ID", "Airport_Name", "Total_Passengers", "%_Change_2007", "International_Passengers", "Domestic_Passengers", "Transit_Passengers", "Aircraft_Movements", "Freight_Metric_Tonnes") VALUES (1, 'London Heathrow', 1000.0, '5.0%', NULL, 500.0, 50.0, 10.0, 2.0);
INSERT INTO "airport" ("Airport_ID", "Airport_Name", "Total_Passengers", "%_Change_2007", "International_Passengers", "Domestic_Passengers", "Transit_Passengers", "Aircraft_Movements", "Freight_Metric_Tonnes") VALUES (30, 'Manchester', 6000.0, '1.0%', 500.0, 5500.0, 0.0, 60.0, 15.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "international_passengers", "domestic_passengers" FROM "airport" WHERE ("airport_name" = 'London Heathrow') ORDER BY international_passengers, airport.airport_id NULLS LAST;

/*
Gold Result:
(None, 500.0)
(1000.0, 900.0)
(1000.0, 800.0)
(3000.0, 2000.0)
(3000.0, 2000.0)
*/

-- Prediction Query
SELECT International_Passengers, Domestic_Passengers FROM airport WHERE Airport_Name = 'London Heathrow';

/*
Prediction Result:
(None, 500.0)
(1000.0, 900.0)
(3000.0, 2000.0)
(3000.0, 2000.0)
(1000.0, 800.0)
*/