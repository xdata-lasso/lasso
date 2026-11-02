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
INSERT INTO CUSTOMER VALUES (10, 0, 11, 0, 54, 0, 50, 9);
INSERT INTO CUSTOMER VALUES (13, 0, 14, -1, 53, 0, 0, 12);
INSERT INTO LOAN VALUES (4, 10, -1, 0, 0);
INSERT INTO LOAN VALUES (5, 10, -1, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanacc_bal AS avg_acc_bal_, acc_type FROM (SELECT acc_type, state, AVG(acc_bal) AS meanacc_bal FROM (SELECT * FROM customer WHERE (acc_bal > 50 AND credit_score <= 50)) GROUP BY acc_type, state) ORDER BY avg_acc_bal_, acc_type NULLS LAST;

/*
Gold Result:
(53.0, '-1')
(54.0, '0')
*/

-- Prediction Query
SELECT AVG(acc_bal), acc_type FROM customer WHERE credit_score < 50 GROUP BY acc_type;

/*
Prediction Result:
(53.0, '-1')
*/