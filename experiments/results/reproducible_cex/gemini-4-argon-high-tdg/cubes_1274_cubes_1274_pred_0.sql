-- Schema DDL
CREATE TABLE "pilot" ("Pilot_Id" INTEGER(11) PRIMARY KEY, "Name" TEXT(50), "Age" INTEGER(11));

CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER(11) PRIMARY KEY, "Aircraft" TEXT(50), "Description" TEXT(50), "Max_Gross_Weight" TEXT(50), "Total_disk_area" TEXT(50), "Max_disk_Loading" TEXT(50));

CREATE TABLE "match" ("Round" REAL PRIMARY KEY, "Winning_Pilot" TEXT, "Winning_Aircraft" TEXT, "Location" TEXT, "Country" TEXT, "Date" TEXT, "Fastest_Qualifying" TEXT, FOREIGN KEY ("Winning_Pilot") REFERENCES "pilot" ("Pilot_Id"), FOREIGN KEY ("Winning_Aircraft") REFERENCES "aircraft" ("Aircraft_ID"));

CREATE TABLE "airport" ("Airport_ID" INTEGER PRIMARY KEY, "Airport_Name" TEXT, "Total_Passengers" REAL, "%_Change_2007" TEXT, "International_Passengers" REAL, "Domestic_Passengers" REAL, "Transit_Passengers" REAL, "Aircraft_Movements" REAL, "Freight_Metric_Tonnes" REAL);

CREATE TABLE "airport_aircraft" ("Airport_ID" INTEGER, "Aircraft_ID" INTEGER, "ID" INTEGER, PRIMARY KEY ("Airport_ID", "Aircraft_ID"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Airport_ID") REFERENCES "airport" ("Airport_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "aircraft" ("Aircraft_ID", "Aircraft", "Description", "Max_Gross_Weight", "Total_disk_area", "Max_disk_Loading") VALUES (1, 'Robinson R-22', 'Light utility helicopter', '1370 lb', '497 sq ft', '2.76 lb/sq ft');
INSERT INTO "aircraft" ("Aircraft_ID", "Aircraft", "Description", "Max_Gross_Weight", "Total_disk_area", "Max_disk_Loading") VALUES (2, 'Bell 206', 'Turboshaft helicopter', '3200 lb', '872 sq ft', '3.67 lb/sq ft');
INSERT INTO "aircraft" ("Aircraft_ID", "Aircraft", "Description", "Max_Gross_Weight", "Total_disk_area", "Max_disk_Loading") VALUES (3, 'Robinson R-22', 'Unlinked R-22', '1370 lb', '497 sq ft', '2.76 lb/sq ft');
INSERT INTO "airport" ("Airport_ID", "Airport_Name", "Total_Passengers", "%_Change_2007", "International_Passengers", "Domestic_Passengers", "Transit_Passengers", "Aircraft_Movements", "Freight_Metric_Tonnes") VALUES (1, 'Alpha Airport', 5000.0, '5.2%', 3000.0, 1500.0, 500.0, 120.0, 45.0);
INSERT INTO "airport" ("Airport_ID", "Airport_Name", "Total_Passengers", "%_Change_2007", "International_Passengers", "Domestic_Passengers", "Transit_Passengers", "Aircraft_Movements", "Freight_Metric_Tonnes") VALUES (2, 'Beta Airport', 1000.0, '1.1%', 100.0, 800.0, 100.0, 80.0, 10.0);
INSERT INTO "airport" ("Airport_ID", "Airport_Name", "Total_Passengers", "%_Change_2007", "International_Passengers", "Domestic_Passengers", "Transit_Passengers", "Aircraft_Movements", "Freight_Metric_Tonnes") VALUES (3, 'Gamma Airport', 3000.0, '3.4%', 2000.0, 900.0, 100.0, 95.0, 25.0);
INSERT INTO "airport" ("Airport_ID", "Airport_Name", "Total_Passengers", "%_Change_2007", "International_Passengers", "Domestic_Passengers", "Transit_Passengers", "Aircraft_Movements", "Freight_Metric_Tonnes") VALUES (4, 'Delta Airport', 9000.0, '8.0%', 6000.0, 2500.0, 500.0, 300.0, 90.0);
INSERT INTO "airport" ("Airport_ID", "Airport_Name", "Total_Passengers", "%_Change_2007", "International_Passengers", "Domestic_Passengers", "Transit_Passengers", "Aircraft_Movements", "Freight_Metric_Tonnes") VALUES (5, 'Unlinked Airport', 7500.0, '2.0%', 4000.0, 3000.0, 500.0, 210.0, 60.0);
INSERT INTO "airport_aircraft" ("Airport_ID", "Aircraft_ID", "ID") VALUES (1, 1, 10);
INSERT INTO "airport_aircraft" ("Airport_ID", "Aircraft_ID", "ID") VALUES (2, 1, 20);
INSERT INTO "airport_aircraft" ("Airport_ID", "Aircraft_ID", "ID") VALUES (3, 1, 30);
INSERT INTO "airport_aircraft" ("Airport_ID", "Aircraft_ID", "ID") VALUES (4, 2, 40);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "meantotal_passengers" AS "avg_t3_total_passengers_" FROM (SELECT "LHS"."id" AS "id", "LHS"."airport_id" AS "airport_id", "LHS"."aircraft_id" AS "aircraft_id", "LHS"."aircraft" AS "aircraft", "LHS"."description" AS "description", "LHS"."max_gross_weight" AS "max_gross_weight", "LHS"."total_disk_area" AS "total_disk_area", "LHS"."max_disk_loading" AS "max_disk_loading", "RHS"."international_passengers" AS "international_passengers", "RHS"."meantotal_passengers" AS "meantotal_passengers" FROM (SELECT "LHS"."id" AS "id", "LHS"."airport_id" AS "airport_id", "LHS"."aircraft_id" AS "aircraft_id", "RHS"."aircraft" AS "aircraft", "RHS"."description" AS "description", "RHS"."max_gross_weight" AS "max_gross_weight", "RHS"."total_disk_area" AS "total_disk_area", "RHS"."max_disk_loading" AS "max_disk_loading" FROM "airport_aircraft" AS "LHS" INNER JOIN (SELECT * FROM "aircraft" WHERE ("aircraft" = 'Robinson R-22')) AS RHS ON (LHS.aircraft_id = RHS.aircraft_id)) AS LHS INNER JOIN (SELECT airport_id, international_passengers, AVG(total_passengers) AS meantotal_passengers FROM airport GROUP BY airport_id, international_passengers) AS RHS ON (LHS.airport_id = RHS.airport_id)) ORDER BY avg_t3_total_passengers_;

/*
Gold Result:
(1000.0,)
(3000.0,)
(5000.0,)
*/

-- Prediction Query
SELECT AVG(T3.Total_Passengers) FROM aircraft AS T1 JOIN airport_aircraft AS T2 ON T1.Aircraft_ID = T2.Aircraft_ID JOIN airport AS T3 ON T2.Airport_ID = T3.Airport_ID WHERE T1.Aircraft = 'Robinson R-22';

/*
Prediction Result:
(3000.0,)
*/