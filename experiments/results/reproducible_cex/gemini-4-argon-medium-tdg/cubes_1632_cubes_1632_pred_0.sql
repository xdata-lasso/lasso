-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (1, 'B1', 50, 'Provo', 'Utah');
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (2, 'B2', 10, 'SLC', 'Utah');
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (3, 'B3', 50, 'Ogden', 'Utah');
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (4, 'B4', 1000, 'Austin', 'Texas');
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (5, 'B5', 20, 'Utah', 'Texas');
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (6, 'Utah', 30, 'Dallas', 'Texas');
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (7, 'B7', 40, 'Orem', 'utah');
INSERT INTO "customer" ("cust_ID", "branch_ID", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('C1', 1, 'Alice', 'S', 1000, 1, 700, 'Texas');
INSERT INTO "customer" ("cust_ID", "branch_ID", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('C2', 1, 'Bob', 'C', 2000, 2, 750, 'Utah');
INSERT INTO "customer" ("cust_ID", "branch_ID", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('C3', 4, 'Charlie', 'S', 500, 0, 600, 'Utah');
INSERT INTO "loan" ("loan_ID", "cust_ID", "branch_ID", "loan_type", "amount") VALUES ('L1', 'C1', 1, 'Home', 50000);
INSERT INTO "loan" ("loan_ID", "cust_ID", "branch_ID", "loan_type", "amount") VALUES ('L2', 'C2', 1, 'Auto', 10000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "no_of_customers" AS "avg_no_of_customers_" FROM (SELECT "branch_id", "bname", "no_of_customers", "city", "state", AVG("no_of_customers") OVER () AS "meanno_of_customers" FROM "bank") WHERE ("state" = 'Utah') ORDER BY avg_no_of_customers_;

/*
Gold Result:
(10,)
(50,)
(50,)
*/

-- Prediction Query
SELECT AVG(no_of_customers) FROM bank WHERE state = 'Utah';

/*
Prediction Result:
(36.666666666666664,)
*/