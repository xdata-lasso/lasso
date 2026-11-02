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
INSERT INTO "Ref_Payment_Methods" ("payment_method_code", "payment_method_description") VALUES ('31', '50');
INSERT INTO "Ref_Payment_Methods" ("payment_method_code", "payment_method_description") VALUES ('30', '50');
INSERT INTO "Ref_Service_Types" ("service_type_code", "parent_service_type_code", "service_type_description") VALUES ('50', NULL, '59');
INSERT INTO "Ref_Service_Types" ("service_type_code", "parent_service_type_code", "service_type_description") VALUES ('32', '50', '50');
INSERT INTO "Addresses" ("address_id", "line_1", "line_2", "city_town", "state_county", "other_details") VALUES ('34', '50', '50', '50', '50', '50');
INSERT INTO "Addresses" ("address_id", "line_1", "line_2", "city_town", "state_county", "other_details") VALUES ('33', '50', '50', '50', '50', '50');
INSERT INTO "Products" ("product_id", "product_name", "product_price", "product_description", "other_product_service_details") VALUES ('35', '50', 50, '50', '50');
INSERT INTO "Marketing_Regions" ("marketing_region_code", "marketing_region_name", "marketing_region_descriptrion", "other_details") VALUES ('37', '50', '50', '50');
INSERT INTO "Marketing_Regions" ("marketing_region_code", "marketing_region_name", "marketing_region_descriptrion", "other_details") VALUES ('36', '50', '50', '50');
INSERT INTO "Clients" ("client_id", "address_id", "customer_email_address", "customer_name", "customer_phone", "other_details") VALUES (38, '33', '50', '50', '50', '50');
INSERT INTO "Drama_Workshop_Groups" ("workshop_group_id", "address_id", "currency_code", "marketing_region_code", "store_name", "store_phone", "store_email_address", "other_details") VALUES (40, '34', '50', '50', '50', '50', '50', '50');
INSERT INTO "Drama_Workshop_Groups" ("workshop_group_id", "address_id", "currency_code", "marketing_region_code", "store_name", "store_phone", "store_email_address", "other_details") VALUES (39, NULL, '50', '50', '50', '50', '50', '50');
INSERT INTO "Performers" ("performer_id", "address_id", "customer_name", "customer_phone", "customer_email_address", "other_details") VALUES (41, '34', '50', '50', '50', '50');
INSERT INTO "Customers" ("customer_id", "address_id", "customer_name", "customer_phone", "customer_email_address", "other_details") VALUES ('42', '33', '50', '50', '50', '50');
INSERT INTO "Stores" ("store_id", "marketing_region_code", "address_id", "store_name", "store_phone", "store_email_address", "other_details") VALUES ('44', NULL, '33', '50', '50', '50', '50');
INSERT INTO "Stores" ("store_id", "marketing_region_code", "address_id", "store_name", "store_phone", "store_email_address", "other_details") VALUES ('43', '36', '33', '50', '50', '50', '50');
INSERT INTO "Bookings" ("booking_id", "workshop_group_id", "customer_id", "status_code", "store_id", "order_date", "planned_delivery_date", "actual_delivery_date", "other_order_details") VALUES (29, NULL, 38, '50', 50, 50, 50, 50, '50');
INSERT INTO "Performers_in_Bookings" ("order_id", "performer_id") VALUES (29, 41);
INSERT INTO "Customer_Orders" ("order_id", "store_id", "customer_id", "order_date", "planned_delivery_date", "actual_delivery_date", "other_order_details") VALUES (46, '43', '42', 50, 50, 50, '50');
INSERT INTO "Order_Items" ("order_item_id", "product_id", "order_id", "order_quantity", "other_item_details") VALUES (47, '35', 46, '50', '50');
INSERT INTO "Invoices" ("invoice_id", "payment_method_code", "order_id", "product_id", "order_quantity", "other_item_details", "order_item_id") VALUES (48, '30', 46, 50, '50', '50', 50);
INSERT INTO "Services" ("service_id", "service_type_code", "workshop_group_id", "product_description", "product_name", "product_price", "other_product_service_details") VALUES (63, '50', NULL, NULL, NULL, 100, NULL);
INSERT INTO "Services" ("service_id", "service_type_code", "workshop_group_id", "product_description", "product_name", "product_price", "other_product_service_details") VALUES (49, '50', NULL, NULL, NULL, -760, NULL);
INSERT INTO "Bookings_Services" ("order_id", "product_id") VALUES (29, 49);
INSERT INTO "Invoice_Items" ("invoice_item_id", "order_id", "product_id", "invoice_id", "order_item_id", "order_quantity", "other_item_details") VALUES (53, 29, 49, 48, 47, 50, '50');
INSERT INTO "Invoice_Items" ("invoice_item_id", "order_id", "product_id", "invoice_id", "order_item_id", "order_quantity", "other_item_details") VALUES (52, 29, 49, 48, 47, 50, '50');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT service_type_description FROM (SELECT LHS.service_type_code AS service_type_code, LHS.parent_service_type_code AS parent_service_type_code, LHS.service_type_description AS service_type_description, RHS.service_id AS service_id, RHS.workshop_group_id AS workshop_group_id, RHS.product_description AS product_description, RHS.product_name AS product_name, RHS.product_price AS product_price, RHS.other_product_service_details AS other_product_service_details FROM ref_service_types AS LHS INNER JOIN services AS RHS ON (LHS.service_type_code = RHS.service_type_code)) WHERE (product_price >= 100.0) ORDER BY service_type_description;

/*
Gold Result:
('59',)
*/

-- Prediction Query
SELECT T1.Service_Type_Description FROM Ref_Service_Types AS T1 JOIN Services AS T2 ON T1.Service_Type_Code = T2.Service_Type_Code WHERE T2.Product_Price > 100;

/*
Prediction Result:
*/