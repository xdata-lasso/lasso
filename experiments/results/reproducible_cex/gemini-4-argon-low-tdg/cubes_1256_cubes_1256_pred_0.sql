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
-- Tests LEFT JOIN vs INNER JOIN/RIGHT JOIN, NULL handling in customer_id and customer_details, and NULLS LAST ordering.
INSERT INTO Customers (customer_id, customer_details) VALUES (1, 'Alice');
INSERT INTO Customers (customer_id, customer_details) VALUES (2, NULL);
INSERT INTO Customers (customer_id, customer_details) VALUES (3, 'Charlie');
INSERT INTO Customers (customer_id, customer_details) VALUES (4, 'Unmatched Customer');
INSERT INTO Properties (property_id, property_type_code, property_address, other_details) VALUES (10, 'APT', '123 Main St', NULL);
INSERT INTO Properties (property_id, property_type_code, property_address, other_details) VALUES (20, 'HSE', '456 Oak Ave', NULL);
INSERT INTO Residents (resident_id, property_id, date_moved_in, date_moved_out, other_details) VALUES (100, 10, '2021-01-01', '2022-01-01', NULL);
INSERT INTO Residents (resident_id, property_id, date_moved_in, date_moved_out, other_details) VALUES (200, 20, '2021-06-01', '2021-01-01', NULL);
INSERT INTO Customer_Events (Customer_Event_ID, resident_id, property_id, date_moved_in, customer_id, thing_id) VALUES (1001, 100, 10, '2021-01-01', 3, NULL);
INSERT INTO Customer_Events (Customer_Event_ID, resident_id, property_id, date_moved_in, customer_id, thing_id) VALUES (1002, 100, 10, '2021-01-01', 1, NULL);
INSERT INTO Customer_Events (Customer_Event_ID, resident_id, property_id, date_moved_in, customer_id, thing_id) VALUES (1003, 100, 10, '2021-01-01', NULL, NULL);
INSERT INTO Customer_Events (Customer_Event_ID, resident_id, property_id, date_moved_in, customer_id, thing_id) VALUES (1004, 200, 20, '2021-06-01', 2, NULL);
INSERT INTO Customer_Events (Customer_Event_ID, resident_id, property_id, date_moved_in, customer_id, thing_id) VALUES (1005, NULL, NULL, NULL, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_moved_in, customer_id, customer_details FROM (SELECT LHS.customer_event_id AS customer_event_id, LHS.customer_id AS customer_id, LHS.date_moved_in AS date_moved_in, LHS.property_id AS property_id, LHS.resident_id AS resident_id, LHS.thing_id AS thing_id, RHS.customer_details AS customer_details FROM customer_events AS LHS LEFT JOIN customers AS RHS ON (LHS.customer_id = RHS.customer_id)) ORDER BY date_moved_in, customer_id NULLS LAST, customer_details NULLS LAST;

/*
Gold Result:
(None, 1, 'Alice')
('2021-01-01', 1, 'Alice')
('2021-01-01', 3, 'Charlie')
('2021-01-01', None, None)
('2021-06-01', 2, None)
*/

-- Prediction Query
SELECT T2.date_moved_in, T1.customer_id, T1.customer_details FROM Customers AS T1 JOIN Customer_Events AS T2 ON T1.customer_id = T2.customer_id;

/*
Prediction Result:
('2021-01-01', 3, 'Charlie')
('2021-01-01', 1, 'Alice')
('2021-06-01', 2, None)
(None, 1, 'Alice')
*/