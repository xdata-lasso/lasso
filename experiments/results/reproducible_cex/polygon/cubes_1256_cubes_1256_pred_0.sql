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
INSERT INTO "Customers" ("customer_id", "customer_details") VALUES (25, NULL);
INSERT INTO "Customers" ("customer_id", "customer_details") VALUES (24, '25');
INSERT INTO "Properties" ("property_id", "property_type_code", "property_address", "other_details") VALUES (26, '25', '25', '25');
INSERT INTO "Properties" ("property_id", "property_type_code", "property_address", "other_details") VALUES (49, '25', '25', '25');
INSERT INTO "Residents" ("resident_id", "property_id", "date_moved_in", "date_moved_out", "other_details") VALUES (22, 26, 23, 25, '25');
INSERT INTO "Residents" ("resident_id", "property_id", "date_moved_in", "date_moved_out", "other_details") VALUES (21, 49, 37, 25, '25');
INSERT INTO "Organizations" ("organization_id", "parent_organization_id", "organization_details") VALUES (28, 25, '25');
INSERT INTO "Organizations" ("organization_id", "parent_organization_id", "organization_details") VALUES (27, 25, '25');
INSERT INTO "Services" ("service_id", "organization_id", "service_type_code", "service_details") VALUES (30, 28, '25', '25');
INSERT INTO "Things" ("thing_id", "organization_id", "type_of_thing_code", "service_type_code", "service_details") VALUES (33, 27, '25', '25', '25');
INSERT INTO "Things" ("thing_id", "organization_id", "type_of_thing_code", "service_type_code", "service_details") VALUES (32, 27, '25', '25', '25');
INSERT INTO "Customer_Events" ("customer_event_id", "resident_id", "property_id", "date_moved_in", "customer_id", "thing_id") VALUES (47, NULL, 49, NULL, NULL, NULL);
INSERT INTO "Customer_Events" ("customer_event_id", "resident_id", "property_id", "date_moved_in", "customer_id", "thing_id") VALUES (34, NULL, NULL, 37, 25, NULL);
INSERT INTO "Customer_Event_Notes" ("customer_event_note_id", "customer_event_id", "service_type_code", "resident_id", "property_id", "date_moved_in") VALUES (25, 34, '25', 25, 25, 25);
INSERT INTO "Timed_Status_of_Things" ("thing_id", "date_and_date", "status_of_thing_code") VALUES (32, 40, '25');
INSERT INTO "Timed_Status_of_Things" ("thing_id", "date_and_date", "status_of_thing_code") VALUES (32, 39, '25');
INSERT INTO "Timed_Locations_of_Things" ("thing_id", "date_and_time", "location_code") VALUES (32, 25, '25');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_moved_in, customer_id, customer_details FROM (SELECT LHS.customer_event_id AS customer_event_id, LHS.customer_id AS customer_id, LHS.date_moved_in AS date_moved_in, LHS.property_id AS property_id, LHS.resident_id AS resident_id, LHS.thing_id AS thing_id, RHS.customer_details AS customer_details FROM customer_events AS LHS LEFT JOIN customers AS RHS ON (LHS.customer_id = RHS.customer_id)) ORDER BY date_moved_in, customer_id NULLS LAST, customer_details NULLS LAST;

/*
Gold Result:
(None, None, None)
(37, 25, None)
*/

-- Prediction Query
SELECT T2.date_moved_in, T1.customer_id, T1.customer_details FROM Customers AS T1 JOIN Customer_Events AS T2 ON T1.customer_id = T2.customer_id;

/*
Prediction Result:
(37, 25, None)
*/