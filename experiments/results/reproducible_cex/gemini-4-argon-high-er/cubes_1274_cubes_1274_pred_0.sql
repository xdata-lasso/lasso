-- Schema DDL
CREATE TABLE "pilot" ("Pilot_Id" INTEGER(11) PRIMARY KEY, "Name" TEXT(50), "Age" INTEGER(11));

CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER(11) PRIMARY KEY, "Aircraft" TEXT(50), "Description" TEXT(50), "Max_Gross_Weight" TEXT(50), "Total_disk_area" TEXT(50), "Max_disk_Loading" TEXT(50));

CREATE TABLE "match" ("Round" REAL PRIMARY KEY, "Winning_Pilot" TEXT, "Winning_Aircraft" TEXT, "Location" TEXT, "Country" TEXT, "Date" TEXT, "Fastest_Qualifying" TEXT, FOREIGN KEY ("Winning_Pilot") REFERENCES "pilot" ("Pilot_Id"), FOREIGN KEY ("Winning_Aircraft") REFERENCES "aircraft" ("Aircraft_ID"));

CREATE TABLE "airport" ("Airport_ID" INTEGER PRIMARY KEY, "Airport_Name" TEXT, "Total_Passengers" REAL, "%_Change_2007" TEXT, "International_Passengers" REAL, "Domestic_Passengers" REAL, "Transit_Passengers" REAL, "Aircraft_Movements" REAL, "Freight_Metric_Tonnes" REAL);

CREATE TABLE "airport_aircraft" ("Airport_ID" INTEGER, "Aircraft_ID" INTEGER, "ID" INTEGER, PRIMARY KEY ("Airport_ID", "Aircraft_ID"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Airport_ID") REFERENCES "airport" ("Airport_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO aircraft (Aircraft_ID, Aircraft, Description, Max_Gross_Weight, Total_disk_area, Max_disk_Loading) VALUES (1, 'Robinson R-22', 'Light utility', '1370 lb', '497 sq ft', '2.6 lb/sq ft');
INSERT INTO airport (Airport_ID, Airport_Name, Total_Passengers, International_Passengers) VALUES (1, 'Airport A', 100.0, 50.0);
INSERT INTO airport (Airport_ID, Airport_Name, Total_Passengers, International_Passengers) VALUES (2, 'Airport B', 200.0, 60.0);
INSERT INTO airport_aircraft (Airport_ID, Aircraft_ID, ID) VALUES (1, 1, 1);
INSERT INTO airport_aircraft (Airport_ID, Aircraft_ID, ID) VALUES (2, 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "meantotal_passengers" AS "avg_t3_total_passengers_" FROM (SELECT "LHS"."id" AS "id", "LHS"."airport_id" AS "airport_id", "LHS"."aircraft_id" AS "aircraft_id", "LHS"."aircraft" AS "aircraft", "LHS"."description" AS "description", "LHS"."max_gross_weight" AS "max_gross_weight", "LHS"."total_disk_area" AS "total_disk_area", "LHS"."max_disk_loading" AS "max_disk_loading", "RHS"."international_passengers" AS "international_passengers", "RHS"."meantotal_passengers" AS "meantotal_passengers" FROM (SELECT "LHS"."id" AS "id", "LHS"."airport_id" AS "airport_id", "LHS"."aircraft_id" AS "aircraft_id", "RHS"."aircraft" AS "aircraft", "RHS"."description" AS "description", "RHS"."max_gross_weight" AS "max_gross_weight", "RHS"."total_disk_area" AS "total_disk_area", "RHS"."max_disk_loading" AS "max_disk_loading" FROM "airport_aircraft" AS "LHS" INNER JOIN (SELECT * FROM "aircraft" WHERE ("aircraft" = 'Robinson R-22')) AS RHS ON (LHS.aircraft_id = RHS.aircraft_id)) AS LHS INNER JOIN (SELECT airport_id, international_passengers, AVG(total_passengers) AS meantotal_passengers FROM airport GROUP BY airport_id, international_passengers) AS RHS ON (LHS.airport_id = RHS.airport_id)) ORDER BY avg_t3_total_passengers_;

/*
Gold Result:
(100.0,)
(200.0,)
*/

-- Prediction Query
SELECT AVG(T3.Total_Passengers) FROM aircraft AS T1 JOIN airport_aircraft AS T2 ON T1.Aircraft_ID = T2.Aircraft_ID JOIN airport AS T3 ON T2.Airport_ID = T3.Airport_ID WHERE T1.Aircraft = 'Robinson R-22';

/*
Prediction Result:
(150.0,)
*/