-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO bank (branch_ID, bname, no_of_customers, city, state) VALUES (1, 'Zeta Bank', 1000, 'Boston', 'MA');
INSERT INTO bank (branch_ID, bname, no_of_customers, city, state) VALUES (2, 'Alpha Bank', 1000, 'Austin', 'TX');
INSERT INTO bank (branch_ID, bname, no_of_customers, city, state) VALUES (3, 'Beta Bank', 400, 'Denver', 'CO');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C01', 3, 'Dan Green', 'C', 15000, 2, 700, 'CO');
INSERT INTO loan (loan_ID, cust_ID, branch_ID, loan_type, amount) VALUES ('L01', 'C01', 3, 'Auto', 20000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT bname FROM (SELECT LHS.branch_id AS branch_id, LHS.bname AS bname, LHS.no_of_customers AS no_of_customers, LHS.city AS city, LHS.state AS state, LHS.maxno_of_customers AS maxno_of_customers, RHS.branch_id AS branch_id_other, RHS.bname AS bname_other, RHS.no_of_customers AS no_of_customers_other, RHS.city AS city_other, RHS.state AS state_other FROM (SELECT branch_id, bname, no_of_customers, city, state, MAX(no_of_customers) OVER () AS maxno_of_customers FROM bank) AS LHS CROSS JOIN bank AS RHS) WHERE (no_of_customers = maxno_of_customers AND maxno_of_customers <= no_of_customers_other) ORDER BY bname;

/*
Gold Result:
('Alpha Bank',)
('Alpha Bank',)
('Zeta Bank',)
('Zeta Bank',)
*/

-- Prediction Query
SELECT bname FROM bank ORDER BY no_of_customers DESC, bank.branch_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Zeta Bank',)
*/