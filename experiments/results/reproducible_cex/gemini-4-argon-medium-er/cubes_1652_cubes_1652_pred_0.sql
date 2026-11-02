-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (1, 'morningside', 10, 'Boston', 'MA');
INSERT INTO "bank" ("branch_ID", "bname", "no_of_customers", "city", "state") VALUES (2, 'morningside', 20, 'Austin', 'TX');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "city", "state" FROM "bank" WHERE ("bname" = 'morningside') ORDER BY city, bank.branch_id NULLS LAST;

/*
Gold Result:
('Austin', 'TX')
('Boston', 'MA')
*/

-- Prediction Query
SELECT city, state FROM bank WHERE bname = 'morningside';

/*
Prediction Result:
('Boston', 'MA')
('Austin', 'TX')
*/