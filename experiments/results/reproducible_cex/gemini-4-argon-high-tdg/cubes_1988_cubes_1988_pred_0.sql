-- Schema DDL
CREATE TABLE "Addresses" ("address_id" INTEGER PRIMARY KEY, "line_1_number_building" TEXT(80), "city" TEXT(50), "zip_postcode" TEXT(20), "state_province_county" TEXT(50), "country" TEXT(50));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "product_type_code" TEXT(15), "product_name" TEXT(80), "product_price" REAL);

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "payment_method_code" TEXT(15), "customer_number" TEXT(20), "customer_name" TEXT(80), "customer_address" TEXT(255), "customer_phone" TEXT(80), "customer_email" TEXT(80));

CREATE TABLE "Contacts" ("contact_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "gender" TEXT(1), "first_name" TEXT(80), "last_name" TEXT(50), "contact_phone" TEXT(80));

CREATE TABLE "Customer_Address_History" ("address_id" INTEGER, "customer_id" INTEGER, "date_from" DATETIME, "date_to" DATETIME, FOREIGN KEY ("address_id") REFERENCES "Addresses" ("address_id"), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Customer_Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATETIME, "order_status_code" TEXT(15), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Order_Items" ("order_id" INTEGER, "product_id" INTEGER, "order_item_id" INTEGER, "order_quantity" TEXT(80), FOREIGN KEY ("order_id") REFERENCES "Customer_Orders" ("order_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Products (product_id, product_type_code, product_name, product_price) VALUES (1, 'Books', 'SQL Guide', 45.0);
INSERT INTO Products (product_id, product_type_code, product_name, product_price) VALUES (2, 'Hardware', 'Mechanical Keyboard', 120.0);
INSERT INTO Products (product_id, product_type_code, product_name, product_price) VALUES (3, 'Electronics', 'USB Hub', 25.0);
INSERT INTO Products (product_id, product_type_code, product_name, product_price) VALUES (4, 'Apparel', 'Developer Hoodie', 60.0);
INSERT INTO Products (product_id, product_type_code, product_name, product_price) VALUES (5, 'Books', 'Algorithms Manual', 45.0);
INSERT INTO Products (product_id, product_type_code, product_name, product_price) VALUES (6, 'Electronics', 'HDMI Cable', 15.0);
INSERT INTO Products (product_id, product_type_code, product_name, product_price) VALUES (7, 'Hardware', 'USB Hub', 25.0);
INSERT INTO Customers (customer_id, payment_method_code, customer_number, customer_name, customer_address, customer_phone, customer_email) VALUES (1, 'CREDIT', 'CUST-001', 'Alice Smith', '100 Main St', '555-0101', 'alice@example.com');
INSERT INTO Customers (customer_id, payment_method_code, customer_number, customer_name, customer_address, customer_phone, customer_email) VALUES (2, 'DEBIT', 'CUST-002', 'Bob Jones', '200 Oak Ave', '555-0102', 'bob@example.com');
INSERT INTO Customer_Orders (order_id, customer_id, order_date, order_status_code) VALUES (101, 1, '2023-01-15 10:30:00', 'SHIPPED');
INSERT INTO Customer_Orders (order_id, customer_id, order_date, order_status_code) VALUES (102, 2, '2023-02-20 14:00:00', 'PENDING');
INSERT INTO Order_Items (order_id, product_id, order_item_id, order_quantity) VALUES (101, 1, 1, '2');
INSERT INTO Order_Items (order_id, product_id, order_item_id, order_quantity) VALUES (102, 1, 2, '1');
INSERT INTO Order_Items (order_id, product_id, order_item_id, order_quantity) VALUES (101, 3, 3, '5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT product_type_code FROM (SELECT product_id, product_type_code, COUNT(*) AS n FROM (SELECT LHS.product_id AS product_id, LHS.product_type_code AS product_type_code, LHS.product_name AS product_name, LHS.product_price AS product_price, RHS.product_type_code AS product_type_code_other, RHS.product_name AS product_name_other FROM products AS LHS INNER JOIN products AS RHS ON (LHS.product_id = RHS.product_id AND LHS.product_price = RHS.product_price)) GROUP BY product_id, product_type_code) ORDER BY product_type_code;

/*
Gold Result:
('Apparel',)
('Books',)
('Electronics',)
('Hardware',)
*/

-- Prediction Query
SELECT product_type_code FROM products GROUP BY product_type_code HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Books',)
('Electronics',)
('Hardware',)
*/