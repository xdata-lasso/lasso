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
INSERT INTO CUSTOMERS VALUES (0, 0);
INSERT INTO CUSTOMERS VALUES (1, 0);
INSERT INTO CUSTOMER_POLICIES VALUES (0, 0, 0, '0001-01-01', '0001-01-01');
INSERT INTO CUSTOMER_POLICIES VALUES (-1, 1, 0, '0001-01-01', '0001-01-01');
INSERT INTO CLAIMS VALUES (1, -1, '0001-01-03', '0001-01-01', 1, 1);
INSERT INTO CLAIMS VALUES (0, 0, '0001-01-02', '0001-01-03', 2, -1);
INSERT INTO SETTLEMENTS VALUES (1, 1, '0001-01-03', '0001-01-01', 1, 1, 0);
INSERT INTO SETTLEMENTS VALUES (0, 1, '0001-01-01', '0001-01-02', 0, 0, 0);
INSERT INTO PAYMENTS VALUES (0, 1, 0, '0001-01-01', 0);
INSERT INTO PAYMENTS VALUES (-1, 1, 0, '0001-01-01', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT claim_id, n AS count___ FROM (SELECT claim_id, policy_id, COUNT(*) AS n FROM (SELECT LHS.settlement_id AS settlement_id, LHS.claim_id AS claim_id, LHS.date_claim_made AS date_claim_made, LHS.date_claim_settled AS date_claim_settled, LHS.amount_claimed AS amount_claimed, LHS.amount_settled AS amount_settled, LHS.customer_policy_id AS customer_policy_id, RHS.policy_id AS policy_id FROM settlements AS LHS LEFT JOIN claims AS RHS ON (LHS.claim_id = RHS.claim_id AND LHS.date_claim_made = RHS.date_claim_made AND LHS.date_claim_settled = RHS.date_claim_settled AND LHS.amount_claimed = RHS.amount_claimed AND LHS.amount_settled = RHS.amount_settled)) GROUP BY claim_id, policy_id) ORDER BY claim_id, count___ NULLS LAST;

/*
Gold Result:
(1, 1)
(1, 1)
*/

-- Prediction Query
SELECT T1.Claim_id, COUNT(*) FROM Claims AS T1 JOIN Settlements AS T2 ON T1.claim_id = T2.claim_id GROUP BY T1.claim_id;

/*
Prediction Result:
(1, 2)
*/