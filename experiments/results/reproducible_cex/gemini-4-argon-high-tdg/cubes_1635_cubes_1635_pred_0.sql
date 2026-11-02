-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (1, 'Salt Lake Bank', 15, 'Provo', 'Utah');
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (2, 'Alamo Bank', 25, 'Dallas', 'Texas');
INSERT INTO "customer" ("cust_ID", "branch_ID", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('C01', 1, 'Evan', 'S', 1500, 1, 720, 'New York');
INSERT INTO "customer" ("cust_ID", "branch_ID", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('C02', 2, 'Fiona', 'C', 2000, 0, 680, 'California');
INSERT INTO "customer" ("cust_ID", "branch_ID", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('C03', 1, 'George', 'S', 500, 0, 600, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SUM("acc_bal") OVER () AS "sum_acc_bal_" FROM "customer" WHERE ("state" = 'Utah' OR "state" = 'Texas') ORDER BY sum_acc_bal_;

/*
Gold Result:
*/

-- Prediction Query
SELECT SUM(acc_bal) FROM customer WHERE state = 'Utah' OR state = 'Texas';

/*
Prediction Result:
(None,)
*/