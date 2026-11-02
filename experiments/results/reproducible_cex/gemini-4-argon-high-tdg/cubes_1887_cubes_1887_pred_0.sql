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
INSERT INTO Trucks (truck_id, truck_licence_number, truck_details) VALUES (1, 'LIC-100', 'Zebra Hauler');
INSERT INTO Trucks (truck_id, truck_licence_number, truck_details) VALUES (2, 'LIC-300', 'Alpha Van');
INSERT INTO Trucks (truck_id, truck_licence_number, truck_details) VALUES (3, 'LIC-200', 'Mega Lorry');
INSERT INTO Addresses (address_id, address_details, city, zip_postcode, state_province_county, country) VALUES (1, '10 Main St', 'Metropolis', '10001', 'NY', 'USA');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, date_became_customer) VALUES (1, 'Credit', 'Acme Corp', '555-0100', 'info@acme.com', '2022-01-01 00:00:00');
INSERT INTO Regular_Orders (regular_order_id, distributer_id) VALUES (1, 1);
INSERT INTO Actual_Orders (actual_order_id, regular_order_id, order_status_code, actual_order_date) VALUES (1, 1, 'DELIVERED', '2023-05-01 10:00:00');
INSERT INTO Actual_Orders (actual_order_id, regular_order_id, order_status_code, actual_order_date) VALUES (2, 1, 'PENDING', '2023-05-02 11:00:00');
INSERT INTO Delivery_Routes (route_id, route_name, other_route_details) VALUES (1, 'North Route', 'Standard');
INSERT INTO Delivery_Route_Locations (location_code, route_id, location_address_id, location_name) VALUES ('LOC-1', 1, 1, 'Warehouse A');
INSERT INTO Employees (employee_id, employee_address_id, employee_name, employee_phone) VALUES (1, 1, 'John Doe', '555-0199');
INSERT INTO Order_Deliveries (driver_employee_id, location_code, actual_order_id, truck_id, delivery_status_code, delivery_date) VALUES (1, 'LOC-1', 1, 1, 'DONE', '2023-05-01 14:00:00');
INSERT INTO Order_Deliveries (driver_employee_id, location_code, actual_order_id, truck_id, delivery_status_code, delivery_date) VALUES (1, 'LOC-1', 2, 1, 'DONE', '2023-05-02 15:00:00');
INSERT INTO Order_Deliveries (driver_employee_id, location_code, actual_order_id, truck_id, delivery_status_code, delivery_date) VALUES (1, 'LOC-1', 1, 2, 'TRANSIT', '2023-05-03 09:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT truck_details FROM trucks ORDER BY truck_details, trucks.truck_id NULLS LAST;

/*
Gold Result:
('Alpha Van',)
('Mega Lorry',)
('Zebra Hauler',)
*/

-- Prediction Query
SELECT truck_details FROM trucks ORDER BY truck_licence_number, trucks.truck_id NULLS LAST;

/*
Prediction Result:
('Zebra Hauler',)
('Mega Lorry',)
('Alpha Van',)
*/