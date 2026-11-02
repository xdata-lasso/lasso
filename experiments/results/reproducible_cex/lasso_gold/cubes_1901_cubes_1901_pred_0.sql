-- Schema DDL
CREATE TABLE "Ref_Document_Types" ("Document_Type_Code" TEXT(15) PRIMARY KEY, "Document_Type_Name" TEXT(255), "Document_Type_Description" TEXT(255));

CREATE TABLE "Ref_Calendar" ("Calendar_Date" DATETIME PRIMARY KEY, "Day_Number" INTEGER);

CREATE TABLE "Ref_Locations" ("Location_Code" TEXT(15) PRIMARY KEY, "Location_Name" TEXT(255), "Location_Description" TEXT(255));

CREATE TABLE "Roles" ("Role_Code" TEXT(15) PRIMARY KEY, "Role_Name" TEXT(255), "Role_Description" TEXT(255));

CREATE TABLE "All_Documents" ("Document_ID" INTEGER PRIMARY KEY, "Date_Stored" DATETIME, "Document_Type_Code" TEXT(15), "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Date_Stored") REFERENCES "Ref_Calendar" ("Calendar_Date"), FOREIGN KEY ("Document_Type_Code") REFERENCES "Ref_Document_Types" ("Document_Type_Code"));

CREATE TABLE "Employees" ("Employee_ID" INTEGER PRIMARY KEY, "Role_Code" TEXT(15), "Employee_Name" TEXT(255), "Gender_MFU" TEXT(1), "Date_of_Birth" DATETIME, "Other_Details" TEXT(255), FOREIGN KEY ("Role_Code") REFERENCES "Roles" ("Role_Code"));

CREATE TABLE "Document_Locations" ("Document_ID" INTEGER, "Location_Code" TEXT(15), "Date_in_Location_From" DATETIME, "Date_in_Locaton_To" DATETIME, PRIMARY KEY ("Document_ID", "Location_Code", "Date_in_Location_From"), FOREIGN KEY ("Document_ID") REFERENCES "All_Documents" ("Document_ID"), FOREIGN KEY ("Date_in_Locaton_To") REFERENCES "Ref_Calendar" ("Calendar_Date"), FOREIGN KEY ("Date_in_Location_From") REFERENCES "Ref_Calendar" ("Calendar_Date"), FOREIGN KEY ("Location_Code") REFERENCES "Ref_Locations" ("Location_Code"));

CREATE TABLE "Documents_to_be_Destroyed" ("Document_ID" INTEGER PRIMARY KEY, "Actual_Destruction_Date" DATETIME, "Planned_Destruction_Date" DATETIME, "Destruction_Authorised_by_Employee_ID" INTEGER, "Destroyed_by_Employee_ID" INTEGER, "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "All_Documents" ("Document_ID"), FOREIGN KEY ("Actual_Destruction_Date") REFERENCES "Ref_Calendar" ("Calendar_Date"), FOREIGN KEY ("Planned_Destruction_Date") REFERENCES "Ref_Calendar" ("Calendar_Date"), FOREIGN KEY ("Destruction_Authorised_by_Employee_ID") REFERENCES "Employees" ("Employee_ID"), FOREIGN KEY ("Destroyed_by_Employee_ID") REFERENCES "Employees" ("Employee_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ref_calendar" ("calendar_date", "day_number") VALUES ('1997-06-05', 1029);
INSERT INTO "ref_calendar" ("calendar_date", "day_number") VALUES ('1998-07-06', NULL);
INSERT INTO "ref_calendar" ("calendar_date", "day_number") VALUES ('1970-08-07', NULL);
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('join', 'Richard Adams', 'Executive fear only.');
INSERT INTO "ref_locations" ("location_code", "location_name", "location_description") VALUES ('Unit 7278 Box 7558
DPO AP 49942', '39636 Louis Mountains Suite 627
East Wayneshire, MA 13655', '87026 Charles Tunnel Suite 596
Port Markside, MS 42006');
INSERT INTO "ref_locations" ("location_code", "location_name", "location_description") VALUES ('172 Berger Cape
Lauraport, MI 49632', NULL, NULL);
INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (1030, '1997-06-05', 'join', 'Robin CV', 'Responsibility service their along attention piece TV young.', 'skin');
INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (1040, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (1030, 'Unit 7278 Box 7558
DPO AP 49942', '1998-07-06', '1997-06-05');
INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (1040, '172 Berger Cape
Lauraport, MI 49632', '1970-08-07', '1997-06-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "date_in_location_from", "date_in_locaton_to" FROM (SELECT * FROM "document_locations" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "all_documents" WHERE ("document_name" <> 'Robin CV')) AS RHS WHERE (LHS.document_id = RHS.document_id))) ORDER BY date_in_location_from, "date_in_location_from" NULLS LAST, "date_in_locaton_to" NULLS LAST;

/*
Gold Result:
('1970-08-07', '1997-06-05')
('1998-07-06', '1997-06-05')
*/

-- Prediction Query
SELECT T1.date_in_location_from, T1.date_in_locaton_to FROM Document_locations AS T1 JOIN All_documents AS T2 ON T1.document_id = T2.document_id WHERE T2.document_name = 'Robin CV';

/*
Prediction Result:
('1998-07-06', '1997-06-05')
*/