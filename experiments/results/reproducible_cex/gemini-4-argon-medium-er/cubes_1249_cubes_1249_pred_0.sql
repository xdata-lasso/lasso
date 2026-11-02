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
INSERT INTO "Organizations" ("organization_id", "parent_organization_id", "organization_details") VALUES (1, 1, 'Org 1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT organization_id FROM (SELECT * FROM (SELECT * FROM organizations ORDER BY organization_id DESC) LIMIT 1);

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT organization_id FROM organizations EXCEPT SELECT parent_organization_id FROM organizations;

/*
Prediction Result:
*/