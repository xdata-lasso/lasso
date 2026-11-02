-- Schema DDL
CREATE TABLE "bank" ("branch_ID" INTEGER PRIMARY KEY, "bname" TEXT(20), "no_of_customers" INTEGER, "city" TEXT(10), "state" TEXT(20));

CREATE TABLE "customer" ("cust_ID" TEXT(3) PRIMARY KEY, "branch_ID" INTEGER, "cust_name" TEXT(20), "acc_type" TEXT(1), "acc_bal" INTEGER, "no_of_loans" INTEGER, "credit_score" INTEGER, "state" TEXT(20), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

CREATE TABLE "loan" ("loan_ID" TEXT(3) PRIMARY KEY, "cust_ID" TEXT(3), "branch_ID" TEXT(3), "loan_type" TEXT(15), "amount" INTEGER, FOREIGN KEY ("cust_ID") REFERENCES "customer" ("Cust_ID"), FOREIGN KEY ("branch_ID") REFERENCES "bank" ("branch_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (1011, 'Jay Ramirez', 1012, 'Port Matthew', 'Colorado');
INSERT INTO "bank" ("branch_id", "bname", "no_of_customers", "city", "state") VALUES (1016, 'Kimberly Dudley', 1017, 'Millerport', 'South Dakota');
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('husband', 1011, 'Ryan Munoz', 'available', 1013, 1014, 1015, 'Arizona');
INSERT INTO "customer" ("cust_id", "branch_id", "cust_name", "acc_type", "acc_bal", "no_of_loans", "credit_score", "state") VALUES ('present', 1016, 'Dylan Miller', 'surface', 1014, 1015, 1016, 'Texas');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cust_name FROM customer ORDER BY cust_name, customer.cust_id NULLS LAST;

/*
Gold Result:
('Dylan Miller',)
('Ryan Munoz',)
*/

-- Prediction Query
SELECT cust_name FROM customer ORDER BY acc_bal, customer.cust_id NULLS LAST;

/*
Prediction Result:
('Ryan Munoz',)
('Dylan Miller',)
*/