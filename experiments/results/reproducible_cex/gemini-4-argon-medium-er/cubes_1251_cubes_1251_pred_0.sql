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
INSERT INTO Properties (property_id, property_type_code, property_address, other_details) VALUES (1, 'A', '123 Main', 'D1');
INSERT INTO Properties (property_id, property_type_code, property_address, other_details) VALUES (2, 'B', '456 Main', 'D2');
INSERT INTO Residents (resident_id, property_id, date_moved_in, date_moved_out, other_details) VALUES (1, 1, '2020-01-01', '2021-01-01', 'R1');
INSERT INTO Residents (resident_id, property_id, date_moved_in, date_moved_out, other_details) VALUES (2, 2, '2020-01-02', '2021-01-02', 'R2');
INSERT INTO Organizations (organization_id, parent_organization_id, organization_details) VALUES (1, NULL, 'Org1');
INSERT INTO Services (service_id, organization_id, service_type_code, service_details) VALUES (1, 1, 'S1', 'Service 1');
INSERT INTO Services (service_id, organization_id, service_type_code, service_details) VALUES (2, 1, 'S2', 'Service 2');
INSERT INTO Residents_Services (resident_id, service_id, property_id, date_moved_in, date_requested, date_provided, other_details) VALUES (1, 1, 1, '2020-01-01', '2020-02-01', '2020-02-02', 'RS1');
INSERT INTO Residents_Services (resident_id, service_id, property_id, date_moved_in, date_requested, date_provided, other_details) VALUES (1, 2, 2, '2020-01-01', '2020-02-01', '2020-02-02', 'RS2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT resident_id, other_details, n AS count___ FROM (SELECT LHS.resident_id AS resident_id, LHS.property_id AS property_id, LHS.date_moved_in AS date_moved_in, LHS.date_moved_out AS date_moved_out, LHS.other_details AS other_details, RHS.property_id AS property_id_other, RHS.n AS n FROM residents AS LHS INNER JOIN (SELECT property_id, resident_id, COUNT(*) AS n FROM residents_services GROUP BY property_id, resident_id) AS RHS ON (LHS.resident_id = RHS.resident_id)) ORDER BY resident_id, other_details NULLS LAST, count___ NULLS LAST;

/*
Gold Result:
(1, 'R1', 1)
(1, 'R1', 1)
*/

-- Prediction Query
SELECT T1.resident_id, T1.other_details, COUNT(*) FROM Residents AS T1 JOIN Residents_Services AS T2 ON T1.resident_id = T2.resident_id GROUP BY T1.resident_id ORDER BY COUNT(*) DESC, T1.resident_id NULLS LAST, T1.other_details NULLS LAST;

/*
Prediction Result:
(1, 'R1', 2)
*/