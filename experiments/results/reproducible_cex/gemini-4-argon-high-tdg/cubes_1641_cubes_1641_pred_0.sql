-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO bank (branch_ID, bname, no_of_customers, city, state) VALUES (1, 'First Bank', 100, 'Boston', 'MA');
INSERT INTO bank (branch_ID, bname, no_of_customers, city, state) VALUES (2, 'Second Bank', 200, 'Austin', 'TX');
INSERT INTO bank (branch_ID, bname, no_of_customers, city, state) VALUES (3, 'Third Bank', 50, 'Denver', 'CO');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C05', 3, 'Zara', 'A', 100, 1, 850, 'WA');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C01', 1, 'Aaron', 'B', 9000, 2, 500, 'AL');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C02', 2, 'Maya', 'A', 4500, 0, 700, 'NY');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C09', 1, 'Liam', 'C', 50, 3, 900, 'TX');
INSERT INTO loan (loan_ID, cust_ID, branch_ID, loan_type, amount) VALUES ('L01', 'C05', '3', 'Home', 50000);
INSERT INTO loan (loan_ID, cust_ID, branch_ID, loan_type, amount) VALUES ('L02', 'C01', '1', 'Auto', 15000);
INSERT INTO loan (loan_ID, cust_ID, branch_ID, loan_type, amount) VALUES ('L03', 'C09', '1', 'Personal', 5000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cust_name FROM (SELECT * FROM (SELECT * FROM customer ORDER BY acc_type, customer.cust_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Maya',)
*/

-- Prediction Query
SELECT cust_name FROM customer ORDER BY credit_score, customer.cust_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Aaron',)
*/