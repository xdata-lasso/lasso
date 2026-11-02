-- Schema DDL
CREATE TABLE "INVESTORS" (
    "INVESTOR_ID" INT,
    "INVESTOR_DETAILS" TEXT,
    PRIMARY KEY ("INVESTOR_ID")
);
CREATE TABLE "LOTS" (
    "LOT_ID" INT,
    "INVESTOR_ID" INT,
    "LOT_DETAILS" TEXT,
    PRIMARY KEY ("LOT_ID"),
    FOREIGN KEY ("INVESTOR_ID") REFERENCES "INVESTORS"("INVESTOR_ID")
);
CREATE TABLE "REF_TRANSACTION_TYPES" (
    "TRANSACTION_TYPE_CODE" TEXT,
    "TRANSACTION_TYPE_DESCRIPTION" TEXT,
    PRIMARY KEY ("TRANSACTION_TYPE_CODE")
);
CREATE TABLE "TRANSACTIONS" (
    "TRANSACTION_ID" INT,
    "TRANSACTION_TYPE_CODE" TEXT,
    "INVESTOR_ID" INT,
    "DATE_OF_TRANSACTION" DATETIME,
    "AMOUNT_OF_TRANSACTION" FLOAT,
    "SHARE_COUNT" TEXT,
    "OTHER_DETAILS" TEXT,
    PRIMARY KEY ("TRANSACTION_ID"),
    FOREIGN KEY ("TRANSACTION_TYPE_CODE") REFERENCES "REF_TRANSACTION_TYPES"("TRANSACTION_TYPE_CODE"),
    FOREIGN KEY ("INVESTOR_ID") REFERENCES "INVESTORS"("INVESTOR_ID")
);
CREATE TABLE "SALES" (
    "SALES_TRANSACTION_ID" INT,
    "SALES_DETAILS" TEXT,
    PRIMARY KEY ("SALES_TRANSACTION_ID"),
    FOREIGN KEY ("SALES_TRANSACTION_ID") REFERENCES "TRANSACTIONS"("TRANSACTION_ID")
);
CREATE TABLE "PURCHASES" (
    "PURCHASE_TRANSACTION_ID" INT,
    "PURCHASE_DETAILS" TEXT,
    FOREIGN KEY ("PURCHASE_TRANSACTION_ID") REFERENCES "TRANSACTIONS"("TRANSACTION_ID")
);
CREATE TABLE "TRANSACTIONS_LOTS" (
    "TRANSACTION_ID" INT,
    "LOT_ID" INT,
    FOREIGN KEY ("TRANSACTION_ID") REFERENCES "TRANSACTIONS"("TRANSACTION_ID"),
    FOREIGN KEY ("LOT_ID") REFERENCES "LOTS"("LOT_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO INVESTORS VALUES (1, 0);
INSERT INTO INVESTORS VALUES (0, 0);
INSERT INTO LOTS VALUES (1, 0, 0);
INSERT INTO LOTS VALUES (0, 0, 0);
INSERT INTO REF_TRANSACTION_TYPES VALUES (2, 0);
INSERT INTO REF_TRANSACTION_TYPES VALUES (3, 0);
INSERT INTO TRANSACTIONS VALUES (1, 3, 1, 30, 31, 21, 32);
INSERT INTO TRANSACTIONS VALUES (0, 2, 0, 16, 17, 18, 19);
INSERT INTO SALES VALUES (0, 0);
INSERT INTO SALES VALUES (1, 0);
INSERT INTO PURCHASES VALUES (1, 0);
INSERT INTO PURCHASES VALUES (1, 0);
INSERT INTO TRANSACTIONS_LOTS VALUES (1, 1);
INSERT INTO TRANSACTIONS_LOTS VALUES (0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT transaction_type_code FROM (SELECT transaction_type_code, COUNT(*) AS n FROM (SELECT investor_id AS transaction_id, investor_id, transaction_type_code, date_of_transaction, amount_of_transaction, share_count, other_details, investor_id_other, transaction_type_code_other, date_of_transaction_other, amount_of_transaction_other, other_details_other FROM (SELECT LHS.transaction_id AS transaction_id, LHS.investor_id AS investor_id, LHS.transaction_type_code AS transaction_type_code, LHS.date_of_transaction AS date_of_transaction, LHS.amount_of_transaction AS amount_of_transaction, LHS.share_count AS share_count, LHS.other_details AS other_details, RHS.investor_id AS investor_id_other, RHS.transaction_type_code AS transaction_type_code_other, RHS.date_of_transaction AS date_of_transaction_other, RHS.amount_of_transaction AS amount_of_transaction_other, RHS.other_details AS other_details_other FROM transactions AS LHS INNER JOIN transactions AS RHS ON (LHS.investor_id = RHS.transaction_id AND LHS.share_count = RHS.share_count))) GROUP BY transaction_type_code) ORDER BY transaction_type_code;

/*
Gold Result:
('2',)
('3',)
*/

-- Prediction Query
SELECT transaction_type_code FROM TRANSACTIONS GROUP BY transaction_type_code ORDER BY COUNT(*) DESC, transaction_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('2',)
*/