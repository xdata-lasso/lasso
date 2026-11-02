-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_Details" TEXT(255));

CREATE TABLE "Staff" ("Staff_ID" INTEGER PRIMARY KEY, "Staff_Details" TEXT(255));

CREATE TABLE "Policies" ("Policy_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_Type_Code" TEXT(15), "Start_Date" DATETIME, "End_Date" DATETIME, FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Claim_Headers" ("Claim_Header_ID" INTEGER PRIMARY KEY, "Policy_ID" INTEGER, "Claim_Status_Code" TEXT(15), "Claim_Type_Code" TEXT(15), "Date_of_Claim" DATETIME, "Date_of_Settlement" DATETIME, "Amount_Claimed" REAL(20, 4), "Amount_Piad" REAL(20, 4), FOREIGN KEY ("Policy_ID") REFERENCES "Policies" ("Policy_ID"));

CREATE TABLE "Claims_Documents" ("Claim_ID" INTEGER, "Document_Type_Code" TEXT(15), "Created_by_Staff_ID" INTEGER, "Created_Date" INTEGER, PRIMARY KEY ("Claim_ID", "Document_Type_Code"), FOREIGN KEY ("Created_by_Staff_ID") REFERENCES "Staff" ("Staff_ID"), FOREIGN KEY ("Claim_ID") REFERENCES "Claim_Headers" ("Claim_Header_ID"));

CREATE TABLE "Claims_Processing_Stages" ("Claim_Stage_ID" INTEGER PRIMARY KEY, "Next_Claim_Stage_ID" INTEGER, "Claim_Status_Name" TEXT(255), "Claim_Status_Description" TEXT(255));

CREATE TABLE "Claims_Processing" ("Claim_Processing_ID" INTEGER PRIMARY KEY, "Staff_ID" INTEGER, "Claim_ID" INTEGER, "Claim_Outcome_Code" TEXT(15), "Claim_Stage_ID" INTEGER, FOREIGN KEY ("Staff_ID") REFERENCES "Staff" ("Staff_ID"), FOREIGN KEY ("Claim_ID") REFERENCES "Claim_Headers" ("Claim_Header_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (1097, 'surface');
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (1098, 'animal');
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (1099, 'show');
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (1100, 'machine');
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (1105, 'capital');
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (1106, 'win');
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (1107, 'human');
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (1108, 'bar');
INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1101, 1097, 'not', '1971-05-14', '1972-06-15');
INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1102, 1097, 'not', '1971-05-14', '1972-06-16');
INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1103, 1097, 'not', '1971-05-14', '1972-06-17');
INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1104, 1097, 'not', '1971-05-14', '1972-06-18');
INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1109, 1105, 'no', 't1971-05-14', '1976-10-19');
INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1110, 1105, 'no', 't1971-05-14', '1976-10-20');
INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1111, 1105, 'no', 't1971-05-14', '1976-10-21');
INSERT INTO "policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1112, 1105, 'no', 't1971-05-14', '1976-10-22');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT policy_type_code FROM (SELECT * FROM (SELECT * FROM (SELECT policy_type_code, start_date, COUNT(*) AS n FROM policies GROUP BY policy_type_code, start_date) ORDER BY start_date) LIMIT 1);

/*
Gold Result:
('not',)
*/

-- Prediction Query
SELECT policy_type_code FROM policies GROUP BY policy_type_code ORDER BY COUNT(*) DESC, policy_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('no',)
*/