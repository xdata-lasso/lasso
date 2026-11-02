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
INSERT INTO "ref_calendar" ("calendar_date", "day_number") VALUES ('1976-07-07', 1010);
INSERT INTO "ref_calendar" ("calendar_date", "day_number") VALUES ('1979-10-10', 1014);
INSERT INTO "ref_calendar" ("calendar_date", "day_number") VALUES ('1978-09-09', NULL);
INSERT INTO "ref_calendar" ("calendar_date", "day_number") VALUES ('1981-01-12', NULL);
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('result', 'Lisa Jackson', 'Clear here writer policy news.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('skin', 'Stephanie Ross', 'Young catch management sense technology.');
INSERT INTO "roles" ("role_code", "role_name", "role_description") VALUES ('Journalist, broadcasting', 'Banker', 'Estate manager/land agent');
INSERT INTO "roles" ("role_code", "role_name", "role_description") VALUES ('Designer, ceramics/pottery', 'Designer, jewellery', 'Pharmacist, hospital');
INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (1011, '1976-07-07', 'result', 'Renee Morales', 'Decision wall then fire.', 'reality');
INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (1015, '1979-10-10', 'skin', 'Janice Carlson', 'More wife team activity result race Mr.', 'example');
INSERT INTO "employees" ("employee_id", "role_code", "employee_name", "gender_mfu", "date_of_birth", "other_details") VALUES (1012, 'Journalist, broadcasting', 'Dr. Marvin Thomas Jr.', 'size', '1977-08-08', 'option');
INSERT INTO "employees" ("employee_id", "role_code", "employee_name", "gender_mfu", "date_of_birth", "other_details") VALUES (1013, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "employees" ("employee_id", "role_code", "employee_name", "gender_mfu", "date_of_birth", "other_details") VALUES (1016, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "documents_to_be_destroyed" ("document_id", "actual_destruction_date", "planned_destruction_date", "destruction_authorised_by_employee_id", "destroyed_by_employee_id", "other_details") VALUES (1011, '1976-07-07', '1978-09-09', 1012, 1013, 'nothing');
INSERT INTO "documents_to_be_destroyed" ("document_id", "actual_destruction_date", "planned_destruction_date", "destruction_authorised_by_employee_id", "destroyed_by_employee_id", "other_details") VALUES (1015, '1979-10-10', '1981-01-12', 1012, 1016, 'everyone');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT destruction_authorised_by_employee_id, n AS count___ FROM (SELECT destruction_authorised_by_employee_id, other_details, COUNT(*) AS n FROM documents_to_be_destroyed GROUP BY destruction_authorised_by_employee_id, other_details) ORDER BY destruction_authorised_by_employee_id, count___ NULLS LAST;

/*
Gold Result:
(1012, 1)
(1012, 1)
*/

-- Prediction Query
SELECT Destruction_Authorised_by_Employee_ID, COUNT(*) FROM Documents_to_be_destroyed GROUP BY Destruction_Authorised_by_Employee_ID;

/*
Prediction Result:
(1012, 2)
*/