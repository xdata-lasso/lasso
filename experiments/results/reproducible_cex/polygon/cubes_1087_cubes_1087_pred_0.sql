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
INSERT INTO "Customers" ("customer_id", "customer_first_name", "customer_middle_initial", "customer_last_name", "gender", "email_address", "login_name", "login_password", "phone_number", "town_city", "state_county_province", "country") VALUES (20, '36', '36', '36', '36', '36', '36', '36', '36', '36', '36', '36');
INSERT INTO "Orders" ("order_id", "customer_id", "date_order_placed", "order_details") VALUES (21, 20, 36, '36');
INSERT INTO "Invoices" ("invoice_number", "order_id", "invoice_date") VALUES (36, 21, 36);
INSERT INTO "Accounts" ("account_id", "customer_id", "date_account_opened", "account_name", "other_account_details") VALUES (35, 20, 36, '36', '36');
INSERT INTO "Product_Categories" ("production_type_code", "product_type_description", "vat_rating") VALUES ('23', '36', 36);
INSERT INTO "Product_Categories" ("production_type_code", "product_type_description", "vat_rating") VALUES ('22', '36', 36);
INSERT INTO "Products" ("product_id", "production_type_code", "parent_product_id", "unit_price", "product_name", "product_color", "product_size") VALUES (24, '23', 36, 36, '36', '36', '36');
INSERT INTO "Financial_Transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (35, 36, 51, '37', 38, -714, '39', '40');
INSERT INTO "Financial_Transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (NULL, NULL, 43, NULL, NULL, -715, NULL, NULL);
INSERT INTO "Order_Items" ("order_item_id", "order_id", "product_id", "product_quantity", "other_order_item_details") VALUES (25, 21, 24, '36', '36');
INSERT INTO "Invoice_Line_Items" ("product_id", "invoice_number", "order_item_id", "product_title", "product_quantity", "product_price", "derived_product_cost", "derived_vat_payable", "derived_total_cost") VALUES (24, 36, 25, '36', '36', 36, 36, 36, 36);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT transaction_id_other AS transaction_id FROM (SELECT LHS.transaction_id AS transaction_id, LHS.account_id AS account_id, LHS.invoice_number AS invoice_number, LHS.transaction_type AS transaction_type, LHS.transaction_date AS transaction_date, LHS.transaction_amount AS transaction_amount, LHS.transaction_comment AS transaction_comment, LHS.other_transaction_details AS other_transaction_details, LHS.meantransaction_amount AS meantransaction_amount, RHS.transaction_id AS transaction_id_other, RHS.account_id AS account_id_other, RHS.invoice_number AS invoice_number_other, RHS.transaction_type AS transaction_type_other, RHS.transaction_date AS transaction_date_other, RHS.transaction_amount AS transaction_amount_other, RHS.transaction_comment AS transaction_comment_other, RHS.other_transaction_details AS other_transaction_details_other FROM (SELECT transaction_id, account_id, invoice_number, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details, AVG(transaction_amount) OVER () AS meantransaction_amount FROM financial_transactions) AS LHS CROSS JOIN financial_transactions AS RHS) WHERE (transaction_amount < transaction_amount_other AND meantransaction_amount <= transaction_amount_other) ORDER BY transaction_id;

/*
Gold Result:
(51,)
*/

-- Prediction Query
SELECT transaction_id FROM Financial_transactions WHERE transaction_amount > (SELECT AVG(transaction_amount) FROM Financial_transactions);

/*
Prediction Result:
(51,)
*/