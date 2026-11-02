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
INSERT INTO ACCOUNTS VALUES (-1, 0, 0, 0);
INSERT INTO ACCOUNTS VALUES (0, 0, 0, 0);
INSERT INTO CUSTOMERS VALUES (0, 0, 0, 0, 0, 0, 0);
INSERT INTO CUSTOMERS VALUES (1, 0, 0, 0, 0, 0, 0);
INSERT INTO CUSTOMERS_CARDS VALUES (0, 0, 1, 25, 17, 26, 27);
INSERT INTO CUSTOMERS_CARDS VALUES (-1, -1, NULL, 11, 12, 13, 14);
INSERT INTO FINANCIAL_TRANSACTIONS VALUES (-1, -1, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO FINANCIAL_TRANSACTIONS VALUES (-1, -1, 0, 0, 0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT card_type_code FROM (SELECT card_type_code, date_valid_to, COUNT(*) AS n FROM (SELECT customer_id AS card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details, customer_id_other, card_type_code_other, card_number_other, date_valid_to_other, other_card_details_other FROM (SELECT LHS.card_id AS card_id, LHS.customer_id AS customer_id, LHS.card_type_code AS card_type_code, LHS.card_number AS card_number, LHS.date_valid_from AS date_valid_from, LHS.date_valid_to AS date_valid_to, LHS.other_card_details AS other_card_details, RHS.customer_id AS customer_id_other, RHS.card_type_code AS card_type_code_other, RHS.card_number AS card_number_other, RHS.date_valid_to AS date_valid_to_other, RHS.other_card_details AS other_card_details_other FROM customers_cards AS LHS INNER JOIN customers_cards AS RHS ON (LHS.customer_id = RHS.card_id AND LHS.date_valid_from = RHS.date_valid_from))) GROUP BY card_type_code, date_valid_to) ORDER BY card_type_code;

/*
Gold Result:
(None,)
('1',)
*/

-- Prediction Query
SELECT card_type_code FROM Customers_cards GROUP BY card_type_code ORDER BY COUNT(*) DESC, card_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('1',)
*/