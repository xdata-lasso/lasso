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
-- DATASET 1
-- Tests basic filtering, duplicate elimination (SELECT DISTINCT vs SELECT),
-- ordering direction (ASC vs DESC), and unrelated roles (including NULLs and case variations).
INSERT INTO "Roles" ("Role_Code", "Role_Name", "Role_Description") VALUES ('PR1', 'Proof Reader', 'Z_Checks grammar');
INSERT INTO "Roles" ("Role_Code", "Role_Name", "Role_Description") VALUES ('PR2', 'Proof Reader', 'A_Checks spelling');
INSERT INTO "Roles" ("Role_Code", "Role_Name", "Role_Description") VALUES ('PR3', 'Proof Reader', 'A_Checks spelling');
INSERT INTO "Roles" ("Role_Code", "Role_Name", "Role_Description") VALUES ('ED1', 'Editor', 'Edits content');
INSERT INTO "Roles" ("Role_Code", "Role_Name", "Role_Description") VALUES ('PR_LOWER', 'proof reader', 'Lowercase role name');
INSERT INTO "Roles" ("Role_Code", "Role_Name", "Role_Description") VALUES ('PR_SUB', 'Senior Proof Reader', 'Substring match role name');
INSERT INTO "Roles" ("Role_Code", "Role_Name", "Role_Description") VALUES ('NULL_NAME', NULL, 'Null role name');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "role_description" FROM "roles" WHERE ("role_name" = 'Proof Reader') ORDER BY role_description, roles.role_code NULLS LAST;

/*
Gold Result:
('A_Checks spelling',)
('A_Checks spelling',)
('Z_Checks grammar',)
*/

-- Prediction Query
SELECT role_description FROM ROLES WHERE role_name = 'Proof Reader';

/*
Prediction Result:
('Z_Checks grammar',)
('A_Checks spelling',)
('A_Checks spelling',)
*/