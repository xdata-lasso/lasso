-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO bank (branch_ID, bname, no_of_customers, city, state) VALUES (1, 'Downtown', 100, 'Boston', 'MA');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C01', 1, 'Alice', 'S', 5000, 1, 750, 'MA');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C02', 1, 'Bob', 'C', 3000, 0, 800, 'MA');
INSERT INTO customer (cust_ID, branch_ID, cust_name, acc_type, acc_bal, no_of_loans, credit_score, state) VALUES ('C03', 1, 'Zack', 'S', 1000, 2, 650, 'MA');
INSERT INTO loan (loan_ID, cust_ID, branch_ID, loan_type, amount) VALUES ('L01', 'C01', '1', 'Auto', 10000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cust_name, acc_type, acc_bal FROM (SELECT * FROM (SELECT * FROM customer ORDER BY cust_name DESC, customer.cust_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Zack', 'S', 1000)
*/

-- Prediction Query
SELECT cust_name, acc_type, acc_bal FROM customer ORDER BY credit_score DESC, customer.cust_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Bob', 'C', 3000)
*/