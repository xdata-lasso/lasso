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
INSERT INTO "Products" ("product_id", "product_name", "product_price", "product_description") VALUES (21, '0', 0, '0');
INSERT INTO "Products" ("product_id", "product_name", "product_price", "product_description") VALUES (20, '0', 0, '0');
INSERT INTO "Addresses" ("address_id", "address_details", "city", "zip_postcode", "state_province_county", "country") VALUES (23, '0', '0', '0', '0', '0');
INSERT INTO "Addresses" ("address_id", "address_details", "city", "zip_postcode", "state_province_county", "country") VALUES (22, '0', '0', '0', '0', '0');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "date_became_customer") VALUES (0, '36', '38', '39', '40', 41);
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "date_became_customer") VALUES (24, '37', '0', '0', '0', 0);
INSERT INTO "Regular_Orders" ("regular_order_id", "distributer_id") VALUES (26, 0);
INSERT INTO "Regular_Orders" ("regular_order_id", "distributer_id") VALUES (25, NULL);
INSERT INTO "Regular_Order_Products" ("regular_order_id", "product_id") VALUES (26, 21);
INSERT INTO "Regular_Order_Products" ("regular_order_id", "product_id") VALUES (25, 20);
INSERT INTO "Actual_Orders" ("actual_order_id", "regular_order_id", "order_status_code", "actual_order_date") VALUES (27, 25, '0', 0);
INSERT INTO "Actual_Order_Products" ("actual_order_id", "product_id") VALUES (27, 20);
INSERT INTO "Customer_Addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (22, NULL, 0, '0', 0);
INSERT INTO "Customer_Addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (22, 0, 0, '0', 0);
INSERT INTO "Delivery_Routes" ("route_id", "route_name", "other_route_details") VALUES (29, '0', '0');
INSERT INTO "Delivery_Routes" ("route_id", "route_name", "other_route_details") VALUES (28, '0', '0');
INSERT INTO "Delivery_Route_Locations" ("location_code", "route_id", "location_address_id", "location_name") VALUES ('31', 28, 22, '0');
INSERT INTO "Delivery_Route_Locations" ("location_code", "route_id", "location_address_id", "location_name") VALUES ('30', NULL, 22, '0');
INSERT INTO "Trucks" ("truck_id", "truck_licence_number", "truck_details") VALUES (33, '0', '0');
INSERT INTO "Trucks" ("truck_id", "truck_licence_number", "truck_details") VALUES (32, '0', '0');
INSERT INTO "Employees" ("employee_id", "employee_address_id", "employee_name", "employee_phone") VALUES (35, 22, '0', '0');
INSERT INTO "Employees" ("employee_id", "employee_address_id", "employee_name", "employee_phone") VALUES (34, 22, '0', '0');
INSERT INTO "Order_Deliveries" ("driver_employee_id", "location_code", "actual_order_id", "truck_id", "delivery_status_code", "delivery_date") VALUES (35, '30', 27, 32, '0', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT payment_method FROM (SELECT customer_id, payment_method, customer_name, customer_phone, customer_email, date_became_customer, customer_id AS n, payment_method_other, customer_name_other, customer_phone_other, customer_email_other, date_became_customer_other FROM (SELECT LHS.customer_id AS customer_id, LHS.payment_method AS payment_method, LHS.customer_name AS customer_name, LHS.customer_phone AS customer_phone, LHS.customer_email AS customer_email, LHS.date_became_customer AS date_became_customer, LHS.n AS n, RHS.payment_method AS payment_method_other, RHS.customer_name AS customer_name_other, RHS.customer_phone AS customer_phone_other, RHS.customer_email AS customer_email_other, RHS.date_became_customer AS date_became_customer_other FROM (SELECT customer_id, payment_method, customer_name, customer_phone, customer_email, date_became_customer, COUNT(*) OVER () AS n FROM customers) AS LHS INNER JOIN (SELECT customer_id, payment_method, customer_name, customer_phone, customer_email, date_became_customer, COUNT(*) OVER () AS n FROM customers) AS RHS ON (LHS.customer_id = RHS.n AND LHS.n = RHS.customer_id))) ORDER BY payment_method;

/*
Gold Result:
*/

-- Prediction Query
SELECT payment_method FROM Customers GROUP BY payment_method ORDER BY COUNT(*) DESC, payment_method NULLS LAST LIMIT 1;

/*
Prediction Result:
('36',)
*/