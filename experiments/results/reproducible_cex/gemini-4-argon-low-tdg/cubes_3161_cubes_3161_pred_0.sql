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
-- DATASET 1
-- Tests exact boundary conditions for COUNT(*): 0, 1, 2, 3, and 4.
-- Also tests ORDER BY service_name (desc vs asc) and DISTINCT on service_name.
INSERT INTO Customers (Customer_ID, Customer_name) VALUES (1, 'Alice');
INSERT INTO Available_Policies (Policy_ID, policy_type_code, Customer_Phone) VALUES (10, 'AUTO', '555-0001');
INSERT INTO Customers_Policies (Customer_ID, Policy_ID, Date_Opened, Date_Closed) VALUES (1, 10, '2020-01-01', '2025-01-01');
INSERT INTO Services (Service_ID, Service_name) VALUES (1, 'Zero_Service');
INSERT INTO Services (Service_ID, Service_name) VALUES (2, 'One_Service');
INSERT INTO Services (Service_ID, Service_name) VALUES (3, 'Two_Service');
INSERT INTO Services (Service_ID, Service_name) VALUES (4, 'Z_Three_Service');
INSERT INTO Services (Service_ID, Service_name) VALUES (5, 'A_Four_Service');
INSERT INTO First_Notification_of_Loss (FNOL_ID, Customer_ID, Policy_ID, Service_ID) VALUES (101, 1, 10, 2);
INSERT INTO First_Notification_of_Loss (FNOL_ID, Customer_ID, Policy_ID, Service_ID) VALUES (102, 1, 10, 3);
INSERT INTO First_Notification_of_Loss (FNOL_ID, Customer_ID, Policy_ID, Service_ID) VALUES (103, 1, 10, 3);
INSERT INTO First_Notification_of_Loss (FNOL_ID, Customer_ID, Policy_ID, Service_ID) VALUES (104, 1, 10, 4);
INSERT INTO First_Notification_of_Loss (FNOL_ID, Customer_ID, Policy_ID, Service_ID) VALUES (105, 1, 10, 4);
INSERT INTO First_Notification_of_Loss (FNOL_ID, Customer_ID, Policy_ID, Service_ID) VALUES (106, 1, 10, 4);
INSERT INTO First_Notification_of_Loss (FNOL_ID, Customer_ID, Policy_ID, Service_ID) VALUES (107, 1, 10, 5);
INSERT INTO First_Notification_of_Loss (FNOL_ID, Customer_ID, Policy_ID, Service_ID) VALUES (108, 1, 10, 5);
INSERT INTO First_Notification_of_Loss (FNOL_ID, Customer_ID, Policy_ID, Service_ID) VALUES (109, 1, 10, 5);
INSERT INTO First_Notification_of_Loss (FNOL_ID, Customer_ID, Policy_ID, Service_ID) VALUES (110, 1, 10, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT service_name FROM (SELECT LHS.service_id AS service_id, LHS.service_name AS service_name, LHS.fnol_id AS fnol_id, LHS.customer_id AS customer_id, LHS.policy_id AS policy_id, LHS.n AS n FROM (SELECT LHS.service_id AS service_id, LHS.service_name AS service_name, LHS.fnol_id AS fnol_id, LHS.customer_id AS customer_id, LHS.policy_id AS policy_id, RHS.n AS n FROM (SELECT LHS.service_id AS service_id, LHS.service_name AS service_name, RHS.fnol_id AS fnol_id, RHS.customer_id AS customer_id, RHS.policy_id AS policy_id FROM services AS LHS INNER JOIN first_notification_of_loss AS RHS ON (LHS.service_id = RHS.service_id)) AS LHS INNER JOIN (SELECT service_id, COUNT(*) AS n FROM first_notification_of_loss GROUP BY service_id) AS RHS ON (LHS.service_id = RHS.service_id)) AS LHS INNER JOIN (SELECT * FROM (SELECT service_id, COUNT(*) AS n FROM first_notification_of_loss GROUP BY service_id) WHERE (n > 2)) AS RHS ON (LHS.service_id = RHS.service_id AND LHS.n = RHS.n)) ORDER BY service_name;

/*
Gold Result:
('A_Four_Service',)
('Z_Three_Service',)
*/

-- Prediction Query
SELECT t2.service_name FROM first_notification_of_loss AS t1 JOIN services AS t2 ON t1.service_id = t2.service_id GROUP BY t1.service_id HAVING COUNT(*) > 2;

/*
Prediction Result:
('Z_Three_Service',)
('A_Four_Service',)
*/