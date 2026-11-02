-- Schema DDL
CREATE TABLE "BANK" (
    "BRANCH_ID" INT,
    "BNAME" TEXT,
    "NO_OF_CUSTOMERS" INT,
    "CITY" TEXT,
    "STATE" TEXT,
    PRIMARY KEY ("BRANCH_ID")
);
CREATE TABLE "CUSTOMER" (
    "CUST_ID" TEXT,
    "BRANCH_ID" INT,
    "CUST_NAME" TEXT,
    "ACC_TYPE" TEXT,
    "ACC_BAL" INT,
    "NO_OF_LOANS" INT,
    "CREDIT_SCORE" INT,
    "STATE" TEXT,
    PRIMARY KEY ("CUST_ID"),
    FOREIGN KEY ("BRANCH_ID") REFERENCES "BANK"("BRANCH_ID")
);
CREATE TABLE "LOAN" (
    "LOAN_ID" TEXT,
    "CUST_ID" TEXT,
    "BRANCH_ID" TEXT,
    "LOAN_TYPE" TEXT,
    "AMOUNT" INT,
    PRIMARY KEY ("LOAN_ID"),
    FOREIGN KEY ("CUST_ID") REFERENCES "CUSTOMER"("CUST_ID"),
    FOREIGN KEY ("BRANCH_ID") REFERENCES "BANK"("BRANCH_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO BANK VALUES (-1, 0, 0, 0, 0);
INSERT INTO BANK VALUES (0, 0, 0, 0, 0);
INSERT INTO CUSTOMER VALUES (0, 0, 0, 0, 0, 0, 100, 11);
INSERT INTO CUSTOMER VALUES (-1, -1, 0, 0, 0, 0, 100, 8);
INSERT INTO LOAN VALUES (4, -1, -1, 0, 0);
INSERT INTO LOAN VALUES (5, -1, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT acc_bal AS sum_acc_bal_, state FROM customer WHERE (credit_score >= 100 OR credit_score >= acc_bal) ORDER BY sum_acc_bal_, customer.cust_id NULLS LAST;

/*
Gold Result:
(0, '8')
(0, '11')
*/

-- Prediction Query
SELECT SUM(acc_bal), state FROM customer WHERE credit_score > 100 GROUP BY state;

/*
Prediction Result:
*/