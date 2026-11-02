-- Schema DDL
CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "gender" TEXT(1), "first_name" TEXT(80), "last_name" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_type_code" TEXT(20), "address_line_1" TEXT(80), "address_line_2" TEXT(80), "town_city" TEXT(80), "state" TEXT(80), "email_address" TEXT(255), "phone_number" TEXT(80));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "parent_product_id" INTEGER, "product_category_code" TEXT(20), "date_product_first_available" DATETIME, "date_product_discontinued" DATETIME, "product_name" TEXT(80), "product_description" TEXT(255), "product_price" REAL(19, 4));

CREATE TABLE "Complaints" ("customer_id" INTEGER, "product_id" INTEGER, "staff_id" INTEGER, "complaint_id" INTEGER, "complaint_outcome_code" TEXT(20), "complaint_status_code" TEXT(20), "complaint_type_code" TEXT(20), "date_complaint_raised" DATETIME, "date_complaint_closed" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customers" ("customer_id", "customer_type_code", "address_line_1", "address_line_2", "town_city", "state", "email_address", "phone_number") VALUES (1001, 'purpose', '21819 Johnson Course
East William, AK 74064', '7525 Clark Grove Apt. 928
East Steven, KY 84387', 'Port Brandonville', 'Missouri', 'tasha01@example.net', '001-248-728-1489x3252');
INSERT INTO "customers" ("customer_id", "customer_type_code", "address_line_1", "address_line_2", "town_city", "state", "email_address", "phone_number") VALUES (1002, 'brother', '79402 Peterson Drives Apt. 511
Davisstad, PA 35172', '503 Linda Locks
Carlshire, FM 94599', 'Lake Ernest', 'Rhode Island', 'kayla51@example.com', '401.454.3039x1171');
INSERT INTO "customers" ("customer_id", "customer_type_code", "address_line_1", "address_line_2", "town_city", "state", "email_address", "phone_number") VALUES (1003, 'ago', '161 Calderon River Suite 931
Lake Jeremyport, CO 31013', '7242 Julie Plain Suite 969
Coxberg, NY 65187', 'Carlsonfurt', 'New Jersey', 'amoore@example.net', '+1-978-924-8963x83465');
INSERT INTO "products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (1004, 1007, 'camera', '1970-01-01', '1973-04-04', 'Alex Spencer', 'Audience draw protect Democrat car very.', 1010.5);
INSERT INTO "products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (1005, 1012.0, 'end', '1970-01-02', '1973-04-05', 'Adrienne Zimmerman', 'Office drug list imagine behind probably great.', 1027.5);
INSERT INTO "products" ("product_id", "parent_product_id", "product_category_code", "date_product_first_available", "date_product_discontinued", "product_name", "product_description", "product_price") VALUES (1006, 1017.0, 'down', '1970-01-03', '1973-04-06', 'Austin Johnson', 'Level rock pull worker better I.', 1044.5);
INSERT INTO "staff" ("staff_id", "gender", "first_name", "last_name", "email_address", "phone_number") VALUES (1013, 'group', 'Daniel', 'Taylor', 'ramosmichelle@example.net', '(977)436-0260x64746');
INSERT INTO "staff" ("staff_id", "gender", "first_name", "last_name", "email_address", "phone_number") VALUES (1014, 'such', 'James', 'White', 'williamsyvette@example.org', '243.909.8050');
INSERT INTO "staff" ("staff_id", "gender", "first_name", "last_name", "email_address", "phone_number") VALUES (1015, 'training', 'Amanda', 'Ford', 'housemelinda@example.org', '582.208.1219x13619');
INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (1001, 1004, 1013, 1016, 'president', 'beat', 'kind', '1976-07-07', '1979-10-10');
INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (1001, 1004, 1013, 1025.0, 'president', 'beat', 'really', '1976-07-08', '1979-10-11');
INSERT INTO "complaints" ("customer_id", "product_id", "staff_id", "complaint_id", "complaint_outcome_code", "complaint_status_code", "complaint_type_code", "date_complaint_raised", "date_complaint_closed") VALUES (1001, 1004, 1013, 1034.0, 'president', 'beat', 'past', '1976-07-09', '1979-10-12');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT complaint_status_code FROM (SELECT complaint_outcome_code, complaint_status_code, COUNT(*) AS n FROM complaints GROUP BY complaint_outcome_code, complaint_status_code) WHERE (n >= 3) ORDER BY complaint_status_code;

/*
Gold Result:
('beat',)
*/

-- Prediction Query
SELECT complaint_status_code FROM complaints GROUP BY complaint_status_code HAVING COUNT(*) > 3;

/*
Prediction Result:
*/