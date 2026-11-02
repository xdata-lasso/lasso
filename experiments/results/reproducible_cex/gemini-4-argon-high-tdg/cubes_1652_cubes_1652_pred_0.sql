-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO bank (branch_ID, bname, no_of_customers, city, state) VALUES (10, 'morningside', 120, 'Seattle', 'Washington');
INSERT INTO bank (branch_ID, bname, no_of_customers, city, state) VALUES (20, 'morningside', 85, 'Austin', 'Texas');
INSERT INTO bank (branch_ID, bname, no_of_customers, city, state) VALUES (30, 'morningside', 200, 'Denver', 'Colorado');
INSERT INTO bank (branch_ID, bname, no_of_customers, city, state) VALUES (40, 'Morningside', 150, 'Boston', 'Massachusetts');
INSERT INTO bank (branch_ID, bname, no_of_customers, city, state) VALUES (50, 'morningside_east', 90, 'Miami', 'Florida');
INSERT INTO bank (branch_ID, bname, no_of_customers, city, state) VALUES (60, 'riverside', 300, 'Chicago', 'morningside');
INSERT INTO bank (branch_ID, bname, no_of_customers, city, state) VALUES (70, NULL, 50, 'Phoenix', 'Arizona');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "city", "state" FROM "bank" WHERE ("bname" = 'morningside') ORDER BY city, bank.branch_id NULLS LAST;

/*
Gold Result:
('Austin', 'Texas')
('Denver', 'Colorado')
('Seattle', 'Washington')
*/

-- Prediction Query
SELECT city, state FROM bank WHERE bname = 'morningside';

/*
Prediction Result:
('Seattle', 'Washington')
('Austin', 'Texas')
('Denver', 'Colorado')
*/