-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(50), "customer_middle_initial" TEXT(1), "customer_last_name" TEXT(50), "gender" TEXT(1), "email_address" TEXT(255), "login_name" TEXT(80), "login_password" TEXT(20), "phone_number" TEXT(255), "town_city" TEXT(50), "state_county_province" TEXT(50), "country" TEXT(50));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "date_order_placed" DATETIME, "order_details" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_number" INTEGER PRIMARY KEY, "order_id" INTEGER, "invoice_date" DATETIME, FOREIGN KEY ("order_id") REFERENCES "Orders" ("order_id"));

CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "date_account_opened" DATETIME, "account_name" TEXT(50), "other_account_details" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Product_Categories" ("production_type_code" TEXT(15) PRIMARY KEY, "product_type_description" TEXT(80), "vat_rating" REAL(19, 4));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "production_type_code" TEXT(15), "parent_product_id" INTEGER, "unit_price" REAL(19, 4), "product_name" TEXT(80), "product_color" TEXT(20), "product_size" TEXT(20), FOREIGN KEY ("production_type_code") REFERENCES "Product_Categories" ("production_type_code"));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "invoice_number" INTEGER, "transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL(19, 4), "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("invoice_number") REFERENCES "Invoices" ("invoice_number"));

CREATE TABLE "Order_Items" ("order_item_id" INTEGER PRIMARY KEY, "order_id" INTEGER, "product_id" INTEGER, "product_quantity" TEXT(50), "other_order_item_details" TEXT(255), FOREIGN KEY ("order_id") REFERENCES "Orders" ("order_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"));

CREATE TABLE "Invoice_Line_Items" ("product_id" INTEGER, "invoice_number" INTEGER, "order_item_id" INTEGER, "product_title" TEXT(80), "product_quantity" TEXT(50), "product_price" REAL(19, 4), "derived_product_cost" REAL(19, 4), "derived_vat_payable" REAL(19, 4), "derived_total_cost" REAL(19, 4), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("invoice_number") REFERENCES "Invoices" ("invoice_number"), FOREIGN KEY ("order_item_id") REFERENCES "Order_Items" ("order_item_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Missing DISTINCT (duplicate 'M' values)
-- 2. Missing or reversed ORDER BY (inserted out of alphabetical order: 'XL', 'M', 'S', 'M', 'L')
-- 3. Unnecessary INNER JOIN with Order_Items or Invoice_Line_Items (Products 4 and 5 are not ordered)
-- 4. Unnecessary INNER JOIN with Product_Categories (Product 5 has NULL production_type_code)
-- 5. Incorrect column selection (product_color, product_name, etc. have distinct values from product_size)
-- 6. Unnecessary WHERE filters on parent_product_id or unit_price (mix of NULL, non-NULL, 0, positive)
INSERT INTO Product_Categories (production_type_code, product_type_description, vat_rating) VALUES ('APPAREL', 'Clothing and Apparel', 0.2000);
INSERT INTO Product_Categories (production_type_code, product_type_description, vat_rating) VALUES ('FOOTWEAR', 'Shoes and Boots', 0.1500);
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name) VALUES (1, 'Alice', 'Smith');
INSERT INTO Orders (order_id, customer_id, date_order_placed, order_details) VALUES (10, 1, '2023-05-01 10:00:00', 'Standard Order');
INSERT INTO Products (product_id, production_type_code, parent_product_id, unit_price, product_name, product_color, product_size) VALUES (1, 'APPAREL', NULL, 29.9900, 'Jacket', 'Blue', 'XL');
INSERT INTO Products (product_id, production_type_code, parent_product_id, unit_price, product_name, product_color, product_size) VALUES (2, 'APPAREL', 1, 19.9900, 'T-Shirt', 'Red', 'M');
INSERT INTO Products (product_id, production_type_code, parent_product_id, unit_price, product_name, product_color, product_size) VALUES (3, 'FOOTWEAR', NULL, 49.9900, 'Sneakers', 'White', 'S');
INSERT INTO Products (product_id, production_type_code, parent_product_id, unit_price, product_name, product_color, product_size) VALUES (4, 'FOOTWEAR', 3, 49.9900, 'Boots', 'Black', 'M');
INSERT INTO Products (product_id, production_type_code, parent_product_id, unit_price, product_name, product_color, product_size) VALUES (5, NULL, NULL, 0.0000, 'Belt', 'Brown', 'L');
INSERT INTO Order_Items (order_item_id, order_id, product_id, product_quantity, other_order_item_details) VALUES (100, 10, 1, '1', 'None');
INSERT INTO Order_Items (order_item_id, order_id, product_id, product_quantity, other_order_item_details) VALUES (101, 10, 2, '3', 'Gift');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT product_size FROM products ORDER BY product_size;

/*
Gold Result:
('L',)
('M',)
('S',)
('XL',)
*/

-- Prediction Query
SELECT DISTINCT product_size FROM Products;

/*
Prediction Result:
('XL',)
('M',)
('S',)
('L',)
*/