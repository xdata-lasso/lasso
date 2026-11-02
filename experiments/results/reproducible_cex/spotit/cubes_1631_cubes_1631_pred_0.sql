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
INSERT INTO BANK VALUES (3, 0, 0, 0, 0);
INSERT INTO BANK VALUES (2, 0, 0, 0, 0);
INSERT INTO CUSTOMER VALUES (7, 3, 11, 12, 0, 0, 0, 13);
INSERT INTO CUSTOMER VALUES (10, 3, 14, 15, 0, 0, 0, 16);
INSERT INTO LOAN VALUES (6, 10, 2, 20, 0);
INSERT INTO LOAN VALUES (21, 10, 3, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cust_name FROM (SELECT LHS.cust_id AS cust_id, LHS.cust_name AS cust_name, LHS.acc_type AS acc_type, LHS.acc_bal AS acc_bal, LHS.no_of_loans AS no_of_loans, LHS.credit_score AS credit_score, LHS.branch_id AS branch_id, LHS.state AS state FROM customer AS LHS INNER JOIN (SELECT cust_id, COUNT(*) AS n FROM loan GROUP BY cust_id) AS RHS ON (LHS.branch_id = RHS.n AND LHS.cust_id = RHS.cust_id)) ORDER BY cust_name;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.cust_name FROM customer AS T1 JOIN loan AS T2 ON T1.cust_id = T2.cust_id GROUP BY T1.cust_name HAVING COUNT(*) > 1;

/*
Prediction Result:
('14',)
*/