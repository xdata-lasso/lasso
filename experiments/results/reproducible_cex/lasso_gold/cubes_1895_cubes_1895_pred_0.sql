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
INSERT INTO "addresses" ("address_id", "address_details", "city", "zip_postcode", "state_province_county", "country") VALUES (1005, '83465 Lam Mission Apt. 331
Andrewside, IN 77629', 'North Chad', '83220', 'Arkansas', 'Denmark');
INSERT INTO "addresses" ("address_id", "address_details", "city", "zip_postcode", "state_province_county", "country") VALUES (1006, '60647 Henderson Street
Mooreport, IL 08166', 'Lake Leeton', '77070', 'Arkansas', 'Lesotho');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "date_became_customer") VALUES (1006, 'author', 'Shannon Jones', '547.938.2997', 'glee@example.net', '1980-11-11');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "customer_phone", "customer_email", "date_became_customer") VALUES (1007, 'morning', 'Kim Brown', '312.819.1361x93990', 'sarah35@example.org', '1985-05-16');
INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1005, 1006, '1981-01-12', '7010 Chandler Union Apt. 333
Taylorburgh, KY 61138', '1982-02-13');
INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1005, 1006, '1983-03-14', '8108 Tanya Terrace
East Richard, NJ 28517', '1984-04-15');
INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1006, 1007, '1986-06-17', '475 Albert Road
North Amandahaven, KS 17862', '1987-07-18');
INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1006, 1007, '1988-08-19', 'USS Suarez
FPO AA 37854', '1989-09-20');
INSERT INTO "customer_addresses" ("address_id", "customer_id", "date_from", "address_type", "date_to") VALUES (1006, 1007, '1988-08-20', 'USS Suarez
FPO AA 37854', '1989-09-20');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT state_province_county, n AS count___ FROM (SELECT LHS.address_id AS address_id, LHS.address_details AS address_details, LHS.city AS city, LHS.zip_postcode AS zip_postcode, LHS.state_province_county AS state_province_county, LHS.country AS country, LHS.customer_id AS customer_id, LHS.date_from AS date_from, LHS.address_type AS address_type, LHS.date_to AS date_to, RHS.n AS n FROM (SELECT LHS.address_id AS address_id, LHS.address_details AS address_details, LHS.city AS city, LHS.zip_postcode AS zip_postcode, LHS.state_province_county AS state_province_county, LHS.country AS country, RHS.customer_id AS customer_id, RHS.date_from AS date_from, RHS.address_type AS address_type, RHS.date_to AS date_to FROM addresses AS LHS INNER JOIN customer_addresses AS RHS ON (LHS.address_id = RHS.address_id)) AS LHS INNER JOIN (SELECT address_id, COUNT(*) AS n FROM customer_addresses GROUP BY address_id) AS RHS ON (LHS.address_id = RHS.address_id)) ORDER BY state_province_county, count___ NULLS LAST;

/*
Gold Result:
('Arkansas', 2)
('Arkansas', 3)
*/

-- Prediction Query
SELECT t2.state_province_county, COUNT(*) FROM customer_addresses AS t1 JOIN addresses AS t2 ON t1.address_id = t2.address_id GROUP BY t2.state_province_county;

/*
Prediction Result:
('Arkansas', 5)
*/