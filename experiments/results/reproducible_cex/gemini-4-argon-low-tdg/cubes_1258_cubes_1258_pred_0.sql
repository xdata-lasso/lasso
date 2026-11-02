-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_details" TEXT(255));

CREATE TABLE "Properties" ("property_id" INTEGER PRIMARY KEY, "property_type_code" TEXT(15), "property_address" TEXT(255), "other_details" TEXT(255));

CREATE TABLE "Residents" ("resident_id" INTEGER UNIQUE, "property_id" INTEGER UNIQUE, "date_moved_in" DATETIME UNIQUE, "date_moved_out" DATETIME, "other_details" TEXT(255), PRIMARY KEY ("resident_id", "property_id", "date_moved_in"), FOREIGN KEY ("property_id") REFERENCES "Properties" ("property_id"));

CREATE TABLE "Organizations" ("organization_id" INTEGER PRIMARY KEY, "parent_organization_id" INTEGER, "organization_details" TEXT(255));

CREATE TABLE "Services" ("service_id" INTEGER PRIMARY KEY, "organization_id" INTEGER, "service_type_code" TEXT(15), "service_details" TEXT(255), FOREIGN KEY ("organization_id") REFERENCES "Organizations" ("organization_id"));

CREATE TABLE "Residents_Services" ("resident_id" INTEGER, "service_id" INTEGER, "property_id" INTEGER, "date_moved_in" DATETIME, "date_requested" DATETIME, "date_provided" DATETIME, "other_details" TEXT(255), PRIMARY KEY ("resident_id", "service_id"), FOREIGN KEY ("resident_id") REFERENCES "Residents" ("resident_id"), FOREIGN KEY ("property_id") REFERENCES "Residents" ("property_id"), FOREIGN KEY ("date_moved_in") REFERENCES "Residents" ("date_moved_in"), FOREIGN KEY ("service_id") REFERENCES "Services" ("service_id"));

CREATE TABLE "Things" ("thing_id" INTEGER PRIMARY KEY, "organization_id" INTEGER, "Type_of_Thing_Code" TEXT(15), "service_type_code" TEXT(10), "service_details" TEXT(255), FOREIGN KEY ("organization_id") REFERENCES "Organizations" ("organization_id"));

CREATE TABLE "Customer_Events" ("Customer_Event_ID" INTEGER PRIMARY KEY, "resident_id" INTEGER, "property_id" INTEGER, "date_moved_in" DATETIME, "customer_id" INTEGER, "thing_id" INTEGER, FOREIGN KEY ("resident_id") REFERENCES "Residents" ("resident_id"), FOREIGN KEY ("property_id") REFERENCES "Residents" ("property_id"), FOREIGN KEY ("date_moved_in") REFERENCES "Residents" ("date_moved_in"), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("thing_id") REFERENCES "Things" ("thing_id"));

CREATE TABLE "Customer_Event_Notes" ("Customer_Event_Note_ID" INTEGER PRIMARY KEY, "Customer_Event_ID" INTEGER, "service_type_code" TEXT(15), "resident_id" INTEGER, "property_id" INTEGER, "date_moved_in" DATETIME, FOREIGN KEY ("Customer_Event_ID") REFERENCES "Customer_Events" ("Customer_Event_ID"));

CREATE TABLE "Timed_Status_of_Things" ("thing_id" INTEGER, "Date_and_Date" DATETIME, "Status_of_Thing_Code" TEXT(15), PRIMARY KEY ("thing_id", "Date_and_Date", "Status_of_Thing_Code"), FOREIGN KEY ("thing_id") REFERENCES "Things" ("thing_id"));

CREATE TABLE "Timed_Locations_of_Things" ("thing_id" INTEGER, "Date_and_Time" DATETIME, "Location_Code" TEXT(15), PRIMARY KEY ("thing_id", "Date_and_Time", "Location_Code"), FOREIGN KEY ("thing_id") REFERENCES "Things" ("thing_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Organizations (organization_id, parent_organization_id, organization_details) VALUES (1, NULL, 'Org 1');
INSERT INTO Things (thing_id, organization_id, Type_of_Thing_Code, service_type_code, service_details) VALUES (1, 1, 'T1', 'S1', 'Satisfied');
INSERT INTO Things (thing_id, organization_id, Type_of_Thing_Code, service_type_code, service_details) VALUES (2, 1, 'T1', 'S1', 'Satisfied');
INSERT INTO Things (thing_id, organization_id, Type_of_Thing_Code, service_type_code, service_details) VALUES (3, 1, 'T2', 'S2', 'Unsatisfied');
INSERT INTO Things (thing_id, organization_id, Type_of_Thing_Code, service_type_code, service_details) VALUES (4, 1, 'T3', 'S3', 'Pending');
INSERT INTO Things (thing_id, organization_id, Type_of_Thing_Code, service_type_code, service_details) VALUES (5, 1, 'T3', 'S3', 'Pending');
INSERT INTO Things (thing_id, organization_id, Type_of_Thing_Code, service_type_code, service_details) VALUES (6, 1, 'T3', 'S3', 'Pending');
INSERT INTO Timed_Locations_of_Things (thing_id, Date_and_Time, Location_Code) VALUES (1, '2023-01-01 10:00:00', 'LOC1');
INSERT INTO Timed_Locations_of_Things (thing_id, Date_and_Time, Location_Code) VALUES (1, '2023-01-02 10:00:00', 'LOC2');
INSERT INTO Timed_Locations_of_Things (thing_id, Date_and_Time, Location_Code) VALUES (3, '2023-01-01 10:00:00', 'LOC1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "n" AS "count_distinct_t2_location_code_" FROM (SELECT "LHS"."thing_id" AS "thing_id", "LHS"."organization_id" AS "organization_id", "LHS"."type_of_thing_code" AS "type_of_thing_code", "LHS"."service_type_code" AS "service_type_code", "LHS"."service_details" AS "service_details", "LHS"."date_and_time" AS "date_and_time", "LHS"."location_code" AS "location_code", "LHS"."n" AS "n" FROM (SELECT "LHS"."thing_id" AS "thing_id", "LHS"."organization_id" AS "organization_id", "LHS"."type_of_thing_code" AS "type_of_thing_code", "LHS"."service_type_code" AS "service_type_code", "LHS"."service_details" AS "service_details", "LHS"."date_and_time" AS "date_and_time", "LHS"."location_code" AS "location_code", "RHS"."n" AS "n" FROM (SELECT "LHS"."thing_id" AS "thing_id", "LHS"."organization_id" AS "organization_id", "LHS"."type_of_thing_code" AS "type_of_thing_code", "LHS"."service_type_code" AS "service_type_code", "LHS"."service_details" AS "service_details", "RHS"."date_and_time" AS "date_and_time", "RHS"."location_code" AS "location_code" FROM "things" AS "LHS" INNER JOIN "timed_locations_of_things" AS "RHS" ON ("LHS"."thing_id" = "RHS"."thing_id")) AS "LHS" INNER JOIN (SELECT "service_details", COUNT(*) AS "n" FROM "things" GROUP BY "service_details") AS "RHS" ON ("LHS"."service_details" = "RHS"."service_details")) AS "LHS" INNER JOIN (SELECT * FROM (SELECT "service_details", COUNT(*) AS "n" FROM "things" GROUP BY "service_details") WHERE ("service_details" <> 'Unsatisfied')) AS RHS ON (LHS.service_details = RHS.service_details AND LHS.n = RHS.n)) ORDER BY count_distinct_t2_location_code_;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T2.Location_Code) FROM Things AS T1 JOIN Timed_Locations_of_Things AS T2 ON T1.thing_id = T2.thing_id WHERE T1.service_details = 'Unsatisfied';

/*
Prediction Result:
(1,)
*/