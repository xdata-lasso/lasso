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
INSERT INTO ACCOUNTS VALUES (0, 1, 162, 27);
INSERT INTO ACCOUNTS VALUES (-1, 0, 162, 31);
INSERT INTO CUSTOMERS VALUES (0, -3, 0, 28, 1, 29, 30);
INSERT INTO CUSTOMERS VALUES (1, -2, 1, 32, 1, 33, 34);
INSERT INTO CUSTOMERS_CARDS VALUES (0, 0, 0, 0, 0, 0, 0);
INSERT INTO CUSTOMERS_CARDS VALUES (1, 0, 0, 0, 0, 0, 0);
INSERT INTO FINANCIAL_TRANSACTIONS VALUES (-1, 1, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO FINANCIAL_TRANSACTIONS VALUES (0, 1, 0, 0, 0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_first_name, customer_last_name, customer_phone FROM (SELECT LHS.account_id AS account_id, LHS.customer_id AS customer_id, LHS.account_name AS account_name, LHS.other_account_details AS other_account_details, RHS.customer_first_name AS customer_first_name, RHS.customer_last_name AS customer_last_name, RHS.customer_address AS customer_address, RHS.customer_phone AS customer_phone, RHS.customer_email AS customer_email, RHS.other_customer_details AS other_customer_details FROM accounts AS LHS INNER JOIN customers AS RHS ON (LHS.customer_id = RHS.customer_id)) WHERE (account_name = 162) ORDER BY customer_first_name, customer_last_name NULLS LAST, customer_phone NULLS LAST;

/*
Gold Result:
('-2', '1', '1')
('-3', '0', '1')
*/

-- Prediction Query
SELECT T2.customer_first_name, T2.customer_last_name, T2.customer_phone FROM Accounts AS T1 JOIN Customers AS T2 ON T1.customer_id = T2.customer_id WHERE T1.account_name = '162';

/*
Prediction Result:
('-2', '1', '1')
('-3', '0', '1')
*/