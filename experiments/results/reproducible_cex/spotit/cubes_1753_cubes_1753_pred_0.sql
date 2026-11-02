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
INSERT INTO ACCOUNTS VALUES (2, 0, 0, 0);
INSERT INTO CUSTOMERS VALUES (0, 0, 0, 0, 0, 0, 0);
INSERT INTO CUSTOMERS VALUES (1, 0, 0, 0, 0, 0, 0);
INSERT INTO CUSTOMERS_CARDS VALUES (2, 0, 0, 0, 0, 0, 0);
INSERT INTO CUSTOMERS_CARDS VALUES (0, 0, 0, 0, 0, 0, 0);
INSERT INTO FINANCIAL_TRANSACTIONS VALUES (1, 0, 3, 0, 1, 22, 1, 23, 24);
INSERT INTO FINANCIAL_TRANSACTIONS VALUES (2, 2, 2, 0, 0, 12, 0, 13, 14);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT transaction_type FROM (SELECT transaction_id, previous_transaction_id, card_id AS account_id, card_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details, transaction_id_other, previous_transaction_id_other, transaction_type_other, transaction_date_other, transaction_amount_other, transaction_comment_other, other_transaction_details_other FROM (SELECT transaction_id, previous_transaction_id, account_id, transaction_id AS card_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details, transaction_id_other, previous_transaction_id_other, transaction_type_other, transaction_date_other, transaction_amount_other, transaction_comment_other, other_transaction_details_other FROM (SELECT LHS.transaction_id AS transaction_id, LHS.previous_transaction_id AS previous_transaction_id, LHS.account_id AS account_id, LHS.card_id AS card_id, LHS.transaction_type AS transaction_type, LHS.transaction_date AS transaction_date, LHS.transaction_amount AS transaction_amount, LHS.transaction_comment AS transaction_comment, LHS.other_transaction_details AS other_transaction_details, RHS.transaction_id AS transaction_id_other, RHS.previous_transaction_id AS previous_transaction_id_other, RHS.transaction_type AS transaction_type_other, RHS.transaction_date AS transaction_date_other, RHS.transaction_amount AS transaction_amount_other, RHS.transaction_comment AS transaction_comment_other, RHS.other_transaction_details AS other_transaction_details_other FROM financial_transactions AS LHS INNER JOIN financial_transactions AS RHS ON (LHS.transaction_id = RHS.card_id AND LHS.card_id = RHS.account_id)))) ORDER BY transaction_type;

/*
Gold Result:
('0',)
*/

-- Prediction Query
SELECT transaction_type FROM Financial_transactions GROUP BY transaction_type ORDER BY SUM(transaction_amount) DESC, transaction_type NULLS LAST LIMIT 1;

/*
Prediction Result:
('1',)
*/