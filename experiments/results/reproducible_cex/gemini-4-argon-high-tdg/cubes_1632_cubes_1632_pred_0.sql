-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (1, 'Zions', 300, 'Provo', 'Utah');
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (2, 'Alta', 500, 'Ogden', 'Utah');
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (3, 'First', 100, 'Salt Lake', 'Utah');
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (4, 'Sierra', 900, 'Reno', 'Nevada');
INSERT INTO "customer" ("cust_ID", "branch_ID", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('C1', 1, 'Alice', 'S', 5000, 1, 750, 'Utah');
INSERT INTO "customer" ("cust_ID", "branch_ID", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('C2', 1, 'Bob', 'C', 3000, 0, 680, 'Nevada');
INSERT INTO "customer" ("cust_ID", "branch_ID", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('C3', 4, 'Charlie', 'S', 8000, 2, 800, 'Utah');
INSERT INTO "loan" ("loan_ID", "cust_ID", "branch_ID", "loan_type", "amount") VALUES ('L1', 'C1', 1, 'Auto', 15000);
INSERT INTO "loan" ("loan_ID", "cust_ID", "branch_ID", "loan_type", "amount") VALUES ('L2', 'C3', 4, 'Home', 250000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "no_of_customers" AS "avg_no_of_customers_" FROM (SELECT "branch_id", "bname", "no_of_customers", "city", "state", AVG("no_of_customers") OVER () AS "meanno_of_customers" FROM "bank") WHERE ("state" = 'Utah') ORDER BY avg_no_of_customers_;

/*
Gold Result:
(100,)
(300,)
(500,)
*/

-- Prediction Query
SELECT AVG(no_of_customers) FROM bank WHERE state = 'Utah';

/*
Prediction Result:
(300.0,)
*/