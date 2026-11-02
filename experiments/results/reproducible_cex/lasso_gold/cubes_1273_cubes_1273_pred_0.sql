-- Schema DDL
CREATE TABLE "pilot" ("Pilot_Id" INTEGER(11) PRIMARY KEY, "Name" TEXT(50), "Age" INTEGER(11));

CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER(11) PRIMARY KEY, "Aircraft" TEXT(50), "Description" TEXT(50), "Max_Gross_Weight" TEXT(50), "Total_disk_area" TEXT(50), "Max_disk_Loading" TEXT(50));

CREATE TABLE "match" ("Round" REAL PRIMARY KEY, "Winning_Pilot" TEXT, "Winning_Aircraft" TEXT, "Location" TEXT, "Country" TEXT, "Date" TEXT, "Fastest_Qualifying" TEXT, FOREIGN KEY ("Winning_Pilot") REFERENCES "pilot" ("Pilot_Id"), FOREIGN KEY ("Winning_Aircraft") REFERENCES "aircraft" ("Aircraft_ID"));

CREATE TABLE "airport" ("Airport_ID" INTEGER PRIMARY KEY, "Airport_Name" TEXT, "Total_Passengers" REAL, "%_Change_2007" TEXT, "International_Passengers" REAL, "Domestic_Passengers" REAL, "Transit_Passengers" REAL, "Aircraft_Movements" REAL, "Freight_Metric_Tonnes" REAL);

CREATE TABLE "airport_aircraft" ("Airport_ID" INTEGER, "Aircraft_ID" INTEGER, "ID" INTEGER, PRIMARY KEY ("Airport_ID", "Aircraft_ID"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Airport_ID") REFERENCES "airport" ("Airport_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "airport" ("airport_id", "airport_name", "total_passengers", "%_change_2007", "international_passengers", "domestic_passengers", "transit_passengers", "aircraft_movements", "freight_metric_tonnes") VALUES (1079, 'London Heathrow', 1080.5, 'rate', 1082.5, 1082.5, 1083.5, 1084.5, 1085.5);
INSERT INTO "airport" ("airport_id", "airport_name", "total_passengers", "%_change_2007", "international_passengers", "domestic_passengers", "transit_passengers", "aircraft_movements", "freight_metric_tonnes") VALUES (1086, 'London Heathrow', 1081.5, 'science', 1081.5, 1083.5, 1084.5, 1085.5, 1086.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "international_passengers", "domestic_passengers" FROM "airport" WHERE ("airport_name" = 'London Heathrow') ORDER BY international_passengers, airport.airport_id NULLS LAST;

/*
Gold Result:
(1081.5, 1083.5)
(1082.5, 1082.5)
*/

-- Prediction Query
SELECT International_Passengers, Domestic_Passengers FROM airport WHERE Airport_Name = 'London Heathrow';

/*
Prediction Result:
(1082.5, 1082.5)
(1081.5, 1083.5)
*/