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
-- DATASET 3
INSERT INTO Customers (customer_id, customer_details) VALUES (10, 'C10');
INSERT INTO Customers (customer_id, customer_details) VALUES (50, 'C50');
INSERT INTO Properties (property_id, property_type_code, property_address, other_details) VALUES (1, 'APT', '10 Pine Rd', 'P1');
INSERT INTO Properties (property_id, property_type_code, property_address, other_details) VALUES (2, 'APT', '20 Pine Rd', 'P2');
INSERT INTO Residents (resident_id, property_id, date_moved_in, date_moved_out, other_details) VALUES (1, 1, '2019-05-01 00:00:00', '2020-05-01 00:00:00', 'R1');
INSERT INTO Residents (resident_id, property_id, date_moved_in, date_moved_out, other_details) VALUES (2, 2, '2019-06-01 00:00:00', '2020-06-01 00:00:00', 'R2');
INSERT INTO Organizations (organization_id, parent_organization_id, organization_details) VALUES (1, NULL, 'Org 1');
INSERT INTO Things (thing_id, organization_id, Type_of_Thing_Code, service_type_code, service_details) VALUES (1, 1, 'ALARM', 'SEC', 'T1');
INSERT INTO Things (thing_id, organization_id, Type_of_Thing_Code, service_type_code, service_details) VALUES (2, 1, 'ALARM', 'SEC', 'T2');
INSERT INTO Customer_Events (Customer_Event_ID, resident_id, property_id, date_moved_in, customer_id, thing_id) VALUES (1, 1, 1, '2019-05-01 00:00:00', 50, 1);
INSERT INTO Customer_Events (Customer_Event_ID, resident_id, property_id, date_moved_in, customer_id, thing_id) VALUES (2, 2, 2, '2019-06-01 00:00:00', 50, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count___ FROM (SELECT COUNT(DISTINCT customer_id) AS n_distinct FROM (SELECT * FROM (SELECT LHS.customer_event_id AS customer_event_id, LHS.customer_id AS customer_id, LHS.date_moved_in AS date_moved_in, LHS.property_id AS property_id, LHS.resident_id AS resident_id, LHS.thing_id AS thing_id, RHS.customer_id AS customer_id_other, RHS.customer_details AS customer_details FROM customer_events AS LHS CROSS JOIN customers AS RHS) WHERE (customer_id < customer_id_other))) ORDER BY count___;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(*) FROM customers WHERE NOT customer_id IN (SELECT customer_id FROM customer_events);

/*
Prediction Result:
(1,)
*/