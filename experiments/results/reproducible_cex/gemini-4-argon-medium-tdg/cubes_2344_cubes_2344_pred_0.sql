-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_Details" TEXT(255));

CREATE TABLE "Customer_Policies" ("Policy_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_Type_Code" TEXT(15), "Start_Date" DATE, "End_Date" DATE, FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Claims" ("Claim_ID" INTEGER PRIMARY KEY, "Policy_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, FOREIGN KEY ("Policy_ID") REFERENCES "Customer_Policies" ("Policy_ID"));

CREATE TABLE "Settlements" ("Settlement_ID" INTEGER PRIMARY KEY, "Claim_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, "Customer_Policy_ID" INTEGER, FOREIGN KEY ("Claim_ID") REFERENCES "Claims" ("Claim_ID"));

CREATE TABLE "Payments" ("Payment_ID" INTEGER PRIMARY KEY, "Settlement_ID" INTEGER, "Payment_Method_Code" TEXT(255), "Date_Payment_Made" DATE, "Amount_Payment" INTEGER, FOREIGN KEY ("Settlement_ID") REFERENCES "Settlements" ("Settlement_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Customers" ("Customer_ID", "Customer_Details") VALUES (10, 'Zebra Corp');
INSERT INTO "Customers" ("Customer_ID", "Customer_Details") VALUES (20, 'Alpha Inc');
INSERT INTO "Customers" ("Customer_ID", "Customer_Details") VALUES (30, 'Alpha Inc');
INSERT INTO "Customers" ("Customer_ID", "Customer_Details") VALUES (40, 'Beta LLC');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_details FROM customers ORDER BY customer_details, customers.customer_id NULLS LAST;

/*
Gold Result:
('Alpha Inc',)
('Alpha Inc',)
('Beta LLC',)
('Zebra Corp',)
*/

-- Prediction Query
SELECT DISTINCT customer_details FROM Customers;

/*
Prediction Result:
('Zebra Corp',)
('Alpha Inc',)
('Beta LLC',)
*/