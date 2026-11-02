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
-- Inserting into table: ref_calendar --
INSERT INTO "ref_calendar" ("calendar_date", "day_number") VALUES ('2024-12-15 00:56:33+00:00', 600401919);

-- Inserting into table: all_documents --
INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483648, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483647, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483646, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483645, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483644, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483643, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483642, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483641, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483640, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483639, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483638, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483637, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483636, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483635, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483634, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483633, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483632, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483631, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

-- Inserting into table: employees --
INSERT INTO "employees" ("employee_id", "role_code", "employee_name", "gender_mfu", "date_of_birth", "other_details") VALUES (1, 'role_code_1', 'emp_e61854', 'c', '2022-06-06 02:35:43+00:00', 'emp_00a912');

-- Inserting into table: ref_document_types --
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('document_type_1', 'ref_4df9bb', 'ref_df47b1');

-- Inserting into table: roles --
INSERT INTO "roles" ("role_code", "role_name", "role_description") VALUES ('role_code_1', 'rol_7577a0', 'rol_2c439c');

-- Inserting into table: documents_to_be_destroyed --
INSERT INTO "documents_to_be_destroyed" ("document_id", "actual_destruction_date", "planned_destruction_date", "destruction_authorised_by_employee_id", "destroyed_by_employee_id", "other_details") VALUES (-2147483648, '2024-12-15 00:56:33+00:00', '2024-12-15 00:56:33+00:00', 1, 1, 'doc_89b0bf');

INSERT INTO "documents_to_be_destroyed" ("document_id", "actual_destruction_date", "planned_destruction_date", "destruction_authorised_by_employee_id", "destroyed_by_employee_id", "other_details") VALUES (-2147483647, '2024-12-15 00:56:33+00:00', '2024-12-15 00:56:33+00:00', 1, 1, 'doc_89b0bf');

INSERT INTO "documents_to_be_destroyed" ("document_id", "actual_destruction_date", "planned_destruction_date", "destruction_authorised_by_employee_id", "destroyed_by_employee_id", "other_details") VALUES (-2147483646, '2024-12-15 00:56:33+00:00', '2024-12-15 00:56:33+00:00', 1, 1, 'doc_89b0bf');

INSERT INTO "documents_to_be_destroyed" ("document_id", "actual_destruction_date", "planned_destruction_date", "destruction_authorised_by_employee_id", "destroyed_by_employee_id", "other_details") VALUES (-2147483645, '2024-12-15 00:56:33+00:00', '2024-12-15 00:56:33+00:00', 1, 1, NULL);

INSERT INTO "documents_to_be_destroyed" ("document_id", "actual_destruction_date", "planned_destruction_date", "destruction_authorised_by_employee_id", "destroyed_by_employee_id", "other_details") VALUES (-2147483644, '2024-12-15 00:56:33+00:00', '2024-12-15 00:56:33+00:00', 1, 1, NULL);

INSERT INTO "documents_to_be_destroyed" ("document_id", "actual_destruction_date", "planned_destruction_date", "destruction_authorised_by_employee_id", "destroyed_by_employee_id", "other_details") VALUES (-2147483643, '2024-12-15 00:56:33+00:00', '2024-12-15 00:56:33+00:00', 1, 1, NULL);

INSERT INTO "documents_to_be_destroyed" ("document_id", "actual_destruction_date", "planned_destruction_date", "destruction_authorised_by_employee_id", "destroyed_by_employee_id", "other_details") VALUES (-2147483642, '2024-12-15 00:56:33+00:00', '2024-12-15 00:56:33+00:00', 1, 1, 'doc_89b0bf');

INSERT INTO "documents_to_be_destroyed" ("document_id", "actual_destruction_date", "planned_destruction_date", "destruction_authorised_by_employee_id", "destroyed_by_employee_id", "other_details") VALUES (-2147483641, '2024-12-15 00:56:33+00:00', '2024-12-15 00:56:33+00:00', 1, 1, 'doc_89b0bf');

INSERT INTO "documents_to_be_destroyed" ("document_id", "actual_destruction_date", "planned_destruction_date", "destruction_authorised_by_employee_id", "destroyed_by_employee_id", "other_details") VALUES (-2147483640, '2024-12-15 00:56:33+00:00', '2024-12-15 00:56:33+00:00', 1, 1, 'doc_89b0bf');

INSERT INTO "documents_to_be_destroyed" ("document_id", "actual_destruction_date", "planned_destruction_date", "destruction_authorised_by_employee_id", "destroyed_by_employee_id", "other_details") VALUES (-2147483639, '2024-12-15 00:56:33+00:00', '2024-12-15 00:56:33+00:00', 1, 1, 'doc_89b0bf');

INSERT INTO "documents_to_be_destroyed" ("document_id", "actual_destruction_date", "planned_destruction_date", "destruction_authorised_by_employee_id", "destroyed_by_employee_id", "other_details") VALUES (-2147483638, '2024-12-15 00:56:33+00:00', '2024-12-15 00:56:33+00:00', 1, 1, 'doc_89b0bf');

INSERT INTO "documents_to_be_destroyed" ("document_id", "actual_destruction_date", "planned_destruction_date", "destruction_authorised_by_employee_id", "destroyed_by_employee_id", "other_details") VALUES (-2147483637, '2024-12-15 00:56:33+00:00', '2024-12-15 00:56:33+00:00', 1, 1, 'doc_89b0bf');

INSERT INTO "documents_to_be_destroyed" ("document_id", "actual_destruction_date", "planned_destruction_date", "destruction_authorised_by_employee_id", "destroyed_by_employee_id", "other_details") VALUES (-2147483636, '2024-12-15 00:56:33+00:00', '2024-12-15 00:56:33+00:00', 1, 1, 'doc_89b0bf');

INSERT INTO "documents_to_be_destroyed" ("document_id", "actual_destruction_date", "planned_destruction_date", "destruction_authorised_by_employee_id", "destroyed_by_employee_id", "other_details") VALUES (-2147483635, '2024-12-15 00:56:33+00:00', '2024-12-15 00:56:33+00:00', 1, 1, 'doc_89b0bf');

INSERT INTO "documents_to_be_destroyed" ("document_id", "actual_destruction_date", "planned_destruction_date", "destruction_authorised_by_employee_id", "destroyed_by_employee_id", "other_details") VALUES (-2147483634, '2024-12-15 00:56:33+00:00', '2024-12-15 00:56:33+00:00', 1, 1, 'doc_89b0bf');

INSERT INTO "documents_to_be_destroyed" ("document_id", "actual_destruction_date", "planned_destruction_date", "destruction_authorised_by_employee_id", "destroyed_by_employee_id", "other_details") VALUES (-2147483633, '2024-12-15 00:56:33+00:00', '2024-12-15 00:56:33+00:00', 1, 1, 'doc_89b0bf');

INSERT INTO "documents_to_be_destroyed" ("document_id", "actual_destruction_date", "planned_destruction_date", "destruction_authorised_by_employee_id", "destroyed_by_employee_id", "other_details") VALUES (-2147483632, '2024-12-15 00:56:33+00:00', '2024-12-15 00:56:33+00:00', 1, 1, 'doc_89b0bf');

INSERT INTO "documents_to_be_destroyed" ("document_id", "actual_destruction_date", "planned_destruction_date", "destruction_authorised_by_employee_id", "destroyed_by_employee_id", "other_details") VALUES (-2147483631, '2024-12-15 00:56:33+00:00', '2024-12-15 00:56:33+00:00', 1, 1, 'doc_89b0bf');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT destruction_authorised_by_employee_id, n AS count___ FROM (SELECT destruction_authorised_by_employee_id, other_details, COUNT(*) AS n FROM documents_to_be_destroyed GROUP BY destruction_authorised_by_employee_id, other_details) ORDER BY destruction_authorised_by_employee_id, count___ NULLS LAST;

/*
Gold Result:
(1, 3)
(1, 15)
*/

-- Prediction Query
SELECT Destruction_Authorised_by_Employee_ID, COUNT(*) FROM Documents_to_be_destroyed GROUP BY Destruction_Authorised_by_Employee_ID;

/*
Prediction Result:
(1, 18)
*/