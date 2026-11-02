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
INSERT INTO "Ref_Document_Types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('Editor21', 'Editor45', 'Editor45');
INSERT INTO "Ref_Document_Types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('Editor20', 'Editor45', 'Editor45');
INSERT INTO "Ref_Calendar" ("calendar_date", "day_number") VALUES (23, 45);
INSERT INTO "Ref_Calendar" ("calendar_date", "day_number") VALUES (22, 45);
INSERT INTO "Ref_Locations" ("location_code", "location_name", "location_description") VALUES ('Editor25', 'Editor45', 'Editor45');
INSERT INTO "Ref_Locations" ("location_code", "location_name", "location_description") VALUES ('Editor24', 'Editor45', 'Editor45');
INSERT INTO "Roles" ("role_code", "role_name", "role_description") VALUES ('Editor34', 'Editor', 'Editor35');
INSERT INTO "Roles" ("role_code", "role_name", "role_description") VALUES ('Editor45', 'Editor', NULL);
INSERT INTO "All_Documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (27, 23, 'Editor21', 'Editor45', 'Editor45', 'Editor45');
INSERT INTO "All_Documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (26, 23, NULL, 'Editor45', 'Editor45', 'Editor45');
INSERT INTO "Employees" ("employee_id", "role_code", "employee_name", "gender_mfu", "date_of_birth", "other_details") VALUES (41, 'Editor45', NULL, 'Editor42', 43, 'Editor44');
INSERT INTO "Employees" ("employee_id", "role_code", "employee_name", "gender_mfu", "date_of_birth", "other_details") VALUES (28, NULL, 'Editor45', 'Editor45', 45, 'Editor45');
INSERT INTO "Document_Locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (26, 'Editor25', 22, 22);
INSERT INTO "Documents_to_be_Destroyed" ("document_id", "actual_destruction_date", "planned_destruction_date", "destruction_authorised_by_employee_id", "destroyed_by_employee_id", "other_details") VALUES (26, 22, 22, 28, 28, 'Editor45');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "employee_name" FROM (SELECT "LHS"."role_code" AS "role_code", "LHS"."role_name" AS "role_name", "LHS"."role_description" AS "role_description", "RHS"."employee_id" AS "employee_id", "RHS"."employee_name" AS "employee_name", "RHS"."gender_mfu" AS "gender_mfu", "RHS"."date_of_birth" AS "date_of_birth", "RHS"."other_details" AS "other_details" FROM "roles" AS "LHS" LEFT JOIN "employees" AS "RHS" ON ("LHS"."role_code" = "RHS"."role_code")) WHERE ("role_name" = 'Editor') ORDER BY employee_name, "employee_name" NULLS LAST;

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT T1.employee_name FROM Employees AS T1 JOIN ROLES AS T2 ON T1.role_code = T2.role_code WHERE T2.role_name = 'Editor';

/*
Prediction Result:
(None,)
*/