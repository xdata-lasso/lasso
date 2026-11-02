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
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, date_became_customer) VALUES (1, 'Visa', 'Zack Adams', '555-0101', 'm_user@example.com', '2022-03-15 10:00:00');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, date_became_customer) VALUES (2, 'Visa', 'Alice Brown', '555-0102', 'z_user@example.com', '2021-01-10 08:30:00');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, date_became_customer) VALUES (3, 'Visa', 'Mike Clark', '555-0103', 'a_user@example.com', '2023-07-20 14:15:00');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, date_became_customer) VALUES (4, 'MasterCard', 'Bob Davis', '555-0104', 'b_user@example.com', '2020-05-01 09:00:00');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, date_became_customer) VALUES (5, 'Cash', 'Eve Evans', '555-0105', 'e_user@example.com', '2019-11-11 11:11:00');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, date_became_customer) VALUES (6, NULL, 'Null Pay', '555-0106', 'n_user@example.com', '2022-08-08 12:00:00');
INSERT INTO Addresses (address_id, address_details, city, zip_postcode, state_province_county, country) VALUES (1, '100 Main St', 'Seattle', '98101', 'WA', 'USA');
INSERT INTO Addresses (address_id, address_details, city, zip_postcode, state_province_county, country) VALUES (2, '200 Oak Ave', 'Portland', '97201', 'OR', 'USA');
INSERT INTO Customer_Addresses (address_id, customer_id, date_from, address_type, date_to) VALUES (1, 1, '2022-03-15 00:00:00', 'Billing', '2023-03-15 00:00:00');
INSERT INTO Customer_Addresses (address_id, customer_id, date_from, address_type, date_to) VALUES (2, 1, '2023-03-16 00:00:00', 'Shipping', NULL);
INSERT INTO Customer_Addresses (address_id, customer_id, date_from, address_type, date_to) VALUES (1, 4, '2020-05-01 00:00:00', 'Billing', NULL);
INSERT INTO Regular_Orders (regular_order_id, distributer_id) VALUES (10, 1);
INSERT INTO Regular_Orders (regular_order_id, distributer_id) VALUES (11, 1);
INSERT INTO Regular_Orders (regular_order_id, distributer_id) VALUES (12, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "customer_email", "customer_name" FROM "customers" WHERE ("payment_method" = 'Visa') ORDER BY customer_email, customers.customer_id NULLS LAST;

/*
Gold Result:
('a_user@example.com', 'Mike Clark')
('m_user@example.com', 'Zack Adams')
('z_user@example.com', 'Alice Brown')
*/

-- Prediction Query
SELECT customer_email, customer_name FROM customers WHERE payment_method = 'Visa';

/*
Prediction Result:
('m_user@example.com', 'Zack Adams')
('z_user@example.com', 'Alice Brown')
('a_user@example.com', 'Mike Clark')
*/