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
INSERT INTO CUSTOMER VALUES (0, 0, NULL, NULL, NULL, 0, NULL, 0);
INSERT INTO CUSTOMER VALUES (-1, -1, 0, 0, 0, 0, NULL, 0);
INSERT INTO LOAN VALUES (4, 0, -1, 0, 0);
INSERT INTO LOAN VALUES (5, 0, -1, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cust_name, acc_type, acc_bal FROM (SELECT * FROM (SELECT * FROM customer ORDER BY cust_name DESC, customer.cust_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('0', '0', 0)
*/

-- Prediction Query
SELECT cust_name, acc_type, acc_bal FROM customer ORDER BY credit_score DESC, customer.cust_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('0', '0', 0)
*/