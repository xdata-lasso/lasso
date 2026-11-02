-- Schema DDL
CREATE TABLE "Customers" ("Customer_ID" INTEGER PRIMARY KEY, "Customer_name" TEXT(40));

CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_name" TEXT(40));

CREATE TABLE "Available_Policies" ("Policy_ID" INTEGER PRIMARY KEY, "policy_type_code" TEXT(15), "Customer_Phone" TEXT(255));

CREATE TABLE "Customers_Policies" ("Customer_ID" INTEGER UNIQUE, "Policy_ID" INTEGER UNIQUE, "Date_Opened" DATE, "Date_Closed" DATE, PRIMARY KEY ("Customer_ID", "Policy_ID"), FOREIGN KEY ("Policy_ID") REFERENCES "Available_Policies" ("Policy_ID"), FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "First_Notification_of_Loss" ("FNOL_ID" INTEGER PRIMARY KEY, "Customer_ID" INTEGER, "Policy_ID" INTEGER, "Service_ID" INTEGER, FOREIGN KEY ("Customer_ID") REFERENCES "Customers_Policies" ("Customer_ID"), FOREIGN KEY ("Policy_ID") REFERENCES "Customers_Policies" ("Policy_ID"), FOREIGN KEY ("Service_ID") REFERENCES "Services" ("Service_ID"));

CREATE TABLE "Claims" ("Claim_ID" INTEGER PRIMARY KEY, "FNOL_ID" INTEGER, "Effective_Date" DATE, FOREIGN KEY ("FNOL_ID") REFERENCES "First_Notification_of_Loss" ("FNOL_ID"));

CREATE TABLE "Settlements" ("Settlement_ID" INTEGER PRIMARY KEY, "Claim_ID" INTEGER, "Effective_Date" DATE, "Settlement_Amount" REAL, FOREIGN KEY ("Claim_ID") REFERENCES "Claims" ("Claim_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (1037, 'brother', '(570)448-2814');
INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (1038, 'finally', '(528)280-9570x154');
INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (1039, 'learn', '991.417.1822');
INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (1055, 'avoid', '9315051834');
INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (1056, 'second', '+1-329-397-3763');
INSERT INTO "available_policies" ("policy_id", "policy_type_code", "customer_phone") VALUES (1057, 'program', '+1-565-966-7010x65133');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1040, 'Shane Henderson');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1041, 'Joshua Blair');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1042, 'Eric Carney');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1058, 'Clifford Ford');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1059, 'Angela Morton');
INSERT INTO "customers" ("customer_id", "customer_name") VALUES (1060, 'Annette Pearson');
INSERT INTO "services" ("service_id", "service_name") VALUES (1043, 'Jessica Holmes');
INSERT INTO "services" ("service_id", "service_name") VALUES (1044, 'Danny Morgan');
INSERT INTO "services" ("service_id", "service_name") VALUES (1045, 'Crystal Robinson');
INSERT INTO "customers_policies" ("customer_id", "policy_id", "date_opened", "date_closed") VALUES (1040, 1037, '1982-02-13', '1985-05-16');
INSERT INTO "customers_policies" ("customer_id", "policy_id", "date_opened", "date_closed") VALUES (1041, 1038, '1982-02-14', '1985-05-17');
INSERT INTO "customers_policies" ("customer_id", "policy_id", "date_opened", "date_closed") VALUES (1042, 1039, '1982-02-15', '1985-05-18');
INSERT INTO "customers_policies" ("customer_id", "policy_id", "date_opened", "date_closed") VALUES (1058, 1055, '1988-08-19', '1991-11-22');
INSERT INTO "customers_policies" ("customer_id", "policy_id", "date_opened", "date_closed") VALUES (1059, 1056, '1988-08-20', '1991-11-23');
INSERT INTO "customers_policies" ("customer_id", "policy_id", "date_opened", "date_closed") VALUES (1060, 1057, '1988-08-21', '1991-11-24');
INSERT INTO "first_notification_of_loss" ("fnol_id", "customer_id", "policy_id", "service_id") VALUES (1046, 1040, 1037, 1043);
INSERT INTO "first_notification_of_loss" ("fnol_id", "customer_id", "policy_id", "service_id") VALUES (1047, 1040, 1037, 1043);
INSERT INTO "first_notification_of_loss" ("fnol_id", "customer_id", "policy_id", "service_id") VALUES (1048, 1040, 1037, 1043);
INSERT INTO "first_notification_of_loss" ("fnol_id", "customer_id", "policy_id", "service_id") VALUES (1049, 1040, 1037, 1043);
INSERT INTO "first_notification_of_loss" ("fnol_id", "customer_id", "policy_id", "service_id") VALUES (1050, 1040, 1037, 1043);
INSERT INTO "first_notification_of_loss" ("fnol_id", "customer_id", "policy_id", "service_id") VALUES (1051, 1040, 1037, 1043);
INSERT INTO "first_notification_of_loss" ("fnol_id", "customer_id", "policy_id", "service_id") VALUES (1052, 1040, 1037, 1043);
INSERT INTO "first_notification_of_loss" ("fnol_id", "customer_id", "policy_id", "service_id") VALUES (1053, 1040, 1037, 1043);
INSERT INTO "first_notification_of_loss" ("fnol_id", "customer_id", "policy_id", "service_id") VALUES (1054, 1040, 1037, 1043);
INSERT INTO "first_notification_of_loss" ("fnol_id", "customer_id", "policy_id", "service_id") VALUES (1063, 1058, 1055, 1044);
INSERT INTO "first_notification_of_loss" ("fnol_id", "customer_id", "policy_id", "service_id") VALUES (1064, 1058, 1055, 1044);
INSERT INTO "first_notification_of_loss" ("fnol_id", "customer_id", "policy_id", "service_id") VALUES (1065, 1058, 1055, 1044);
INSERT INTO "first_notification_of_loss" ("fnol_id", "customer_id", "policy_id", "service_id") VALUES (1066, 1058, 1055, 1044);
INSERT INTO "first_notification_of_loss" ("fnol_id", "customer_id", "policy_id", "service_id") VALUES (1067, 1058, 1055, 1044);
INSERT INTO "first_notification_of_loss" ("fnol_id", "customer_id", "policy_id", "service_id") VALUES (1068, 1058, 1055, 1044);
INSERT INTO "first_notification_of_loss" ("fnol_id", "customer_id", "policy_id", "service_id") VALUES (1069, 1058, 1055, 1044);
INSERT INTO "first_notification_of_loss" ("fnol_id", "customer_id", "policy_id", "service_id") VALUES (1070, 1058, 1055, 1044);
INSERT INTO "first_notification_of_loss" ("fnol_id", "customer_id", "policy_id", "service_id") VALUES (1071, 1058, 1055, 1044);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT service_name FROM (SELECT LHS.service_id AS service_id, LHS.service_name AS service_name, LHS.fnol_id AS fnol_id, LHS.customer_id AS customer_id, LHS.policy_id AS policy_id, LHS.n AS n FROM (SELECT LHS.service_id AS service_id, LHS.service_name AS service_name, LHS.fnol_id AS fnol_id, LHS.customer_id AS customer_id, LHS.policy_id AS policy_id, RHS.n AS n FROM (SELECT LHS.service_id AS service_id, LHS.service_name AS service_name, RHS.fnol_id AS fnol_id, RHS.customer_id AS customer_id, RHS.policy_id AS policy_id FROM services AS LHS INNER JOIN first_notification_of_loss AS RHS ON (LHS.service_id = RHS.service_id)) AS LHS INNER JOIN (SELECT service_id, COUNT(*) AS n FROM first_notification_of_loss GROUP BY service_id) AS RHS ON (LHS.service_id = RHS.service_id)) AS LHS INNER JOIN (SELECT * FROM (SELECT service_id, COUNT(*) AS n FROM first_notification_of_loss GROUP BY service_id) WHERE (n > 2)) AS RHS ON (LHS.service_id = RHS.service_id AND LHS.n = RHS.n)) ORDER BY service_name;

/*
Gold Result:
('Danny Morgan',)
('Jessica Holmes',)
*/

-- Prediction Query
SELECT t2.service_name FROM first_notification_of_loss AS t1 JOIN services AS t2 ON t1.service_id = t2.service_id GROUP BY t1.service_id HAVING COUNT(*) > 2;

/*
Prediction Result:
('Jessica Holmes',)
('Danny Morgan',)
*/