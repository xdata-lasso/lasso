-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (1003, 'Stephanie Miller', 1006, 'Johnsonland', 'Utah');
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (1005, 'Stephanie Miller', 1009, 'Johnsonland', 'Utah');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "no_of_customers" AS "avg_no_of_customers_" FROM (SELECT "branch_id", "bname", "no_of_customers", "city", "state", AVG("no_of_customers") OVER () AS "meanno_of_customers" FROM "bank") WHERE ("state" = 'Utah') ORDER BY avg_no_of_customers_;

/*
Gold Result:
(1006,)
(1009,)
*/

-- Prediction Query
SELECT AVG(no_of_customers) FROM bank WHERE state = 'Utah';

/*
Prediction Result:
(1007.5,)
*/