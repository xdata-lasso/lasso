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
INSERT INTO Customers (Customer_ID, Customer_name) VALUES (1, 'Alice Smith');
INSERT INTO Customers (Customer_ID, Customer_name) VALUES (2, 'Bob Jones');
INSERT INTO Customers (Customer_ID, Customer_name) VALUES (3, 'Charlie Brown');
INSERT INTO Customers (Customer_ID, Customer_name) VALUES (4, 'Diana Prince');
INSERT INTO Available_Policies (Policy_ID, policy_type_code, Customer_Phone) VALUES (101, 'AUTO', '555-0101');
INSERT INTO Available_Policies (Policy_ID, policy_type_code, Customer_Phone) VALUES (102, 'HOME', '555-0102');
INSERT INTO Available_Policies (Policy_ID, policy_type_code, Customer_Phone) VALUES (103, 'LIFE', '555-0103');
INSERT INTO Available_Policies (Policy_ID, policy_type_code, Customer_Phone) VALUES (104, 'AUTO', '555-0104');
INSERT INTO Customers_Policies (Customer_ID, Policy_ID, Date_Opened, Date_Closed) VALUES (1, 101, '2022-01-01', '2023-01-01');
INSERT INTO Customers_Policies (Customer_ID, Policy_ID, Date_Opened, Date_Closed) VALUES (2, 102, '2022-02-01', '2023-02-01');
INSERT INTO Customers_Policies (Customer_ID, Policy_ID, Date_Opened, Date_Closed) VALUES (3, 103, '2022-03-01', '2023-03-01');
INSERT INTO Customers_Policies (Customer_ID, Policy_ID, Date_Opened, Date_Closed) VALUES (4, 104, '2022-04-01', '2023-04-01');
INSERT INTO Services (Service_ID, Service_name) VALUES (1, 'Windshield Repair');
INSERT INTO Services (Service_ID, Service_name) VALUES (2, 'Towing');
INSERT INTO Services (Service_ID, Service_name) VALUES (3, 'Battery Jump');
INSERT INTO Services (Service_ID, Service_name) VALUES (4, 'Lockout Service');
INSERT INTO Services (Service_ID, Service_name) VALUES (5, 'Tire Change');
INSERT INTO First_Notification_of_Loss (FNOL_ID, Customer_ID, Policy_ID, Service_ID) VALUES (1, 1, 101, 1);
INSERT INTO First_Notification_of_Loss (FNOL_ID, Customer_ID, Policy_ID, Service_ID) VALUES (2, 2, 102, 1);
INSERT INTO First_Notification_of_Loss (FNOL_ID, Customer_ID, Policy_ID, Service_ID) VALUES (3, 3, 103, 1);
INSERT INTO First_Notification_of_Loss (FNOL_ID, Customer_ID, Policy_ID, Service_ID) VALUES (4, 1, 101, 2);
INSERT INTO First_Notification_of_Loss (FNOL_ID, Customer_ID, Policy_ID, Service_ID) VALUES (5, 2, 102, 2);
INSERT INTO First_Notification_of_Loss (FNOL_ID, Customer_ID, Policy_ID, Service_ID) VALUES (6, 1, 101, 3);
INSERT INTO First_Notification_of_Loss (FNOL_ID, Customer_ID, Policy_ID, Service_ID) VALUES (7, 2, 102, 3);
INSERT INTO First_Notification_of_Loss (FNOL_ID, Customer_ID, Policy_ID, Service_ID) VALUES (8, 3, 103, 3);
INSERT INTO First_Notification_of_Loss (FNOL_ID, Customer_ID, Policy_ID, Service_ID) VALUES (9, 4, 104, 3);
INSERT INTO First_Notification_of_Loss (FNOL_ID, Customer_ID, Policy_ID, Service_ID) VALUES (10, 1, 101, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT service_name FROM (SELECT LHS.service_id AS service_id, LHS.service_name AS service_name, LHS.fnol_id AS fnol_id, LHS.customer_id AS customer_id, LHS.policy_id AS policy_id, LHS.n AS n FROM (SELECT LHS.service_id AS service_id, LHS.service_name AS service_name, LHS.fnol_id AS fnol_id, LHS.customer_id AS customer_id, LHS.policy_id AS policy_id, RHS.n AS n FROM (SELECT LHS.service_id AS service_id, LHS.service_name AS service_name, RHS.fnol_id AS fnol_id, RHS.customer_id AS customer_id, RHS.policy_id AS policy_id FROM services AS LHS INNER JOIN first_notification_of_loss AS RHS ON (LHS.service_id = RHS.service_id)) AS LHS INNER JOIN (SELECT service_id, COUNT(*) AS n FROM first_notification_of_loss GROUP BY service_id) AS RHS ON (LHS.service_id = RHS.service_id)) AS LHS INNER JOIN (SELECT * FROM (SELECT service_id, COUNT(*) AS n FROM first_notification_of_loss GROUP BY service_id) WHERE (n > 2)) AS RHS ON (LHS.service_id = RHS.service_id AND LHS.n = RHS.n)) ORDER BY service_name;

/*
Gold Result:
('Battery Jump',)
('Windshield Repair',)
*/

-- Prediction Query
SELECT t2.service_name FROM first_notification_of_loss AS t1 JOIN services AS t2 ON t1.service_id = t2.service_id GROUP BY t1.service_id HAVING COUNT(*) > 2;

/*
Prediction Result:
('Windshield Repair',)
('Battery Jump',)
*/