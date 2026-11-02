-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO bank (branch_ID, bname, no_of_customers, city, state) VALUES (10, 'Zeta Bank', 100, 'Albany', 'New York');
INSERT INTO bank (branch_ID, bname, no_of_customers, city, state) VALUES (20, 'Alpha Bank', 500, 'New York', 'New York');
INSERT INTO bank (branch_ID, bname, no_of_customers, city, state) VALUES (30, 'Alpha Bank', 200, 'Buffalo', 'New York');
INSERT INTO bank (branch_ID, bname, no_of_customers, city, state) VALUES (40, 'Beta Bank', 300, 'New York', 'New Jersey');
INSERT INTO bank (branch_ID, bname, no_of_customers, city, state) VALUES (50, 'Gamma Bank', 400, 'Boston', 'Massachusetts');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C01', 20, 'John Doe', 'S', 5000, 1, 720, 'California');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C02', 20, 'Jane Roe', 'C', 8000, 0, 780, 'California');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C03', 40, 'Sam Smith', 'S', 3000, 1, 650, 'New York');
INSERT INTO loan (loan_ID, cust_ID, branch_ID, loan_type, amount) VALUES ('L01', 'C01', '20', 'Personal', 10000);
INSERT INTO loan (loan_ID, cust_ID, branch_ID, loan_type, amount) VALUES ('L02', 'C03', '40', 'Auto', 15000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "bname" FROM "bank" WHERE ("state" = 'New York') ORDER BY bname, bank.branch_id NULLS LAST;

/*
Gold Result:
('Alpha Bank',)
('Alpha Bank',)
('Zeta Bank',)
*/

-- Prediction Query
SELECT bname FROM bank WHERE state = 'New York';

/*
Prediction Result:
('Zeta Bank',)
('Alpha Bank',)
('Alpha Bank',)
*/