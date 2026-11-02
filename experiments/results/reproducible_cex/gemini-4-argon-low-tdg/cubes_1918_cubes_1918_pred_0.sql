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
-- Tests basic filtering (HR vs non-HR), duplicate employee names (to catch DISTINCT vs ALL), NULL employee names (to catch NULLS FIRST vs NULLS LAST), and ordering where Employee_ID ordering diverges from Employee_Name ordering.
INSERT INTO "Roles" ("Role_Code", "Role_Name", "Role_Description") VALUES ('HR', 'Human Resources', 'HR Department');
INSERT INTO "Roles" ("Role_Code", "Role_Name", "Role_Description") VALUES ('IT', 'Information Technology', 'IT Department');
INSERT INTO "Roles" ("Role_Code", "Role_Name", "Role_Description") VALUES ('FIN', 'HR', 'Finance Department with misleading Role_Name');
INSERT INTO "Employees" ("Employee_ID", "Role_Code", "Employee_Name", "Gender_MFU", "Date_of_Birth", "Other_Details") VALUES (1, 'HR', 'Zack', 'M', '1980-01-01', 'HR Manager');
INSERT INTO "Employees" ("Employee_ID", "Role_Code", "Employee_Name", "Gender_MFU", "Date_of_Birth", "Other_Details") VALUES (2, 'HR', 'Alice', 'F', '1990-05-12', 'HR Specialist');
INSERT INTO "Employees" ("Employee_ID", "Role_Code", "Employee_Name", "Gender_MFU", "Date_of_Birth", "Other_Details") VALUES (3, 'HR', 'Alice', 'M', '1985-07-23', 'HR Coordinator');
INSERT INTO "Employees" ("Employee_ID", "Role_Code", "Employee_Name", "Gender_MFU", "Date_of_Birth", "Other_Details") VALUES (4, 'HR', NULL, 'U', '1992-11-04', 'Unnamed HR');
INSERT INTO "Employees" ("Employee_ID", "Role_Code", "Employee_Name", "Gender_MFU", "Date_of_Birth", "Other_Details") VALUES (5, 'IT', 'Bob', 'M', '1988-03-15', 'HR');
INSERT INTO "Employees" ("Employee_ID", "Role_Code", "Employee_Name", "Gender_MFU", "Date_of_Birth", "Other_Details") VALUES (6, 'FIN', 'Charlie', 'F', '1979-09-09', 'Finance');
INSERT INTO "Employees" ("Employee_ID", "Role_Code", "Employee_Name", "Gender_MFU", "Date_of_Birth", "Other_Details") VALUES (7, NULL, 'David', 'M', '1995-12-12', 'Unassigned Role');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "employee_name" FROM "employees" WHERE ("role_code" = 'HR') ORDER BY employee_name, employees.employee_id NULLS LAST;

/*
Gold Result:
(None,)
('Alice',)
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT employee_name FROM Employees WHERE role_code = 'HR';

/*
Prediction Result:
('Zack',)
('Alice',)
('Alice',)
(None,)
*/