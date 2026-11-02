-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_phone, customer_email) VALUES (1, 'Aniyah', 'Feest', '2', 'b@example.com');
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name, customer_phone, customer_email) VALUES (2, 'Aniyah', 'Feest', '1', 'a@example.com');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "customer_phone", "customer_email" FROM "customers" WHERE ("customer_first_name" = 'Aniyah' AND "customer_last_name" = 'Feest') ORDER BY customer_phone, customers.customer_id NULLS LAST;

/*
Gold Result:
('1', 'a@example.com')
('2', 'b@example.com')
*/

-- Prediction Query
SELECT customer_phone, customer_email FROM Customers WHERE customer_first_name = 'Aniyah' AND customer_last_name = 'Feest';

/*
Prediction Result:
('2', 'b@example.com')
('1', 'a@example.com')
*/