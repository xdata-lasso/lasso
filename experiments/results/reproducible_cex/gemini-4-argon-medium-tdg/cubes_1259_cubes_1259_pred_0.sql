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
-- Tests exact boundary conditions on event counts: 0, 1, 2, 3, 4, 5 events per customer.
-- Also tests ordering by customer_id vs count(n) vs customer_details.
INSERT INTO Customers (customer_id, customer_details) VALUES (1, 'Zero_Events');
INSERT INTO Customers (customer_id, customer_details) VALUES (2, 'One_Event');
INSERT INTO Customers (customer_id, customer_details) VALUES (3, 'Two_Events');
INSERT INTO Customers (customer_id, customer_details) VALUES (4, 'Three_Events');
INSERT INTO Customers (customer_id, customer_details) VALUES (5, 'Z_Four_Events');
INSERT INTO Customers (customer_id, customer_details) VALUES (6, 'A_Five_Events');
INSERT INTO Customer_Events (Customer_Event_ID, customer_id) VALUES (101, 2);
INSERT INTO Customer_Events (Customer_Event_ID, customer_id) VALUES (201, 3);
INSERT INTO Customer_Events (Customer_Event_ID, customer_id) VALUES (202, 3);
INSERT INTO Customer_Events (Customer_Event_ID, customer_id) VALUES (301, 4);
INSERT INTO Customer_Events (Customer_Event_ID, customer_id) VALUES (302, 4);
INSERT INTO Customer_Events (Customer_Event_ID, customer_id) VALUES (303, 4);
INSERT INTO Customer_Events (Customer_Event_ID, customer_id) VALUES (401, 5);
INSERT INTO Customer_Events (Customer_Event_ID, customer_id) VALUES (402, 5);
INSERT INTO Customer_Events (Customer_Event_ID, customer_id) VALUES (403, 5);
INSERT INTO Customer_Events (Customer_Event_ID, customer_id) VALUES (404, 5);
INSERT INTO Customer_Events (Customer_Event_ID, customer_id) VALUES (501, 6);
INSERT INTO Customer_Events (Customer_Event_ID, customer_id) VALUES (502, 6);
INSERT INTO Customer_Events (Customer_Event_ID, customer_id) VALUES (503, 6);
INSERT INTO Customer_Events (Customer_Event_ID, customer_id) VALUES (504, 6);
INSERT INTO Customer_Events (Customer_Event_ID, customer_id) VALUES (505, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, customer_details FROM (SELECT LHS.customer_id AS customer_id, LHS.n AS n, RHS.customer_details AS customer_details FROM (SELECT * FROM (SELECT customer_id, COUNT(*) AS n FROM customer_events GROUP BY customer_id) WHERE (n > 3)) AS LHS INNER JOIN customers AS RHS ON (LHS.customer_id = RHS.customer_id)) ORDER BY customer_id, customer_details NULLS LAST;

/*
Gold Result:
(5, 'Z_Four_Events')
(6, 'A_Five_Events')
*/

-- Prediction Query
SELECT T1.customer_id, T1.customer_details FROM Customers AS T1 JOIN Customer_Events AS T2 ON T1.customer_id = T2.customer_id GROUP BY T1.customer_id HAVING COUNT(*) >= 3;

/*
Prediction Result:
(4, 'Three_Events')
(5, 'Z_Four_Events')
(6, 'A_Five_Events')
*/