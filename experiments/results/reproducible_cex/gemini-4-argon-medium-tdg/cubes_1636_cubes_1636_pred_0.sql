-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests empty result set for the WHERE clause (no branches in 'New York City').
-- Crucial for catching mutants that use scalar aggregate SUM("no_of_customers") without GROUP BY instead of the window function OVER ().
-- Window function returns 0 rows; scalar aggregate without GROUP BY returns 1 row with NULL.
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (1, 'Chicago Main', 150, 'Chicago', 'Illinois');
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (2, 'Boston Harbor', 200, 'Boston', 'Massachusetts');
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (3, 'Case Test', 300, 'new york city', 'New York');
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (4, 'Prefix Test', 400, 'New York', 'New York');
INSERT INTO "customer" ("cust_ID", "branch_ID", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('C01', 1, 'Dave', 'S', 1500, 1, 680, 'Illinois');
INSERT INTO "loan" ("loan_ID", "cust_ID", "branch_ID", "loan_type", "amount") VALUES ('L01', 'C01', '1', 'Personal', 5000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SUM("no_of_customers") OVER () AS "sum_no_of_customers_" FROM "bank" WHERE ("city" = 'New York City') ORDER BY sum_no_of_customers_;

/*
Gold Result:
*/

-- Prediction Query
SELECT SUM(no_of_customers) FROM bank WHERE city = 'New York City';

/*
Prediction Result:
(None,)
*/