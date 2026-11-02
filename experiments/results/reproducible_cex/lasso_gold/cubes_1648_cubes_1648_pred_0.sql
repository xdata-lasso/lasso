-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (1027, 'Zachary Rice', 1028, 'Lake Jenniferside', 'Wisconsin');
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (1030, 'Nathan Cortez', 1031, 'New Rita', 'South Dakota');
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('example', 1027, 'Gina Carter', 'coach', 101, 1029, 101, 'New Jersey');
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('fire', 1030, 'Katie Gonzalez', 'hour', 102, 1032, 101, 'Hawaii');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT acc_bal AS sum_acc_bal_, state FROM customer WHERE (credit_score >= 100 OR credit_score >= acc_bal) ORDER BY sum_acc_bal_, customer.cust_id NULLS LAST;

/*
Gold Result:
(101, 'New Jersey')
(102, 'Hawaii')
*/

-- Prediction Query
SELECT SUM(acc_bal), state FROM customer WHERE credit_score > 100 GROUP BY state;

/*
Prediction Result:
(102, 'Hawaii')
(101, 'New Jersey')
*/