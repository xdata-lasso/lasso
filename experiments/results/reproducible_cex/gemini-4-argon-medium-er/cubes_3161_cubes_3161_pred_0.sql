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
INSERT INTO Services (Service_ID, Service_name) VALUES (1, 'DupName');
INSERT INTO Services (Service_ID, Service_name) VALUES (2, 'DupName');
INSERT INTO First_Notification_of_Loss (FNOL_ID, Customer_ID, Policy_ID, Service_ID) VALUES (1, NULL, NULL, 1);
INSERT INTO First_Notification_of_Loss (FNOL_ID, Customer_ID, Policy_ID, Service_ID) VALUES (2, NULL, NULL, 1);
INSERT INTO First_Notification_of_Loss (FNOL_ID, Customer_ID, Policy_ID, Service_ID) VALUES (3, NULL, NULL, 1);
INSERT INTO First_Notification_of_Loss (FNOL_ID, Customer_ID, Policy_ID, Service_ID) VALUES (4, NULL, NULL, 2);
INSERT INTO First_Notification_of_Loss (FNOL_ID, Customer_ID, Policy_ID, Service_ID) VALUES (5, NULL, NULL, 2);
INSERT INTO First_Notification_of_Loss (FNOL_ID, Customer_ID, Policy_ID, Service_ID) VALUES (6, NULL, NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT service_name FROM (SELECT LHS.service_id AS service_id, LHS.service_name AS service_name, LHS.fnol_id AS fnol_id, LHS.customer_id AS customer_id, LHS.policy_id AS policy_id, LHS.n AS n FROM (SELECT LHS.service_id AS service_id, LHS.service_name AS service_name, LHS.fnol_id AS fnol_id, LHS.customer_id AS customer_id, LHS.policy_id AS policy_id, RHS.n AS n FROM (SELECT LHS.service_id AS service_id, LHS.service_name AS service_name, RHS.fnol_id AS fnol_id, RHS.customer_id AS customer_id, RHS.policy_id AS policy_id FROM services AS LHS INNER JOIN first_notification_of_loss AS RHS ON (LHS.service_id = RHS.service_id)) AS LHS INNER JOIN (SELECT service_id, COUNT(*) AS n FROM first_notification_of_loss GROUP BY service_id) AS RHS ON (LHS.service_id = RHS.service_id)) AS LHS INNER JOIN (SELECT * FROM (SELECT service_id, COUNT(*) AS n FROM first_notification_of_loss GROUP BY service_id) WHERE (n > 2)) AS RHS ON (LHS.service_id = RHS.service_id AND LHS.n = RHS.n)) ORDER BY service_name;

/*
Gold Result:
('DupName',)
*/

-- Prediction Query
SELECT t2.service_name FROM first_notification_of_loss AS t1 JOIN services AS t2 ON t1.service_id = t2.service_id GROUP BY t1.service_id HAVING COUNT(*) > 2;

/*
Prediction Result:
('DupName',)
('DupName',)
*/