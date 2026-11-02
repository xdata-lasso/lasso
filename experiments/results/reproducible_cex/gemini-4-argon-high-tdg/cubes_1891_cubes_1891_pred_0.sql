-- Schema DDL
CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "product_name" TEXT(20), "product_price" REAL(19, 4), "product_description" TEXT(255));

CREATE TABLE "Addresses" ("address_id" INTEGER PRIMARY KEY, "address_details" TEXT(80), "city" TEXT(50), "zip_postcode" TEXT(20), "state_province_county" TEXT(50), "country" TEXT(50));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "payment_method" TEXT(10), "customer_name" TEXT(80), "customer_phone" TEXT(80), "customer_email" TEXT(80), "date_became_customer" DATETIME);

CREATE TABLE "Regular_Orders" ("regular_order_id" INTEGER PRIMARY KEY, "distributer_id" INTEGER, FOREIGN KEY ("distributer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Regular_Order_Products" ("regular_order_id" INTEGER, "product_id" INTEGER, FOREIGN KEY ("regular_order_id") REFERENCES "Regular_Orders" ("regular_order_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"));

CREATE TABLE "Actual_Orders" ("actual_order_id" INTEGER PRIMARY KEY, "regular_order_id" INTEGER, "order_status_code" TEXT(10), "actual_order_date" DATETIME, FOREIGN KEY ("regular_order_id") REFERENCES "Regular_Orders" ("regular_order_id"));

CREATE TABLE "Actual_Order_Products" ("actual_order_id" INTEGER, "product_id" INTEGER, FOREIGN KEY ("actual_order_id") REFERENCES "Actual_Orders" ("actual_order_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"));

CREATE TABLE "Customer_Addresses" ("address_id" INTEGER, "customer_id" INTEGER, "date_from" DATETIME, "address_type" TEXT(10), "date_to" DATETIME, FOREIGN KEY ("address_id") REFERENCES "Addresses" ("address_id"), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Delivery_Routes" ("route_id" INTEGER PRIMARY KEY, "route_name" TEXT(50), "other_route_details" TEXT(255));

CREATE TABLE "Delivery_Route_Locations" ("location_code" TEXT(10) PRIMARY KEY, "route_id" INTEGER, "location_address_id" INTEGER, "location_name" TEXT(50), FOREIGN KEY ("route_id") REFERENCES "Delivery_Routes" ("route_id"), FOREIGN KEY ("location_address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Trucks" ("truck_id" INTEGER PRIMARY KEY, "truck_licence_number" TEXT(20), "truck_details" TEXT(255));

CREATE TABLE "Employees" ("employee_id" INTEGER PRIMARY KEY, "employee_address_id" INTEGER, "employee_name" TEXT(80), "employee_phone" TEXT(80), FOREIGN KEY ("employee_address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Order_Deliveries" ("driver_employee_id" INTEGER, "location_code" TEXT(10), "actual_order_id" INTEGER, "truck_id" INTEGER, "delivery_status_code" TEXT(10), "delivery_date" DATETIME, FOREIGN KEY ("driver_employee_id") REFERENCES "Employees" ("employee_id"), FOREIGN KEY ("location_code") REFERENCES "Delivery_Route_Locations" ("location_code"), FOREIGN KEY ("actual_order_id") REFERENCES "Actual_Orders" ("actual_order_id"), FOREIGN KEY ("truck_id") REFERENCES "Trucks" ("truck_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Addresses (address_id, address_details, city, zip_postcode, state_province_county, country) VALUES (1, '10 Main St', 'Boston', '02101', 'MA', 'USA');
INSERT INTO Addresses (address_id, address_details, city, zip_postcode, state_province_county, country) VALUES (2, '20 Oak Ave', 'Boston', '02102', 'MA', 'USA');
INSERT INTO Addresses (address_id, address_details, city, zip_postcode, state_province_county, country) VALUES (3, '30 Pine Rd', 'Cambridge', '02139', 'MA', 'USA');
INSERT INTO Addresses (address_id, address_details, city, zip_postcode, state_province_county, country) VALUES (4, '40 Elm St', 'Somerville', '02143', 'MA', 'USA');
INSERT INTO Addresses (address_id, address_details, city, zip_postcode, state_province_county, country) VALUES (5, '50 Maple Dr', 'Brookline', '02445', 'MA', 'USA');
INSERT INTO Delivery_Routes (route_id, route_name, other_route_details) VALUES (1, 'Route 1', 'Details 1');
INSERT INTO Delivery_Routes (route_id, route_name, other_route_details) VALUES (2, 'Route 2', 'Details 2');
INSERT INTO Delivery_Routes (route_id, route_name, other_route_details) VALUES (3, 'Route 3', 'Details 3');
INSERT INTO Delivery_Routes (route_id, route_name, other_route_details) VALUES (4, 'Route 4', 'Details 4');
INSERT INTO Delivery_Routes (route_id, route_name, other_route_details) VALUES (5, 'Route 5', 'Details 5');
INSERT INTO Delivery_Routes (route_id, route_name, other_route_details) VALUES (6, 'Route 6', 'Details 6');
INSERT INTO Delivery_Routes (route_id, route_name, other_route_details) VALUES (10, 'Route 10', 'Details 10');
INSERT INTO Delivery_Route_Locations (location_code, route_id, location_address_id, location_name) VALUES ('L1', 10, 1, 'Loc A');
INSERT INTO Delivery_Route_Locations (location_code, route_id, location_address_id, location_name) VALUES ('L2', 10, 1, 'Loc B');
INSERT INTO Delivery_Route_Locations (location_code, route_id, location_address_id, location_name) VALUES ('L3', 10, 1, 'Loc B');
INSERT INTO Delivery_Route_Locations (location_code, route_id, location_address_id, location_name) VALUES ('L4', 10, 2, 'Loc C');
INSERT INTO Delivery_Route_Locations (location_code, route_id, location_address_id, location_name) VALUES ('L5', 10, 2, 'Loc D');
INSERT INTO Delivery_Route_Locations (location_code, route_id, location_address_id, location_name) VALUES ('L6', 10, 2, 'Loc D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT route_name FROM (SELECT LHS.route_id AS route_id, LHS.route_name AS route_name, LHS.other_route_details AS other_route_details FROM delivery_routes AS LHS INNER JOIN (SELECT COUNT(*) AS n FROM (SELECT location_address_id, COUNT(*) AS n FROM delivery_route_locations GROUP BY location_address_id)) AS RHS ON (LHS.route_id = RHS.n)) ORDER BY route_name;

/*
Gold Result:
('Route 2',)
*/

-- Prediction Query
SELECT t1.route_name FROM Delivery_Routes AS t1 JOIN Delivery_Route_Locations AS t2 ON t1.route_id = t2.route_id GROUP BY t1.route_id ORDER BY COUNT(*) DESC, t1.route_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Route 10',)
*/