-- Schema DDL
CREATE TABLE "pilot" ("Pilot_Id" INTEGER(11) PRIMARY KEY, "Name" TEXT(50), "Age" INTEGER(11));

CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER(11) PRIMARY KEY, "Aircraft" TEXT(50), "Description" TEXT(50), "Max_Gross_Weight" TEXT(50), "Total_disk_area" TEXT(50), "Max_disk_Loading" TEXT(50));

CREATE TABLE "match" ("Round" REAL PRIMARY KEY, "Winning_Pilot" TEXT, "Winning_Aircraft" TEXT, "Location" TEXT, "Country" TEXT, "Date" TEXT, "Fastest_Qualifying" TEXT, FOREIGN KEY ("Winning_Pilot") REFERENCES "pilot" ("Pilot_Id"), FOREIGN KEY ("Winning_Aircraft") REFERENCES "aircraft" ("Aircraft_ID"));

CREATE TABLE "airport" ("Airport_ID" INTEGER PRIMARY KEY, "Airport_Name" TEXT, "Total_Passengers" REAL, "%_Change_2007" TEXT, "International_Passengers" REAL, "Domestic_Passengers" REAL, "Transit_Passengers" REAL, "Aircraft_Movements" REAL, "Freight_Metric_Tonnes" REAL);

CREATE TABLE "airport_aircraft" ("Airport_ID" INTEGER, "Aircraft_ID" INTEGER, "ID" INTEGER, PRIMARY KEY ("Airport_ID", "Aircraft_ID"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Airport_ID") REFERENCES "airport" ("Airport_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: aircraft --
INSERT INTO "aircraft" ("aircraft_id", "aircraft", "description", "max_gross_weight", "total_disk_area", "max_disk_loading") VALUES (1, 'Robinson R-22', 'air_3cf2d6', 'air_324de8', 'air_f3fa12', 'air_d0591c');

INSERT INTO "aircraft" ("aircraft_id", "aircraft", "description", "max_gross_weight", "total_disk_area", "max_disk_loading") VALUES (2, 'Robinson R-22', 'air_3cf2d6', 'air_324de8', 'air_f3fa12', 'air_d0591c');

INSERT INTO "aircraft" ("aircraft_id", "aircraft", "description", "max_gross_weight", "total_disk_area", "max_disk_loading") VALUES (3, 'air_caf8e0', 'air_3cf2d6', 'air_324de8', 'air_f3fa12', 'air_d0591c');

INSERT INTO "aircraft" ("aircraft_id", "aircraft", "description", "max_gross_weight", "total_disk_area", "max_disk_loading") VALUES (4, 'Robinson R-22', 'air_3cf2d6', 'air_324de8', 'air_f3fa12', 'air_d0591c');

INSERT INTO "aircraft" ("aircraft_id", "aircraft", "description", "max_gross_weight", "total_disk_area", "max_disk_loading") VALUES (6, 'Robinson R-22', 'air_3cf2d6', 'air_324de8', 'air_f3fa12', 'air_d0591c');

INSERT INTO "aircraft" ("aircraft_id", "aircraft", "description", "max_gross_weight", "total_disk_area", "max_disk_loading") VALUES (8, 'Robinson R-22', 'air_3cf2d6', 'air_324de8', 'air_f3fa12', 'air_d0591c');

INSERT INTO "aircraft" ("aircraft_id", "aircraft", "description", "max_gross_weight", "total_disk_area", "max_disk_loading") VALUES (10, 'Robinson R-22', 'air_3cf2d6', 'air_324de8', 'air_f3fa12', 'air_d0591c');

INSERT INTO "aircraft" ("aircraft_id", "aircraft", "description", "max_gross_weight", "total_disk_area", "max_disk_loading") VALUES (5, NULL, 'air_3cf2d6', 'air_324de8', 'air_f3fa12', 'air_d0591c');

INSERT INTO "aircraft" ("aircraft_id", "aircraft", "description", "max_gross_weight", "total_disk_area", "max_disk_loading") VALUES (7, 'Robinson R-22', 'air_3cf2d6', 'air_324de8', 'air_f3fa12', 'air_d0591c');

INSERT INTO "aircraft" ("aircraft_id", "aircraft", "description", "max_gross_weight", "total_disk_area", "max_disk_loading") VALUES (9, 'Robinson R-22', 'air_3cf2d6', 'air_324de8', 'air_f3fa12', 'air_d0591c');

INSERT INTO "aircraft" ("aircraft_id", "aircraft", "description", "max_gross_weight", "total_disk_area", "max_disk_loading") VALUES (11, 'Robinson R-22', 'air_3cf2d6', 'air_324de8', 'air_f3fa12', 'air_d0591c');

INSERT INTO "aircraft" ("aircraft_id", "aircraft", "description", "max_gross_weight", "total_disk_area", "max_disk_loading") VALUES (12, 'Robinson R-22', 'air_3cf2d6', 'air_324de8', 'air_f3fa12', 'air_d0591c');

-- Inserting into table: airport --
INSERT INTO "airport" ("airport_id", "airport_name", "total_passengers", "%_change_2007", "international_passengers", "domestic_passengers", "transit_passengers", "aircraft_movements", "freight_metric_tonnes") VALUES (1, '5k5swwqcgs', 171.746906, 'n8c4pgu7v', 86.520366, 65.761562, 779.409124, 640.719621, 770.236508);

INSERT INTO "airport" ("airport_id", "airport_name", "total_passengers", "%_change_2007", "international_passengers", "domestic_passengers", "transit_passengers", "aircraft_movements", "freight_metric_tonnes") VALUES (3, 'ypuzhsrw', 944.247544, 'p', 503.083789, 320.851235, 113.643485, 855.355181, 179.378884);

INSERT INTO "airport" ("airport_id", "airport_name", "total_passengers", "%_change_2007", "international_passengers", "domestic_passengers", "transit_passengers", "aircraft_movements", "freight_metric_tonnes") VALUES (2, 'ilbnp', 787.938887, 'dpos', 133.007885, 75.403642, 327.753528, 218.301157, 992.733505);

INSERT INTO "airport" ("airport_id", "airport_name", "total_passengers", "%_change_2007", "international_passengers", "domestic_passengers", "transit_passengers", "aircraft_movements", "freight_metric_tonnes") VALUES (5, '5k5swwqcgs', 1.0, '9n8', 874.871895, 475.173408, 935.695299, 688.4027, 520.784135);

INSERT INTO "airport" ("airport_id", "airport_name", "total_passengers", "%_change_2007", "international_passengers", "domestic_passengers", "transit_passengers", "aircraft_movements", "freight_metric_tonnes") VALUES (7, 'e4', 1.0, 'hria2ypuzhs', 663.049759, 711.020062, 944.247544, 994.117864, 749.826493);

INSERT INTO "airport" ("airport_id", "airport_name", "total_passengers", "%_change_2007", "international_passengers", "domestic_passengers", "transit_passengers", "aircraft_movements", "freight_metric_tonnes") VALUES (9, 'dlttil', 1.0, 'n', 240.969194, 267.815776, 192.379301, 607.794538, 792.223623);

INSERT INTO "airport" ("airport_id", "airport_name", "total_passengers", "%_change_2007", "international_passengers", "domestic_passengers", "transit_passengers", "aircraft_movements", "freight_metric_tonnes") VALUES (11, 'posiie5unw6k', 1.0, 'fa9', 877.276439, 627.258639, 801.414196, 890.762259, 720.527846);

INSERT INTO "airport" ("airport_id", "airport_name", "total_passengers", "%_change_2007", "international_passengers", "domestic_passengers", "transit_passengers", "aircraft_movements", "freight_metric_tonnes") VALUES (4, '4ecigce376n', 805.746877, 'm52zbu', 225.300904, 760.580899, 590.639932, 280.204907, 681.958327);

INSERT INTO "airport" ("airport_id", "airport_name", "total_passengers", "%_change_2007", "international_passengers", "domestic_passengers", "transit_passengers", "aircraft_movements", "freight_metric_tonnes") VALUES (6, '5k5swwqcgs', 171.746906, 'n8c4pgu7v', 86.520366, 65.761562, 779.409124, 640.719621, 770.236508);

INSERT INTO "airport" ("airport_id", "airport_name", "total_passengers", "%_change_2007", "international_passengers", "domestic_passengers", "transit_passengers", "aircraft_movements", "freight_metric_tonnes") VALUES (8, 'a2ypuzhsrwbb', 749.826493, 'luhvdltti', 182.319045, 998.421621, 207.290264, 787.938887, 986.066566);

INSERT INTO "airport" ("airport_id", "airport_name", "total_passengers", "%_change_2007", "international_passengers", "domestic_passengers", "transit_passengers", "aircraft_movements", "freight_metric_tonnes") VALUES (10, 'siie', 489.397796, 'w6kl', 83.204633, 5.585347, 871.191565, 877.276439, 627.258639);

INSERT INTO "airport" ("airport_id", "airport_name", "total_passengers", "%_change_2007", "international_passengers", "domestic_passengers", "transit_passengers", "aircraft_movements", "freight_metric_tonnes") VALUES (12, '5c4ec', 128.76421, 'gce376nium', 779.28645, 566.030342, 452.706544, 672.826911, 21.917736);

-- Inserting into table: airport_aircraft --
INSERT INTO "airport_aircraft" ("airport_id", "aircraft_id", "id") VALUES (1, 1, -992890117);

INSERT INTO "airport_aircraft" ("airport_id", "aircraft_id", "id") VALUES (1, 3, 1914020640);

INSERT INTO "airport_aircraft" ("airport_id", "aircraft_id", "id") VALUES (2, 1, -1399556171);

INSERT INTO "airport_aircraft" ("airport_id", "aircraft_id", "id") VALUES (3, 4, 13244799);

INSERT INTO "airport_aircraft" ("airport_id", "aircraft_id", "id") VALUES (5, 3, 1019800248);

INSERT INTO "airport_aircraft" ("airport_id", "aircraft_id", "id") VALUES (7, 8, 1990080517);

INSERT INTO "airport_aircraft" ("airport_id", "aircraft_id", "id") VALUES (11, 10, 1419861592);

INSERT INTO "airport_aircraft" ("airport_id", "aircraft_id", "id") VALUES (4, 5, 418417917);

INSERT INTO "airport_aircraft" ("airport_id", "aircraft_id", "id") VALUES (6, 7, -992890117);

INSERT INTO "airport_aircraft" ("airport_id", "aircraft_id", "id") VALUES (8, 9, 907682809);

INSERT INTO "airport_aircraft" ("airport_id", "aircraft_id", "id") VALUES (10, 11, 947159877);

INSERT INTO "airport_aircraft" ("airport_id", "aircraft_id", "id") VALUES (12, 12, -747753377);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "meantotal_passengers" AS "avg_t3_total_passengers_" FROM (SELECT "LHS"."id" AS "id", "LHS"."airport_id" AS "airport_id", "LHS"."aircraft_id" AS "aircraft_id", "LHS"."aircraft" AS "aircraft", "LHS"."description" AS "description", "LHS"."max_gross_weight" AS "max_gross_weight", "LHS"."total_disk_area" AS "total_disk_area", "LHS"."max_disk_loading" AS "max_disk_loading", "RHS"."international_passengers" AS "international_passengers", "RHS"."meantotal_passengers" AS "meantotal_passengers" FROM (SELECT "LHS"."id" AS "id", "LHS"."airport_id" AS "airport_id", "LHS"."aircraft_id" AS "aircraft_id", "RHS"."aircraft" AS "aircraft", "RHS"."description" AS "description", "RHS"."max_gross_weight" AS "max_gross_weight", "RHS"."total_disk_area" AS "total_disk_area", "RHS"."max_disk_loading" AS "max_disk_loading" FROM "airport_aircraft" AS "LHS" INNER JOIN (SELECT * FROM "aircraft" WHERE ("aircraft" = 'Robinson R-22')) AS RHS ON (LHS.aircraft_id = RHS.aircraft_id)) AS LHS INNER JOIN (SELECT airport_id, international_passengers, AVG(total_passengers) AS meantotal_passengers FROM airport GROUP BY airport_id, international_passengers) AS RHS ON (LHS.airport_id = RHS.airport_id)) ORDER BY avg_t3_total_passengers_;

/*
Gold Result:
(1.0,)
(1.0,)
(128.76421,)
(171.746906,)
(171.746906,)
(489.397796,)
(749.826493,)
(787.938887,)
(944.247544,)
*/

-- Prediction Query
SELECT AVG(T3.Total_Passengers) FROM aircraft AS T1 JOIN airport_aircraft AS T2 ON T1.Aircraft_ID = T2.Aircraft_ID JOIN airport AS T3 ON T2.Airport_ID = T3.Airport_ID WHERE T1.Aircraft = 'Robinson R-22';

/*
Prediction Result:
(382.8520824444444,)
*/