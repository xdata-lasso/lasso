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
INSERT INTO BANK VALUES (0, 0, 0, 0, 0);
INSERT INTO BANK VALUES (1, 0, 0, 0, 0);
INSERT INTO CUSTOMER VALUES (0, 1, 11, 0, 0, 0, 0, 0);
INSERT INTO CUSTOMER VALUES (-1, 1, 10, 0, 0, 0, 0, 0);
INSERT INTO LOAN VALUES (4, 0, 0, 0, 0);
INSERT INTO LOAN VALUES (5, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cust_name FROM (SELECT * FROM (SELECT * FROM customer ORDER BY acc_type, customer.cust_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('10',)
*/

-- Prediction Query
SELECT cust_name FROM customer ORDER BY credit_score, customer.cust_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('10',)
*/