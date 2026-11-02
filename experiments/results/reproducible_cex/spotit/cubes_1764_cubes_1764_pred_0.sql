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
INSERT INTO ACCOUNTS VALUES (1, 0, 0, 0);
INSERT INTO ACCOUNTS VALUES (0, 0, 0, 0);
INSERT INTO CUSTOMERS VALUES (-1, 0, 0, 0, 0, 0, 0);
INSERT INTO CUSTOMERS VALUES (0, 0, 0, 0, 0, 0, 0);
INSERT INTO CUSTOMERS_CARDS VALUES (0, 0, 0, 36, 37, 38, 39);
INSERT INTO CUSTOMERS_CARDS VALUES (-1, 0, 45, 46, 47, 48, 49);
INSERT INTO FINANCIAL_TRANSACTIONS VALUES (1, 0, 0, 0, 31, 32, 33, 34, 35);
INSERT INTO FINANCIAL_TRANSACTIONS VALUES (1, 0, 0, 0, 40, 41, 42, 43, 44);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT card_type_code, n AS count___ FROM (SELECT card_type_code, transaction_comment, COUNT(*) AS n FROM (SELECT LHS.card_id AS card_id, LHS.customer_id AS customer_id, LHS.card_type_code AS card_type_code, LHS.card_number AS card_number, LHS.date_valid_from AS date_valid_from, LHS.date_valid_to AS date_valid_to, LHS.other_card_details AS other_card_details, RHS.transaction_id AS transaction_id, RHS.previous_transaction_id AS previous_transaction_id, RHS.account_id AS account_id, RHS.transaction_type AS transaction_type, RHS.transaction_date AS transaction_date, RHS.transaction_amount AS transaction_amount, RHS.transaction_comment AS transaction_comment, RHS.other_transaction_details AS other_transaction_details FROM customers_cards AS LHS INNER JOIN financial_transactions AS RHS ON (LHS.card_id = RHS.card_id)) GROUP BY card_type_code, transaction_comment) ORDER BY card_type_code, count___ NULLS LAST;

/*
Gold Result:
('0', 1)
('0', 1)
*/

-- Prediction Query
SELECT T2.card_type_code, COUNT(*) FROM Financial_transactions AS T1 JOIN Customers_cards AS T2 ON T1.card_id = T2.card_id GROUP BY T2.card_type_code;

/*
Prediction Result:
('0', 2)
*/