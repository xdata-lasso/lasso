-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_Details" TEXT(255));

CREATE TABLE "Customer_Policies" ("Policy_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_Type_Code" TEXT(15), "Start_Date" DATE, "End_Date" DATE, FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Claims" ("Claim_ID" INTEGER PRIMARY KEY, "Policy_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, FOREIGN KEY ("Policy_ID") REFERENCES "Customer_Policies" ("Policy_ID"));

CREATE TABLE "Settlements" ("Settlement_ID" INTEGER PRIMARY KEY, "Claim_ID" INTEGER, "Date_Claim_Made" DATE, "Date_Claim_Settled" DATE, "Amount_Claimed" INTEGER, "Amount_Settled" INTEGER, "Customer_Policy_ID" INTEGER, FOREIGN KEY ("Claim_ID") REFERENCES "Claims" ("Claim_ID"));

CREATE TABLE "Payments" ("Payment_ID" INTEGER PRIMARY KEY, "Settlement_ID" INTEGER, "Payment_Method_Code" TEXT(255), "Date_Payment_Made" DATE, "Amount_Payment" INTEGER, FOREIGN KEY ("Settlement_ID") REFERENCES "Settlements" ("Settlement_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (1097, 'they');
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (1098, 'his');
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (1099, 'commercial');
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (1109, 'away');
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (1110, 'politics');
INSERT INTO "customers" ("customer_id", "customer_details") VALUES (1111, 'Congress');
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1100, 1097, 'hospital', '1998-02-07', '1972-05-10');
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1101, 1097, 'hospital', '1998-02-08', '1972-05-11');
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1102, 1097, 'hospital', '1998-02-09', '1972-05-12');
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1103, 1097, 'hospital', '1975-08-13', '1978-11-16');
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1104, 1097, 'hospital', '1975-08-14', '1978-11-17');
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1105, 1097, 'hospital', '1975-08-15', '1978-11-18');
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1106, 1097, 'hospital', '1981-03-19', '1984-06-22');
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1107, 1097, 'hospital', '1981-03-20', '1984-06-23');
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1108, 1097, 'hospital', '1981-03-21', '1984-06-24');
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1112, 1109, 'hospital', '1987-09-02', '1990-01-05');
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1113, 1109, 'hospital', '1987-09-03', '1990-01-06');
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1114, 1109, 'hospital', '1987-09-04', '1990-01-07');
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1115, 1109, 'hospital', '1993-04-08', '1996-07-11');
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1116, 1109, 'hospital', '1993-04-09', '1996-07-12');
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1117, 1109, 'hospital', '1993-04-10', '1996-07-13');
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1118, 1109, 'hospital', '1970-10-14', '1973-02-17');
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1119, 1109, 'hospital', '1970-10-15', '1973-02-18');
INSERT INTO "customer_policies" ("policy_id", "customer_id", "policy_type_code", "start_date", "end_date") VALUES (1120, 1109, 'hospital', '1970-10-16', '1973-02-19');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT customer_details, customer_id FROM (SELECT LHS.customer_id AS customer_id, LHS.customer_details AS customer_details, LHS.policy_id AS policy_id, LHS.policy_type_code AS policy_type_code, LHS.start_date AS start_date, LHS.end_date AS end_date, LHS.n AS n FROM (SELECT LHS.customer_id AS customer_id, LHS.customer_details AS customer_details, LHS.policy_id AS policy_id, LHS.policy_type_code AS policy_type_code, LHS.start_date AS start_date, LHS.end_date AS end_date, RHS.n AS n FROM (SELECT LHS.customer_id AS customer_id, LHS.customer_details AS customer_details, RHS.policy_id AS policy_id, RHS.policy_type_code AS policy_type_code, RHS.start_date AS start_date, RHS.end_date AS end_date FROM customers AS LHS INNER JOIN customer_policies AS RHS ON (LHS.customer_id = RHS.customer_id)) AS LHS INNER JOIN (SELECT customer_id, COUNT(*) AS n FROM customer_policies GROUP BY customer_id) AS RHS ON (LHS.customer_id = RHS.customer_id)) AS LHS INNER JOIN (SELECT * FROM (SELECT customer_id, COUNT(*) AS n FROM customer_policies GROUP BY customer_id) WHERE (n <> 1)) AS RHS ON (LHS.customer_id = RHS.customer_id AND LHS.n = RHS.n)) ORDER BY customer_details, customer_id NULLS LAST;

/*
Gold Result:
('away', 1109)
('they', 1097)
*/

-- Prediction Query
SELECT T1.customer_details, T1.customer_id FROM Customers AS T1 JOIN Customer_Policies AS T2 ON T1.Customer_id = T2.Customer_id GROUP BY T1.customer_id HAVING COUNT(*) > 1;

/*
Prediction Result:
('they', 1097)
('away', 1109)
*/