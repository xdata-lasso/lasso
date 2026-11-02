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
INSERT INTO "customers" ("customer_id", "customer_first_name", "customer_middle_initial", "customer_last_name", "gender", "email_address", "login_name", "login_password", "phone_number", "town_city", "state_county_province", "country") VALUES (1050, 'Dale', 'unit', 'Taylor', 'business', 'newtoneric@example.com', 'Michelle Harris', 'protect', '687-440-1640x052', 'Arnoldchester', 'Oklahoma', 'Algeria');
INSERT INTO "customers" ("customer_id", "customer_first_name", "customer_middle_initial", "customer_last_name", "gender", "email_address", "login_name", "login_password", "phone_number", "town_city", "state_county_province", "country") VALUES (1061, 'Bill', 'help', 'Clark', 'enjoy', 'gomezanita@example.com', 'Nicole Frost', 'economic', '(426)302-5634', 'Brennanfort', 'Iowa', 'Cook Islands');
INSERT INTO "accounts" ("account_id", "customer_id", "date_account_opened", "account_name", "other_account_details") VALUES (1051, 1050, '1973-11-10', 'Tony Vazquez', 'church');
INSERT INTO "accounts" ("account_id", "customer_id", "date_account_opened", "account_name", "other_account_details") VALUES (1056, 1050, '1977-04-14', 'Julia Torres', 'stuff');
INSERT INTO "orders" ("order_id", "customer_id", "date_order_placed", "order_details") VALUES (1052, 1050, '1974-01-11', 'offer');
INSERT INTO "orders" ("order_id", "customer_id", "date_order_placed", "order_details") VALUES (1057, 1050, '1978-05-15', 'try');
INSERT INTO "invoices" ("invoice_number", "order_id", "invoice_date") VALUES (1053, 1052, '1975-02-12');
INSERT INTO "invoices" ("invoice_number", "order_id", "invoice_date") VALUES (1058, 1057, '1979-06-16');
INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1051, 1053, 1054, 'also', '1976-03-13', 1055.5, 'Old challenge camera final together someone.', 'traditional');
INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1056, 1058, 1059, 'drive', '1980-07-17', 1060.5, 'Age cover foreign ten whom.', 'family');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT account_name, account_id, n AS count___ FROM (SELECT LHS.account_id AS account_id, LHS.n AS n, RHS.customer_id AS customer_id, RHS.date_account_opened AS date_account_opened, RHS.account_name AS account_name, RHS.other_account_details AS other_account_details FROM (SELECT account_id, COUNT(*) AS n FROM financial_transactions GROUP BY account_id) AS LHS INNER JOIN accounts AS RHS ON (LHS.account_id = RHS.account_id)) ORDER BY account_name, account_id NULLS LAST, count___ NULLS LAST;

/*
Gold Result:
('Julia Torres', 1056, 1)
('Tony Vazquez', 1051, 1)
*/

-- Prediction Query
SELECT T2.account_name, T1.account_id, COUNT(*) FROM Financial_transactions AS T1 JOIN Accounts AS T2 ON T1.account_id = T2.account_id GROUP BY T1.account_id;

/*
Prediction Result:
('Tony Vazquez', 1051, 1)
('Julia Torres', 1056, 1)
*/