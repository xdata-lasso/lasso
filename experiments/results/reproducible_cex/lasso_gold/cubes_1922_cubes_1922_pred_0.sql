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
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('everyone', 'Jessica Silva', 'Despite young meeting before another body.');
INSERT INTO "roles" ("role_code", "role_name", "role_description") VALUES ('Journalist, broadcasting', 'Banker', 'Estate manager/land agent');
INSERT INTO "roles" ("role_code", "role_name", "role_description") VALUES ('Designer, jewellery', 'Pharmacist, hospital', 'Therapist, occupational');
INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (1011, '1976-07-07', 'result', 'Renee Morales', 'Decision wall then fire.', 'reality');
INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (1015, '1979-10-10', 'everyone', 'James Ferrell', 'Edge network wall quite boy those seem.', 'specific');
INSERT INTO "employees" ("employee_id", "role_code", "employee_name", "gender_mfu", "date_of_birth", "other_details") VALUES (1013, 'Journalist, broadcasting', 'Dr. Marvin Thomas Jr.', 'size', '1977-08-08', 'option');
INSERT INTO "employees" ("employee_id", "role_code", "employee_name", "gender_mfu", "date_of_birth", "other_details") VALUES (1012, 'Designer, jewellery', 'Ashley Graham', 'long', '1980-11-11', 'about');
INSERT INTO "employees" ("employee_id", "role_code", "employee_name", "gender_mfu", "date_of_birth", "other_details") VALUES (1017, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "documents_to_be_destroyed" ("document_id", "actual_destruction_date", "planned_destruction_date", "destruction_authorised_by_employee_id", "destroyed_by_employee_id", "other_details") VALUES (1011, '1976-07-07', '1978-09-09', 1013, 1013, 'nothing');
INSERT INTO "documents_to_be_destroyed" ("document_id", "actual_destruction_date", "planned_destruction_date", "destruction_authorised_by_employee_id", "destroyed_by_employee_id", "other_details") VALUES (1015, '1979-10-10', '1981-01-12', 1017, 1012, 'seven');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT destroyed_by_employee_id FROM documents_to_be_destroyed ORDER BY destroyed_by_employee_id;

/*
Gold Result:
(1012,)
(1013,)
*/

-- Prediction Query
SELECT DISTINCT Destroyed_by_Employee_ID FROM Documents_to_be_destroyed;

/*
Prediction Result:
(1013,)
(1012,)
*/