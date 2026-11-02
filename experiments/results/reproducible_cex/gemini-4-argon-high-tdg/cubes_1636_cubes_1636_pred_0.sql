-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO bank (branch_ID, bname, no_of_customers, city, state) VALUES (10, 'New York City', 150, 'New York', 'New York');
INSERT INTO bank (branch_ID, bname, no_of_customers, city, state) VALUES (20, 'Empire', 200, 'Boston', 'New York City');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C10', 10, 'Eve', 'S', 4000, 1, 700, 'New York');
INSERT INTO loan (loan_ID, cust_ID, branch_ID, loan_type, amount) VALUES ('L10', 'C10', 10, 'Auto', 15000);
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