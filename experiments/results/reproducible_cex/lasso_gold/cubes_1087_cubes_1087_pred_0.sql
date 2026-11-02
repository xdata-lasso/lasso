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
INSERT INTO "customers" ("customer_id", "customer_first_name", "customer_middle_initial", "customer_last_name", "gender", "email_address", "login_name", "login_password", "phone_number", "town_city", "state_county_province", "country") VALUES (1001, 'Danielle', 'dog', 'Garcia', 'performance', 'davisjesse@example.net', 'Abigail Shaffer', 'bill', '(794)507-8161x849', 'East Lydiamouth', 'Montana', 'Cambodia');
INSERT INTO "customers" ("customer_id", "customer_first_name", "customer_middle_initial", "customer_last_name", "gender", "email_address", "login_name", "login_password", "phone_number", "town_city", "state_county_province", "country") VALUES (1002, 'Angel', 'chair', 'Yang', 'knowledge', 'hoffmanjennifer@example.net', 'Gina Moore', 'her', '001-410-734-1316x475', 'Adamsborough', 'Tennessee', 'Estonia');
INSERT INTO "customers" ("customer_id", "customer_first_name", "customer_middle_initial", "customer_last_name", "gender", "email_address", "login_name", "login_password", "phone_number", "town_city", "state_county_province", "country") VALUES (1003, 'Joshua', 'since', 'Gardner', 'almost', 'lrobinson@example.com', 'Gabrielle Davis', 'throw', '(534)719-2832x764', 'Jasonfort', 'New Jersey', 'Burundi');
INSERT INTO "accounts" ("account_id", "customer_id", "date_account_opened", "account_name", "other_account_details") VALUES (1004, 1001, '1970-01-01', 'Justin Baker', 'benefit');
INSERT INTO "accounts" ("account_id", "customer_id", "date_account_opened", "account_name", "other_account_details") VALUES (1005, 1001, '1970-01-02', 'Stephanie Ross', 'someone');
INSERT INTO "accounts" ("account_id", "customer_id", "date_account_opened", "account_name", "other_account_details") VALUES (1006, 1001, '1970-01-03', 'Zachary Hicks', 'anyone');
INSERT INTO "orders" ("order_id", "customer_id", "date_order_placed", "order_details") VALUES (1007, 1001, '1973-04-04', 'traditional');
INSERT INTO "orders" ("order_id", "customer_id", "date_order_placed", "order_details") VALUES (1008, 1001, '1973-04-05', 'break');
INSERT INTO "orders" ("order_id", "customer_id", "date_order_placed", "order_details") VALUES (1009, 1001, '1973-04-06', 'claim');
INSERT INTO "invoices" ("invoice_number", "order_id", "invoice_date") VALUES (1010, 1007, '1976-07-07');
INSERT INTO "invoices" ("invoice_number", "order_id", "invoice_date") VALUES (1011, 1007, '1976-07-08');
INSERT INTO "invoices" ("invoice_number", "order_id", "invoice_date") VALUES (1012, 1007, '1976-07-09');
INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1004, 1010, 1013, 'product', '1979-10-10', 1016.5, 'Others his other life edge network.', 'seven');
INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1004, 1010, 1020.0, 'collection', '1979-10-11', 1029.5, 'Quite boy those.', 'type');
INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1004, 1010, 1027.0, 'structure', '1979-10-12', 1042.5, 'Shoulder future fall citizen about.', 'serve');
INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1004, 1010, 1019, 'everyone', '1982-02-13', 1022.5, 'Medical blood personal success.', 'effect');
INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1004, 1010, 1026.0, 'month', '1982-02-14', 1035.5, 'Participant check several much single morning a.', 'unit');
INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1004, 1010, 1033.0, 'sound', '1982-02-15', 1048.5, 'Major born guy world southern dream.', 'our');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT transaction_id_other AS transaction_id FROM (SELECT LHS.transaction_id AS transaction_id, LHS.account_id AS account_id, LHS.invoice_number AS invoice_number, LHS.transaction_type AS transaction_type, LHS.transaction_date AS transaction_date, LHS.transaction_amount AS transaction_amount, LHS.transaction_comment AS transaction_comment, LHS.other_transaction_details AS other_transaction_details, LHS.meantransaction_amount AS meantransaction_amount, RHS.transaction_id AS transaction_id_other, RHS.account_id AS account_id_other, RHS.invoice_number AS invoice_number_other, RHS.transaction_type AS transaction_type_other, RHS.transaction_date AS transaction_date_other, RHS.transaction_amount AS transaction_amount_other, RHS.transaction_comment AS transaction_comment_other, RHS.other_transaction_details AS other_transaction_details_other FROM (SELECT transaction_id, account_id, invoice_number, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details, AVG(transaction_amount) OVER () AS meantransaction_amount FROM financial_transactions) AS LHS CROSS JOIN financial_transactions AS RHS) WHERE (transaction_amount < transaction_amount_other AND meantransaction_amount <= transaction_amount_other) ORDER BY transaction_id;

/*
Gold Result:
(1026,)
(1027,)
(1033,)
*/

-- Prediction Query
SELECT transaction_id FROM Financial_transactions WHERE transaction_amount > (SELECT AVG(transaction_amount) FROM Financial_transactions);

/*
Prediction Result:
(1027,)
(1026,)
(1033,)
*/