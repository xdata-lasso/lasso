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
INSERT INTO "Ref_Document_Types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('Robin CV41', 'Robin CV46', 'Robin CV46');
INSERT INTO "Ref_Document_Types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('Robin CV47', 'Robin CV46', 'Robin CV46');
INSERT INTO "Ref_Calendar" ("calendar_date", "day_number") VALUES (51, 46);
INSERT INTO "Ref_Calendar" ("calendar_date", "day_number") VALUES (46, 46);
INSERT INTO "Ref_Locations" ("location_code", "location_name", "location_description") VALUES ('Robin CV27', NULL, 'Robin CV37');
INSERT INTO "Ref_Locations" ("location_code", "location_name", "location_description") VALUES ('Robin CV26', NULL, 'Robin CV39');
INSERT INTO "Roles" ("role_code", "role_name", "role_description") VALUES ('Robin CV29', 'Robin CV46', 'Robin CV46');
INSERT INTO "Roles" ("role_code", "role_name", "role_description") VALUES ('Robin CV28', 'Robin CV46', 'Robin CV46');
INSERT INTO "All_Documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (50, 46, 'Robin CV47', 'Robin CV', 'Robin CV48', 'Robin CV49');
INSERT INTO "All_Documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (40, 51, 'Robin CV41', 'Robin CV', 'Robin CV42', NULL);
INSERT INTO "Employees" ("employee_id", "role_code", "employee_name", "gender_mfu", "date_of_birth", "other_details") VALUES (30, NULL, 'Robin CV46', 'Robin CV46', 46, 'Robin CV46');
INSERT INTO "Document_Locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (50, 'Robin CV27', 46, 46);
INSERT INTO "Document_Locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (50, 'Robin CV26', 51, 51);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "location_name" FROM (SELECT "LHS"."location_code" AS "location_code", "LHS"."location_name" AS "location_name", "LHS"."location_description" AS "location_description", "LHS"."document_id" AS "document_id", "LHS"."date_stored" AS "date_stored", "LHS"."document_type_code" AS "document_type_code", "LHS"."document_name" AS "document_name", "LHS"."document_description" AS "document_description", "LHS"."other_details" AS "other_details", "RHS"."date_in_location_from" AS "date_in_location_from", "RHS"."date_in_locaton_to" AS "date_in_locaton_to" FROM (SELECT "LHS"."location_code" AS "location_code", "LHS"."location_name" AS "location_name", "LHS"."location_description" AS "location_description", "RHS"."document_id" AS "document_id", "RHS"."date_stored" AS "date_stored", "RHS"."document_type_code" AS "document_type_code", "RHS"."document_name" AS "document_name", "RHS"."document_description" AS "document_description", "RHS"."other_details" AS "other_details" FROM "ref_locations" AS "LHS" CROSS JOIN "all_documents" AS "RHS") AS "LHS" INNER JOIN "document_locations" AS "RHS" ON ("LHS"."location_code" = "RHS"."location_code" AND "LHS"."document_id" = "RHS"."document_id")) WHERE ("document_name" = 'Robin CV') ORDER BY location_name, "location_name" NULLS LAST;

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT T3.location_name FROM All_documents AS T1 JOIN Document_locations AS T2 ON T1.document_id = T2.document_id JOIN Ref_locations AS T3 ON T2.location_code = T3.location_code WHERE T1.document_name = 'Robin CV';

/*
Prediction Result:
(None,)
(None,)
*/