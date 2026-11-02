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
INSERT INTO Product_Categories (production_type_code, product_type_description, vat_rating) VALUES ('CAT1', 'Apparel', 0.20);
INSERT INTO Product_Categories (production_type_code, product_type_description, vat_rating) VALUES ('CAT2', 'Footwear', 0.15);
INSERT INTO Product_Categories (production_type_code, product_type_description, vat_rating) VALUES ('CAT3', 'Accessories', 0.10);
INSERT INTO Products (product_id, production_type_code, parent_product_id, unit_price, product_name, product_color, product_size) VALUES (1, 'CAT1', NULL, 30.00, 'P_Charlie', 'Red', 'M');
INSERT INTO Products (product_id, production_type_code, parent_product_id, unit_price, product_name, product_color, product_size) VALUES (2, 'CAT2', 1, 10.00, 'P_Alpha', 'Yellow', 'S');
INSERT INTO Products (product_id, production_type_code, parent_product_id, unit_price, product_name, product_color, product_size) VALUES (3, 'CAT3', NULL, 40.00, 'P_Delta', 'Blue', 'XL');
INSERT INTO Products (product_id, production_type_code, parent_product_id, unit_price, product_name, product_color, product_size) VALUES (4, 'CAT2', 1, 25.00, 'P_Echo', 'Red', 'L');
INSERT INTO Products (product_id, production_type_code, parent_product_id, unit_price, product_name, product_color, product_size) VALUES (5, 'CAT1', NULL, 20.00, 'P_Bravo', 'Green', 'XS');
INSERT INTO Products (product_id, production_type_code, parent_product_id, unit_price, product_name, product_color, product_size) VALUES (6, 'CAT3', 2, 15.00, 'P_Foxtrot', 'Yellow', 'M');
INSERT INTO Products (product_id, production_type_code, parent_product_id, unit_price, product_name, product_color, product_size) VALUES (7, 'CAT3', 3, 50.00, 'P_Golf', 'Red', 'S');
INSERT INTO Customers (customer_id, customer_first_name, customer_middle_initial, customer_last_name, gender, email_address, login_name, login_password, phone_number, town_city, state_county_province, country) VALUES (1, 'Alice', 'M', 'Smith', 'F', 'alice@example.com', 'alices', 'pass123', '555-0100', 'Boston', 'MA', 'USA');
INSERT INTO Orders (order_id, customer_id, date_order_placed, order_details) VALUES (10, 1, '2023-05-01 10:00:00', 'Standard Order');
INSERT INTO Order_Items (order_item_id, order_id, product_id, product_quantity, other_order_item_details) VALUES (100, 10, 1, '2', 'Shipped');
INSERT INTO Order_Items (order_item_id, order_id, product_id, product_quantity, other_order_item_details) VALUES (101, 10, 2, '1', 'Shipped');
INSERT INTO Invoices (invoice_number, order_id, invoice_date) VALUES (1000, 10, '2023-05-02 12:00:00');
INSERT INTO Invoice_Line_Items (product_id, invoice_number, order_item_id, product_title, product_quantity, product_price, derived_product_cost, derived_vat_payable, derived_total_cost) VALUES (1, 1000, 100, 'P_Charlie', '2', 30.00, 60.00, 12.00, 72.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT product_color FROM products ORDER BY product_color;

/*
Gold Result:
('Blue',)
('Green',)
('Red',)
('Yellow',)
*/

-- Prediction Query
SELECT DISTINCT product_color FROM Products;

/*
Prediction Result:
('Red',)
('Yellow',)
('Blue',)
('Green',)
*/