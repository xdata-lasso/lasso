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
-- DATASET 2
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name) VALUES (1, 'Charlie', 'Brown');
INSERT INTO Orders (order_id, customer_id, date_order_placed, order_details) VALUES (10, 1, '2023-02-01 09:00:00', 'Apparel Order');
INSERT INTO Product_Categories (production_type_code, product_type_description, vat_rating) VALUES ('APP', 'Apparel', 0.15);
INSERT INTO Products (product_id, production_type_code, parent_product_id, unit_price, product_name, product_color, product_size) VALUES (1, 'APP', NULL, 15.00, 'Classic Tee', 'White', 'S');
INSERT INTO Products (product_id, production_type_code, parent_product_id, unit_price, product_name, product_color, product_size) VALUES (2, 'APP', 1, 15.00, 'Classic Tee', 'White', 'L');
INSERT INTO Products (product_id, production_type_code, parent_product_id, unit_price, product_name, product_color, product_size) VALUES (3, 'APP', NULL, 45.00, 'Denim Jeans', 'Blue', 'M');
INSERT INTO Products (product_id, production_type_code, parent_product_id, unit_price, product_name, product_color, product_size) VALUES (4, 'APP', 3, 45.00, 'Denim Jeans', 'Black', 'M');
INSERT INTO Products (product_id, production_type_code, parent_product_id, unit_price, product_name, product_color, product_size) VALUES (5, 'APP', NULL, 25.00, 'Leather Belt', 'Brown', 'M');
INSERT INTO Products (product_id, production_type_code, parent_product_id, unit_price, product_name, product_color, product_size) VALUES (6, 'APP', NULL, 20.00, 'Wool Hat', 'Grey', 'OneSize');
INSERT INTO Order_Items (order_item_id, order_id, product_id, product_quantity, other_order_item_details) VALUES (100, 10, 3, '1', 'Blue Jeans Ordered');
INSERT INTO Order_Items (order_item_id, order_id, product_id, product_quantity, other_order_item_details) VALUES (101, 10, 6, '2', 'Hat Ordered');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_name FROM (SELECT * FROM products AS LHS WHERE NOT EXISTS(SELECT 1 FROM order_items AS RHS WHERE (LHS.product_id = RHS.product_id))) ORDER BY product_name;

/*
Gold Result:
('Classic Tee',)
('Classic Tee',)
('Denim Jeans',)
('Leather Belt',)
*/

-- Prediction Query
SELECT product_name FROM Products EXCEPT SELECT T1.product_name FROM Products AS T1 JOIN Order_items AS T2 ON T1.product_id = T2.product_id;

/*
Prediction Result:
('Classic Tee',)
('Leather Belt',)
*/