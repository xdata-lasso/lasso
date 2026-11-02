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
INSERT INTO Organizations (organization_id, parent_organization_id, organization_details) VALUES (1, NULL, 'Main Org');
INSERT INTO Properties (property_id, property_type_code, property_address, other_details) VALUES (1, 'APT', '101 First St', NULL);
INSERT INTO Properties (property_id, property_type_code, property_address, other_details) VALUES (2, 'HSE', '202 Second St', NULL);
INSERT INTO Properties (property_id, property_type_code, property_address, other_details) VALUES (3, 'CONDO', '303 Third St', NULL);
INSERT INTO Properties (property_id, property_type_code, property_address, other_details) VALUES (4, 'APT', '404 Fourth St', NULL);
INSERT INTO Properties (property_id, property_type_code, property_address, other_details) VALUES (5, 'HSE', '505 Fifth St', NULL);
INSERT INTO Properties (property_id, property_type_code, property_address, other_details) VALUES (6, 'APT', '606 Sixth St', NULL);
INSERT INTO Residents (resident_id, property_id, date_moved_in, date_moved_out, other_details) VALUES (1, 1, '2022-01-01 00:00:00', NULL, 'Res 1');
INSERT INTO Residents (resident_id, property_id, date_moved_in, date_moved_out, other_details) VALUES (2, 2, '2022-01-02 00:00:00', NULL, 'Res 2');
INSERT INTO Residents (resident_id, property_id, date_moved_in, date_moved_out, other_details) VALUES (3, 3, '2022-01-03 00:00:00', NULL, 'Res 3');
INSERT INTO Residents (resident_id, property_id, date_moved_in, date_moved_out, other_details) VALUES (4, 4, '2022-01-04 00:00:00', NULL, 'Res 4');
INSERT INTO Residents (resident_id, property_id, date_moved_in, date_moved_out, other_details) VALUES (5, 5, '2022-01-05 00:00:00', NULL, 'Res 5');
INSERT INTO Residents (resident_id, property_id, date_moved_in, date_moved_out, other_details) VALUES (6, 6, '2022-01-06 00:00:00', NULL, 'Res 6');
INSERT INTO Things (thing_id, organization_id, Type_of_Thing_Code, service_type_code, service_details) VALUES (1, 1, 'SENSOR', 'MAINT', 'Thing 1');
INSERT INTO Things (thing_id, organization_id, Type_of_Thing_Code, service_type_code, service_details) VALUES (2, 1, 'METER', 'UTIL', 'Thing 2');
INSERT INTO Things (thing_id, organization_id, Type_of_Thing_Code, service_type_code, service_details) VALUES (3, 1, 'ALARM', 'SEC', 'Thing 3');
INSERT INTO Things (thing_id, organization_id, Type_of_Thing_Code, service_type_code, service_details) VALUES (4, 1, 'LOCK', 'SEC', 'Thing 4');
INSERT INTO Things (thing_id, organization_id, Type_of_Thing_Code, service_type_code, service_details) VALUES (5, 1, 'CAM', 'SEC', 'Thing 5');
INSERT INTO Things (thing_id, organization_id, Type_of_Thing_Code, service_type_code, service_details) VALUES (6, 1, 'THERM', 'HVAC', 'Thing 6');
INSERT INTO Customers (customer_id, customer_details) VALUES (1, 'Zoe');
INSERT INTO Customers (customer_id, customer_details) VALUES (2, 'Bob');
INSERT INTO Customers (customer_id, customer_details) VALUES (3, 'Alice');
INSERT INTO Customers (customer_id, customer_details) VALUES (4, 'Charlie');
INSERT INTO Customers (customer_id, customer_details) VALUES (5, 'Diana');
INSERT INTO Customers (customer_id, customer_details) VALUES (6, 'Miller');
INSERT INTO Customers (customer_id, customer_details) VALUES (7, 'Evan');
INSERT INTO Customer_Events (Customer_Event_ID, resident_id, property_id, date_moved_in, customer_id, thing_id) VALUES (1, 1, 1, '2022-01-01 00:00:00', 1, 1);
INSERT INTO Customer_Events (Customer_Event_ID, resident_id, property_id, date_moved_in, customer_id, thing_id) VALUES (2, 2, 2, '2022-01-02 00:00:00', 1, 2);
INSERT INTO Customer_Events (Customer_Event_ID, resident_id, property_id, date_moved_in, customer_id, thing_id) VALUES (3, 3, 3, '2022-01-03 00:00:00', 1, 3);
INSERT INTO Customer_Events (Customer_Event_ID, resident_id, property_id, date_moved_in, customer_id, thing_id) VALUES (4, 4, 4, '2022-01-04 00:00:00', 1, 4);
INSERT INTO Customer_Events (Customer_Event_ID, resident_id, property_id, date_moved_in, customer_id, thing_id) VALUES (5, 5, 5, '2022-01-05 00:00:00', 1, 5);
INSERT INTO Customer_Events (Customer_Event_ID, resident_id, property_id, date_moved_in, customer_id, thing_id) VALUES (6, 6, 6, '2022-01-06 00:00:00', 1, 6);
INSERT INTO Customer_Events (Customer_Event_ID, resident_id, property_id, date_moved_in, customer_id, thing_id) VALUES (7, 1, 1, '2022-01-01 00:00:00', 2, 1);
INSERT INTO Customer_Events (Customer_Event_ID, resident_id, property_id, date_moved_in, customer_id, thing_id) VALUES (8, 2, 2, '2022-01-02 00:00:00', 2, 2);
INSERT INTO Customer_Events (Customer_Event_ID, resident_id, property_id, date_moved_in, customer_id, thing_id) VALUES (9, 3, 3, '2022-01-03 00:00:00', 2, 3);
INSERT INTO Customer_Events (Customer_Event_ID, resident_id, property_id, date_moved_in, customer_id, thing_id) VALUES (10, 1, 1, '2022-01-01 00:00:00', 3, 1);
INSERT INTO Customer_Events (Customer_Event_ID, resident_id, property_id, date_moved_in, customer_id, thing_id) VALUES (11, 2, 2, '2022-01-02 00:00:00', 3, 2);
INSERT INTO Customer_Events (Customer_Event_ID, resident_id, property_id, date_moved_in, customer_id, thing_id) VALUES (12, 3, 3, '2022-01-03 00:00:00', 3, 3);
INSERT INTO Customer_Events (Customer_Event_ID, resident_id, property_id, date_moved_in, customer_id, thing_id) VALUES (13, 4, 4, '2022-01-04 00:00:00', 3, 4);
INSERT INTO Customer_Events (Customer_Event_ID, resident_id, property_id, date_moved_in, customer_id, thing_id) VALUES (14, 1, 1, '2022-01-01 00:00:00', 4, 1);
INSERT INTO Customer_Events (Customer_Event_ID, resident_id, property_id, date_moved_in, customer_id, thing_id) VALUES (15, 1, 1, '2022-01-01 00:00:00', 6, 1);
INSERT INTO Customer_Events (Customer_Event_ID, resident_id, property_id, date_moved_in, customer_id, thing_id) VALUES (16, 2, 2, '2022-01-02 00:00:00', 6, 2);
INSERT INTO Customer_Events (Customer_Event_ID, resident_id, property_id, date_moved_in, customer_id, thing_id) VALUES (17, 3, 3, '2022-01-03 00:00:00', 6, 3);
INSERT INTO Customer_Events (Customer_Event_ID, resident_id, property_id, date_moved_in, customer_id, thing_id) VALUES (18, 4, 4, '2022-01-04 00:00:00', 6, 4);
INSERT INTO Customer_Events (Customer_Event_ID, resident_id, property_id, date_moved_in, customer_id, thing_id) VALUES (19, 5, 5, '2022-01-05 00:00:00', 6, 5);
INSERT INTO Customer_Events (Customer_Event_ID, resident_id, property_id, date_moved_in, customer_id, thing_id) VALUES (20, 1, 1, '2022-01-01 00:00:00', 7, 1);
INSERT INTO Customer_Events (Customer_Event_ID, resident_id, property_id, date_moved_in, customer_id, thing_id) VALUES (21, 2, 2, '2022-01-02 00:00:00', 7, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, customer_details FROM (SELECT LHS.customer_id AS customer_id, LHS.n AS n, RHS.customer_details AS customer_details FROM (SELECT * FROM (SELECT customer_id, COUNT(*) AS n FROM customer_events GROUP BY customer_id) WHERE (n > 3)) AS LHS INNER JOIN customers AS RHS ON (LHS.customer_id = RHS.customer_id)) ORDER BY customer_id, customer_details NULLS LAST;

/*
Gold Result:
(1, 'Zoe')
(3, 'Alice')
(6, 'Miller')
*/

-- Prediction Query
SELECT T1.customer_id, T1.customer_details FROM Customers AS T1 JOIN Customer_Events AS T2 ON T1.customer_id = T2.customer_id GROUP BY T1.customer_id HAVING COUNT(*) >= 3;

/*
Prediction Result:
(1, 'Zoe')
(2, 'Bob')
(3, 'Alice')
(6, 'Miller')
*/