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
INSERT INTO "Ref_Document_Types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('12', '13', '13');
INSERT INTO "Ref_Document_Types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('11', '13', '13');
INSERT INTO "Ref_Calendar" ("calendar_date", "day_number") VALUES (14, 13);
INSERT INTO "Ref_Calendar" ("calendar_date", "day_number") VALUES (13, 13);
INSERT INTO "Ref_Locations" ("location_code", "location_name", "location_description") VALUES ('16', '13', '13');
INSERT INTO "Ref_Locations" ("location_code", "location_name", "location_description") VALUES ('15', '13', '13');
INSERT INTO "Roles" ("role_code", "role_name", "role_description") VALUES ('18', '13', '13');
INSERT INTO "Roles" ("role_code", "role_name", "role_description") VALUES ('17', '13', '13');
INSERT INTO "All_Documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (20, 13, '11', '13', '13', '13');
INSERT INTO "All_Documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (19, 14, '11', '13', '13', '13');
INSERT INTO "Employees" ("employee_id", "role_code", "employee_name", "gender_mfu", "date_of_birth", "other_details") VALUES (21, '17', '13', '13', 13, '13');
INSERT INTO "Document_Locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (19, '15', 13, 13);
INSERT INTO "Documents_to_be_Destroyed" ("document_id", "actual_destruction_date", "planned_destruction_date", "destruction_authorised_by_employee_id", "destroyed_by_employee_id", "other_details") VALUES (20, 13, 14, NULL, 21, '26');
INSERT INTO "Documents_to_be_Destroyed" ("document_id", "actual_destruction_date", "planned_destruction_date", "destruction_authorised_by_employee_id", "destroyed_by_employee_id", "other_details") VALUES (19, 13, 13, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT destruction_authorised_by_employee_id, n AS count___ FROM (SELECT destruction_authorised_by_employee_id, other_details, COUNT(*) AS n FROM documents_to_be_destroyed GROUP BY destruction_authorised_by_employee_id, other_details) ORDER BY destruction_authorised_by_employee_id, count___ NULLS LAST;

/*
Gold Result:
(None, 1)
(None, 1)
*/

-- Prediction Query
SELECT Destruction_Authorised_by_Employee_ID, COUNT(*) FROM Documents_to_be_destroyed GROUP BY Destruction_Authorised_by_Employee_ID;

/*
Prediction Result:
(None, 2)
*/