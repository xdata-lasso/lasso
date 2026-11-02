-- Schema DDL
CREATE TABLE "Ref_Payment_Methods" ("payment_method_code" TEXT(10) PRIMARY KEY, "payment_method_description" TEXT(80));

CREATE TABLE "Ref_Service_Types" ("Service_Type_Code" TEXT(15) PRIMARY KEY, "Parent_Service_Type_Code" TEXT(15), "Service_Type_Description" TEXT(255));

CREATE TABLE "Addresses" ("Address_ID" TEXT(100) PRIMARY KEY, "Line_1" TEXT(255), "Line_2" TEXT(255), "City_Town" TEXT(255), "State_County" TEXT(255), "Other_Details" TEXT(255));

CREATE TABLE "Products" ("Product_ID" TEXT(100) PRIMARY KEY, "Product_Name" TEXT(255), "Product_Price" REAL(20, 4), "Product_Description" TEXT(255), "Other_Product_Service_Details" TEXT(255));

CREATE TABLE "Marketing_Regions" ("Marketing_Region_Code" TEXT(15) PRIMARY KEY, "Marketing_Region_Name" TEXT(255), "Marketing_Region_Descriptrion" TEXT(255), "Other_Details" TEXT(255));

CREATE TABLE "Clients" ("Client_ID" INTEGER PRIMARY KEY, "Address_ID" INTEGER, "Customer_Email_Address" TEXT(255), "Customer_Name" TEXT(255), "Customer_Phone" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Address_ID") REFERENCES "Addresses" ("Address_ID"));

CREATE TABLE "Drama_Workshop_Groups" ("Workshop_Group_ID" INTEGER PRIMARY KEY, "Address_ID" INTEGER, "Currency_Code" TEXT(15), "Marketing_Region_Code" TEXT(15), "Store_Name" TEXT(255), "Store_Phone" TEXT(255), "Store_Email_Address" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Address_ID") REFERENCES "Addresses" ("Address_ID"));

CREATE TABLE "Performers" ("Performer_ID" INTEGER PRIMARY KEY, "Address_ID" INTEGER, "Customer_Name" TEXT(255), "Customer_Phone" TEXT(255), "Customer_Email_Address" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Address_ID") REFERENCES "Addresses" ("Address_ID"));

CREATE TABLE "Customers" ("Customer_ID" TEXT(100) PRIMARY KEY, "Address_ID" INTEGER, "Customer_Name" TEXT(255), "Customer_Phone" TEXT(255), "Customer_Email_Address" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Address_ID") REFERENCES "Addresses" ("Address_ID"));

CREATE TABLE "Stores" ("Store_ID" TEXT(100) PRIMARY KEY, "Marketing_Region_Code" TEXT(15), "Address_ID" INTEGER, "Store_Name" TEXT(255), "Store_Phone" TEXT(255), "Store_Email_Address" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Marketing_Region_Code") REFERENCES "Marketing_Regions" ("Marketing_Region_Code"), FOREIGN KEY ("Address_ID") REFERENCES "Addresses" ("Address_ID"));

CREATE TABLE "Bookings" ("Booking_ID" INTEGER PRIMARY KEY, "Workshop_Group_ID" TEXT(100), "Customer_ID" INTEGER, "Status_Code" TEXT(15), "Store_ID" INTEGER, "Order_Date" DATETIME, "Planned_Delivery_Date" DATETIME, "Actual_Delivery_Date" DATETIME, "Other_Order_Details" TEXT(255), FOREIGN KEY ("Workshop_Group_ID") REFERENCES "Drama_Workshop_Groups" ("Workshop_Group_ID"), FOREIGN KEY ("Customer_ID") REFERENCES "Clients" ("Client_ID"));

CREATE TABLE "Performers_in_Bookings" ("Order_ID" INTEGER, "Performer_ID" INTEGER, PRIMARY KEY ("Order_ID", "Performer_ID"), FOREIGN KEY ("Order_ID") REFERENCES "Bookings" ("Booking_ID"), FOREIGN KEY ("Performer_ID") REFERENCES "Performers" ("Performer_ID"));

CREATE TABLE "Customer_Orders" ("Order_ID" INTEGER PRIMARY KEY, "Store_ID" INTEGER, "Customer_ID" INTEGER, "Order_Date" DATETIME, "Planned_Delivery_Date" DATETIME, "Actual_Delivery_Date" DATETIME, "Other_Order_Details" TEXT(255), FOREIGN KEY ("Store_ID") REFERENCES "Stores" ("Store_ID"), FOREIGN KEY ("Customer_ID") REFERENCES "Customers" ("Customer_ID"));

CREATE TABLE "Order_Items" ("Order_Item_ID" INTEGER PRIMARY KEY, "Product_ID" INTEGER, "Order_ID" INTEGER, "Order_Quantity" TEXT(288), "Other_Item_Details" TEXT(255), FOREIGN KEY ("Product_ID") REFERENCES "Products" ("Product_ID"), FOREIGN KEY ("Order_ID") REFERENCES "Customer_Orders" ("Order_ID"));

CREATE TABLE "Invoices" ("Invoice_ID" INTEGER PRIMARY KEY, "payment_method_code" TEXT(15), "Order_ID" INTEGER, "Product_ID" INTEGER, "Order_Quantity" TEXT(288), "Other_Item_Details" TEXT(255), "Order_Item_ID" INTEGER, FOREIGN KEY ("payment_method_code") REFERENCES "Ref_Payment_Methods" ("payment_method_code"), FOREIGN KEY ("Order_ID") REFERENCES "Customer_Orders" ("Order_ID"));

CREATE TABLE "Services" ("Service_ID" INTEGER PRIMARY KEY, "Service_Type_Code" TEXT(15), "Workshop_Group_ID" INTEGER, "Product_Description" TEXT(255), "Product_Name" TEXT(255), "Product_Price" REAL(20, 4), "Other_Product_Service_Details" TEXT(255), FOREIGN KEY ("Service_Type_Code") REFERENCES "Ref_Service_Types" ("Service_Type_Code"), FOREIGN KEY ("Workshop_Group_ID") REFERENCES "Drama_Workshop_Groups" ("Workshop_Group_ID"));

CREATE TABLE "Bookings_Services" ("Order_ID" INTEGER UNIQUE, "Product_ID" INTEGER UNIQUE, PRIMARY KEY ("Order_ID", "Product_ID"), FOREIGN KEY ("Product_ID") REFERENCES "Services" ("Service_ID"), FOREIGN KEY ("Order_ID") REFERENCES "Bookings" ("Booking_ID"));

CREATE TABLE "Invoice_Items" ("Invoice_Item_ID" INTEGER PRIMARY KEY, "Order_ID" INTEGER, "Product_ID" INTEGER, "Invoice_ID" INTEGER, "Order_Item_ID" INTEGER, "Order_Quantity" INTEGER, "Other_Item_Details" TEXT(255), FOREIGN KEY ("Order_ID") REFERENCES "Bookings_Services" ("Order_ID"), FOREIGN KEY ("Product_ID") REFERENCES "Bookings_Services" ("Product_ID"), FOREIGN KEY ("Invoice_ID") REFERENCES "Invoices" ("Invoice_ID"), FOREIGN KEY ("Order_Item_ID") REFERENCES "Order_Items" ("Order_Item_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "city_town", "state_county", "other_details") VALUES ('34352 Smith Place Apt. 400
Heidiberg, SC 99170', 'military', 'board', 'New Justinfort', 'New Hampshire', 'grow');
INSERT INTO "addresses" ("address_id", "line_1", "line_2", "city_town", "state_county", "other_details") VALUES ('0344 Jones Fort Suite 936
New Jeffreyberg, PW 35317', 'the', 'change', 'North Gabrielport', 'Rhode Island', 'smile');
INSERT INTO "ref_service_types" ("service_type_code", "parent_service_type_code", "service_type_description") VALUES ('create', 'approach', 'Wait local state husband available.');
INSERT INTO "ref_service_types" ("service_type_code", "parent_service_type_code", "service_type_description") VALUES ('thank', 'outside', 'Keep light fight I evening.');
INSERT INTO "drama_workshop_groups" ("workshop_group_id", "address_id", "currency_code", "marketing_region_code", "store_name", "store_phone", "store_email_address", "other_details") VALUES (1037, '34352 Smith Place Apt. 400
Heidiberg, SC 99170', 'notice', 'minute', 'Chase Hart', '913-618-6999x3867', 'cindy77@example.org', 'least');
INSERT INTO "drama_workshop_groups" ("workshop_group_id", "address_id", "currency_code", "marketing_region_code", "store_name", "store_phone", "store_email_address", "other_details") VALUES (1040, '0344 Jones Fort Suite 936
New Jeffreyberg, PW 35317', 'professional', 'rich', 'Kyle Preston', '215.545.1680x876', 'ntorres@example.org', 'poor');
INSERT INTO "services" ("service_id", "service_type_code", "workshop_group_id", "product_description", "product_name", "product_price", "other_product_service_details") VALUES (1038, 'create', 1037, 'Way debate decision produce.', 'Christopher Jones', 1039.5, 'able');
INSERT INTO "services" ("service_id", "service_type_code", "workshop_group_id", "product_description", "product_name", "product_price", "other_product_service_details") VALUES (1041, 'thank', 1040, 'Why like impact fly bit claim in.', 'Matthew Morales DDS', 1042.5, 'although');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT store_phone, store_email_address FROM (SELECT LHS.workshop_group_id AS workshop_group_id, LHS.address_id AS address_id, LHS.currency_code AS currency_code, LHS.marketing_region_code AS marketing_region_code, LHS.store_name AS store_name, LHS.store_phone AS store_phone, LHS.store_email_address AS store_email_address, LHS.other_details AS other_details, RHS.service_id AS service_id, RHS.service_type_code AS service_type_code, RHS.product_description AS product_description, RHS.product_name AS product_name, RHS.product_price AS product_price, RHS.other_product_service_details AS other_product_service_details FROM drama_workshop_groups AS LHS INNER JOIN services AS RHS ON (LHS.workshop_group_id = RHS.workshop_group_id)) ORDER BY store_phone, store_email_address NULLS LAST;

/*
Gold Result:
('215.545.1680x876', 'ntorres@example.org')
('913-618-6999x3867', 'cindy77@example.org')
*/

-- Prediction Query
SELECT T1.Store_Phone, T1.Store_Email_Address FROM Drama_Workshop_Groups AS T1 JOIN Services AS T2 ON T1.Workshop_Group_ID = T2.Workshop_Group_ID;

/*
Prediction Result:
('913-618-6999x3867', 'cindy77@example.org')
('215.545.1680x876', 'ntorres@example.org')
*/