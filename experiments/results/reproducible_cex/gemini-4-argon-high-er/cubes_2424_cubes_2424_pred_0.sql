-- Schema DDL
CREATE TABLE "Addresses" ("address_id" INTEGER PRIMARY KEY, "address_content" TEXT(80), "city" TEXT(50), "zip_postcode" TEXT(20), "state_province_county" TEXT(50), "country" TEXT(50), "other_address_details" TEXT(255));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "product_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "payment_method" TEXT(15), "customer_name" TEXT(80), "date_became_customer" DATETIME, "other_customer_details" TEXT(255));

CREATE TABLE "Customer_Addresses" ("customer_id" INTEGER, "address_id" INTEGER, "date_address_from" DATETIME, "address_type" TEXT(15), "date_address_to" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Customer_Contact_Channels" ("customer_id" INTEGER, "channel_code" TEXT(15), "active_from_date" DATETIME, "active_to_date" DATETIME, "contact_number" TEXT(50), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Customer_Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_status" TEXT(15), "order_date" DATETIME, "order_details" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Order_Items" ("order_id" INTEGER, "product_id" INTEGER, "order_quantity" TEXT(15), FOREIGN KEY ("order_id") REFERENCES "Customer_Orders" ("order_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Products (product_id, product_details) VALUES (1, 'Book');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (1, 'Card', 'Alice', '2020-01-01 00:00:00', 'None');
INSERT INTO Customer_Orders (order_id, customer_id, order_status, order_date, order_details) VALUES (2, 1, 'Completed', '2020-01-02 00:00:00', 'None');
INSERT INTO Order_Items (order_id, product_id, order_quantity) VALUES (2, 1, '5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT customer_name FROM (SELECT customer_id AS order_id, customer_id, order_status, order_date, order_details, payment_method, customer_name, date_became_customer, other_customer_details, order_status_other, order_date_other, order_details_other, product_id, order_quantity FROM (SELECT LHS.order_id AS order_id, LHS.customer_id AS customer_id, LHS.order_status AS order_status, LHS.order_date AS order_date, LHS.order_details AS order_details, RHS.payment_method AS payment_method, RHS.customer_name AS customer_name, RHS.date_became_customer AS date_became_customer, RHS.other_customer_details AS other_customer_details, RHS.order_status AS order_status_other, RHS.order_date AS order_date_other, RHS.order_details AS order_details_other, RHS.product_id AS product_id, RHS.order_quantity AS order_quantity FROM customer_orders AS LHS INNER JOIN (SELECT LHS.customer_id AS customer_id, LHS.payment_method AS payment_method, LHS.customer_name AS customer_name, LHS.date_became_customer AS date_became_customer, LHS.other_customer_details AS other_customer_details, LHS.order_id AS order_id, LHS.order_status AS order_status, LHS.order_date AS order_date, LHS.order_details AS order_details, RHS.product_id AS product_id, RHS.order_quantity AS order_quantity FROM (SELECT LHS.customer_id AS customer_id, LHS.payment_method AS payment_method, LHS.customer_name AS customer_name, LHS.date_became_customer AS date_became_customer, LHS.other_customer_details AS other_customer_details, RHS.order_id AS order_id, RHS.order_status AS order_status, RHS.order_date AS order_date, RHS.order_details AS order_details FROM customers AS LHS INNER JOIN customer_orders AS RHS ON (LHS.customer_id = RHS.customer_id)) AS LHS INNER JOIN order_items AS RHS ON (LHS.order_id = RHS.order_id)) AS RHS ON (LHS.customer_id = RHS.order_id AND LHS.order_id = RHS.customer_id))) ORDER BY customer_name;

/*
Gold Result:
*/

-- Prediction Query
SELECT t1.customer_name FROM customers AS t1 JOIN customer_orders AS t2 ON t1.customer_id = t2.customer_id JOIN order_items AS t3 ON t2.order_id = t3.order_id GROUP BY t1.customer_name ORDER BY SUM(t3.order_quantity) DESC, t1.customer_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alice',)
*/