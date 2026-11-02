-- Schema DDL
CREATE TABLE "CUSTOMERS" (
    "CUSTOMER_ID" INT,
    "CUSTOMER_DETAILS" TEXT,
    PRIMARY KEY ("CUSTOMER_ID")
);
CREATE TABLE "CUSTOMER_POLICIES" (
    "POLICY_ID" INT,
    "CUSTOMER_ID" INT,
    "POLICY_TYPE_CODE" TEXT,
    "START_DATE" DATE,
    "END_DATE" DATE,
    PRIMARY KEY ("POLICY_ID"),
    FOREIGN KEY ("CUSTOMER_ID") REFERENCES "CUSTOMERS"("CUSTOMER_ID")
);
CREATE TABLE "CLAIMS" (
    "CLAIM_ID" INT,
    "POLICY_ID" INT,
    "DATE_CLAIM_MADE" DATE,
    "DATE_CLAIM_SETTLED" DATE,
    "AMOUNT_CLAIMED" INT,
    "AMOUNT_SETTLED" INT,
    PRIMARY KEY ("CLAIM_ID"),
    FOREIGN KEY ("POLICY_ID") REFERENCES "CUSTOMER_POLICIES"("POLICY_ID")
);
CREATE TABLE "SETTLEMENTS" (
    "SETTLEMENT_ID" INT,
    "CLAIM_ID" INT,
    "DATE_CLAIM_MADE" DATE,
    "DATE_CLAIM_SETTLED" DATE,
    "AMOUNT_CLAIMED" INT,
    "AMOUNT_SETTLED" INT,
    "CUSTOMER_POLICY_ID" INT,
    PRIMARY KEY ("SETTLEMENT_ID"),
    FOREIGN KEY ("CLAIM_ID") REFERENCES "CLAIMS"("CLAIM_ID")
);
CREATE TABLE "PAYMENTS" (
    "PAYMENT_ID" INT,
    "SETTLEMENT_ID" INT,
    "PAYMENT_METHOD_CODE" TEXT,
    "DATE_PAYMENT_MADE" DATE,
    "AMOUNT_PAYMENT" INT,
    PRIMARY KEY ("PAYMENT_ID"),
    FOREIGN KEY ("SETTLEMENT_ID") REFERENCES "SETTLEMENTS"("SETTLEMENT_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO CUSTOMERS VALUES (1, 0);
INSERT INTO CUSTOMERS VALUES (0, 0);
INSERT INTO CUSTOMER_POLICIES VALUES (-1, 1, 0, '0001-01-01', '0001-01-01');
INSERT INTO CUSTOMER_POLICIES VALUES (0, 1, 0, '0001-01-01', '0001-01-01');
INSERT INTO CLAIMS VALUES (-1, -1, '0001-01-01', '0001-01-01', 0, 0);
INSERT INTO CLAIMS VALUES (0, -1, '0001-01-01', '0001-01-01', 0, 0);
INSERT INTO SETTLEMENTS VALUES (0, -1, '0001-01-01', '0001-01-01', 0, 0, 0);
INSERT INTO SETTLEMENTS VALUES (1, -1, '0001-01-01', '0001-01-01', 0, 0, 0);
INSERT INTO PAYMENTS VALUES (0, 0, NULL, '0001-01-01', 0);
INSERT INTO PAYMENTS VALUES (1, 1, -1, '0001-01-01', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT payment_method_code FROM (SELECT payment_method_code, MIN(n) AS minn FROM (SELECT payment_method_code, settlement_id, COUNT(*) AS n FROM (SELECT payment_id, payment_id AS settlement_id, payment_method_code, date_payment_made, amount_payment, payment_id_other, payment_method_code_other, date_payment_made_other, amount_payment_other FROM (SELECT LHS.payment_id AS payment_id, LHS.settlement_id AS settlement_id, LHS.payment_method_code AS payment_method_code, LHS.date_payment_made AS date_payment_made, LHS.amount_payment AS amount_payment, RHS.payment_id AS payment_id_other, RHS.payment_method_code AS payment_method_code_other, RHS.date_payment_made AS date_payment_made_other, RHS.amount_payment AS amount_payment_other FROM payments AS LHS INNER JOIN payments AS RHS ON (LHS.payment_id = RHS.settlement_id))) GROUP BY payment_method_code, settlement_id) GROUP BY payment_method_code) ORDER BY payment_method_code;

/*
Gold Result:
(None,)
('-1',)
*/

-- Prediction Query
SELECT Payment_Method_Code FROM Payments GROUP BY Payment_Method_Code ORDER BY COUNT(*) ASC, Payment_Method_Code NULLS LAST LIMIT 1;

/*
Prediction Result:
('-1',)
*/