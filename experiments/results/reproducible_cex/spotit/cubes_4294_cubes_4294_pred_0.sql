-- Schema DDL
CREATE TABLE "ACCOUNTS" (
    "ACCOUNT_ID" INT,
    "CUSTOMER_ID" INT,
    "ACCOUNT_NAME" TEXT,
    "OTHER_ACCOUNT_DETAILS" TEXT,
    PRIMARY KEY ("ACCOUNT_ID")
);
CREATE TABLE "CUSTOMERS" (
    "CUSTOMER_ID" INT,
    "CUSTOMER_FIRST_NAME" TEXT,
    "CUSTOMER_LAST_NAME" TEXT,
    "CUSTOMER_ADDRESS" TEXT,
    "CUSTOMER_PHONE" TEXT,
    "CUSTOMER_EMAIL" TEXT,
    "OTHER_CUSTOMER_DETAILS" TEXT,
    PRIMARY KEY ("CUSTOMER_ID")
);
CREATE TABLE "CUSTOMERS_CARDS" (
    "CARD_ID" INT,
    "CUSTOMER_ID" INT,
    "CARD_TYPE_CODE" TEXT,
    "CARD_NUMBER" TEXT,
    "DATE_VALID_FROM" DATETIME,
    "DATE_VALID_TO" DATETIME,
    "OTHER_CARD_DETAILS" TEXT,
    PRIMARY KEY ("CARD_ID")
);
CREATE TABLE "FINANCIAL_TRANSACTIONS" (
    "ACCOUNT_ID" INT,
    "CARD_ID" INT,
    "TRANSACTION_ID" INT,
    "PREVIOUS_TRANSACTION_ID" INT,
    "TRANSACTION_TYPE" TEXT,
    "TRANSACTION_DATE" DATETIME,
    "TRANSACTION_AMOUNT" FLOAT,
    "TRANSACTION_COMMENT" TEXT,
    "OTHER_TRANSACTION_DETAILS" TEXT,
    FOREIGN KEY ("ACCOUNT_ID") REFERENCES "ACCOUNTS"("ACCOUNT_ID"),
    FOREIGN KEY ("CARD_ID") REFERENCES "CUSTOMERS_CARDS"("CARD_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ACCOUNTS VALUES (0, 0, 0, 0);
INSERT INTO ACCOUNTS VALUES (1, 0, 0, 0);
INSERT INTO CUSTOMERS VALUES (1, -2, 0, 30, 2, 31, 32);
INSERT INTO CUSTOMERS VALUES (0, -3, 0, 37, 2, 38, 39);
INSERT INTO CUSTOMERS_CARDS VALUES (0, 1, 26, 4560596484842, 27, 28, 29);
INSERT INTO CUSTOMERS_CARDS VALUES (1, 0, 33, 4560596484842, 34, 35, 36);
INSERT INTO FINANCIAL_TRANSACTIONS VALUES (1, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO FINANCIAL_TRANSACTIONS VALUES (1, 0, 0, 0, 0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_first_name, customer_last_name, customer_phone FROM (SELECT LHS.customer_id AS customer_id, LHS.customer_first_name AS customer_first_name, LHS.customer_last_name AS customer_last_name, LHS.customer_address AS customer_address, LHS.customer_phone AS customer_phone, LHS.customer_email AS customer_email, LHS.other_customer_details AS other_customer_details, RHS.card_id AS card_id, RHS.card_type_code AS card_type_code, RHS.card_number AS card_number, RHS.date_valid_from AS date_valid_from, RHS.date_valid_to AS date_valid_to, RHS.other_card_details AS other_card_details FROM customers AS LHS INNER JOIN customers_cards AS RHS ON (LHS.customer_id = RHS.customer_id)) WHERE (card_number = 4560596484842.0) ORDER BY customer_first_name, customer_last_name NULLS LAST, customer_phone NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.customer_first_name, T2.customer_last_name, T2.customer_phone FROM Customers_cards AS T1 JOIN Customers AS T2 ON T1.customer_id = T2.customer_id WHERE T1.card_number = '4560596484842';

/*
Prediction Result:
('-2', '0', '2')
('-3', '0', '2')
*/