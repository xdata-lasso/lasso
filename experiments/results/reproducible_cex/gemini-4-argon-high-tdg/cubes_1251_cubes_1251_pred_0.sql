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
INSERT INTO Properties (property_id, property_type_code, property_address, other_details) VALUES (10, 'APT', '10 Main St', 'Prop10');
INSERT INTO Properties (property_id, property_type_code, property_address, other_details) VALUES (20, 'HSE', '20 Oak St', 'Prop20');
INSERT INTO Properties (property_id, property_type_code, property_address, other_details) VALUES (30, 'CON', '30 Pine St', 'Prop30');
INSERT INTO Residents (resident_id, property_id, date_moved_in, date_moved_out, other_details) VALUES (1, 10, '2021-01-01 00:00:00', '2022-01-01 00:00:00', 'Res1_Details');
INSERT INTO Residents (resident_id, property_id, date_moved_in, date_moved_out, other_details) VALUES (2, 20, '2021-02-01 00:00:00', NULL, NULL);
INSERT INTO Residents (resident_id, property_id, date_moved_in, date_moved_out, other_details) VALUES (3, 30, '2021-03-01 00:00:00', NULL, 'Res3_NoServices');
INSERT INTO Organizations (organization_id, parent_organization_id, organization_details) VALUES (100, NULL, 'Org100');
INSERT INTO Services (service_id, organization_id, service_type_code, service_details) VALUES (1, 100, 'CLEAN', 'Cleaning');
INSERT INTO Services (service_id, organization_id, service_type_code, service_details) VALUES (2, 100, 'REPAIR', 'Repair');
INSERT INTO Services (service_id, organization_id, service_type_code, service_details) VALUES (3, 100, 'GARDEN', 'Gardening');
INSERT INTO Services (service_id, organization_id, service_type_code, service_details) VALUES (4, 100, 'PAINT', 'Painting');
INSERT INTO Residents_Services (resident_id, service_id, property_id, date_moved_in, date_requested, date_provided, other_details) VALUES (1, 1, 10, '2021-01-01 00:00:00', '2021-01-05 00:00:00', '2021-01-06 00:00:00', 'RS_1_1');
INSERT INTO Residents_Services (resident_id, service_id, property_id, date_moved_in, date_requested, date_provided, other_details) VALUES (1, 2, 10, '2021-01-01 00:00:00', '2021-01-07 00:00:00', NULL, 'RS_1_2');
INSERT INTO Residents_Services (resident_id, service_id, property_id, date_moved_in, date_requested, date_provided, other_details) VALUES (1, 3, 20, '2021-01-01 00:00:00', NULL, NULL, NULL);
INSERT INTO Residents_Services (resident_id, service_id, property_id, date_moved_in, date_requested, date_provided, other_details) VALUES (1, 4, 30, '2021-01-01 00:00:00', '2021-01-10 00:00:00', '2021-01-11 00:00:00', 'RS_1_4');
INSERT INTO Residents_Services (resident_id, service_id, property_id, date_moved_in, date_requested, date_provided, other_details) VALUES (2, 1, 20, '2021-02-01 00:00:00', '2021-02-05 00:00:00', '2021-02-06 00:00:00', 'RS_2_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT resident_id, other_details, n AS count___ FROM (SELECT LHS.resident_id AS resident_id, LHS.property_id AS property_id, LHS.date_moved_in AS date_moved_in, LHS.date_moved_out AS date_moved_out, LHS.other_details AS other_details, RHS.property_id AS property_id_other, RHS.n AS n FROM residents AS LHS INNER JOIN (SELECT property_id, resident_id, COUNT(*) AS n FROM residents_services GROUP BY property_id, resident_id) AS RHS ON (LHS.resident_id = RHS.resident_id)) ORDER BY resident_id, other_details NULLS LAST, count___ NULLS LAST;

/*
Gold Result:
(1, 'Res1_Details', 1)
(1, 'Res1_Details', 1)
(1, 'Res1_Details', 2)
(2, None, 1)
*/

-- Prediction Query
SELECT T1.resident_id, T1.other_details, COUNT(*) FROM Residents AS T1 JOIN Residents_Services AS T2 ON T1.resident_id = T2.resident_id GROUP BY T1.resident_id ORDER BY COUNT(*) DESC, T1.resident_id NULLS LAST, T1.other_details NULLS LAST;

/*
Prediction Result:
(1, 'Res1_Details', 4)
(2, None, 1)
*/