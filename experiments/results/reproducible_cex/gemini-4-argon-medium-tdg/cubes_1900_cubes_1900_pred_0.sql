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
-- Tests:
-- 1. Boundary conditions for n > 3 (groups of size 3, 4, and 5).
-- 2. Grouping by both (other_details, role_code) vs grouping by only role_code or only other_details.
-- 3. Duplicate role_code outputs (same role_code having multiple other_details groups > 3) to catch DISTINCT mutants.
-- 4. Unreferenced Roles (to catch INNER JOIN vs FROM Roles mutants) and ordering (ASC vs DESC vs insertion order).
INSERT INTO "Roles" ("Role_Code", "Role_Name", "Role_Description") VALUES ('R_ZEBRA', 'Zebra Role', 'Desc Z');
INSERT INTO "Roles" ("Role_Code", "Role_Name", "Role_Description") VALUES ('R_ALPHA', 'Alpha Role', 'Desc A');
INSERT INTO "Roles" ("Role_Code", "Role_Name", "Role_Description") VALUES ('R_BETA', 'Beta Role', 'Desc B');
INSERT INTO "Roles" ("Role_Code", "Role_Name", "Role_Description") VALUES ('R_GAMMA', 'Gamma Role', 'Desc G');
INSERT INTO "Roles" ("Role_Code", "Role_Name", "Role_Description") VALUES ('R_UNUSED', 'Unused Role', 'No employees');
-- R_ZEBRA with 'Det1': count = 4 (Should be included)
INSERT INTO "Employees" ("Employee_ID", "Role_Code", "Employee_Name", "Gender_MFU", "Date_of_Birth", "Other_Details") VALUES (1, 'R_ZEBRA', 'E1', 'M', '1990-01-01', 'Det1');
INSERT INTO "Employees" ("Employee_ID", "Role_Code", "Employee_Name", "Gender_MFU", "Date_of_Birth", "Other_Details") VALUES (2, 'R_ZEBRA', 'E2', 'F', '1990-01-02', 'Det1');
INSERT INTO "Employees" ("Employee_ID", "Role_Code", "Employee_Name", "Gender_MFU", "Date_of_Birth", "Other_Details") VALUES (3, 'R_ZEBRA', 'E3', 'M', '1990-01-03', 'Det1');
INSERT INTO "Employees" ("Employee_ID", "Role_Code", "Employee_Name", "Gender_MFU", "Date_of_Birth", "Other_Details") VALUES (4, 'R_ZEBRA', 'E4', 'F', '1990-01-04', 'Det1');
-- R_ALPHA with 'Det2': count = 4 (Should be included)
INSERT INTO "Employees" ("Employee_ID", "Role_Code", "Employee_Name", "Gender_MFU", "Date_of_Birth", "Other_Details") VALUES (5, 'R_ALPHA', 'E5', 'M', '1990-01-05', 'Det2');
INSERT INTO "Employees" ("Employee_ID", "Role_Code", "Employee_Name", "Gender_MFU", "Date_of_Birth", "Other_Details") VALUES (6, 'R_ALPHA', 'E6', 'F', '1990-01-06', 'Det2');
INSERT INTO "Employees" ("Employee_ID", "Role_Code", "Employee_Name", "Gender_MFU", "Date_of_Birth", "Other_Details") VALUES (7, 'R_ALPHA', 'E7', 'M', '1990-01-07', 'Det2');
INSERT INTO "Employees" ("Employee_ID", "Role_Code", "Employee_Name", "Gender_MFU", "Date_of_Birth", "Other_Details") VALUES (8, 'R_ALPHA', 'E8', 'F', '1990-01-08', 'Det2');
-- R_ALPHA with 'Det3': count = 5 (Should be included; produces second 'R_ALPHA' row to kill SELECT DISTINCT)
INSERT INTO "Employees" ("Employee_ID", "Role_Code", "Employee_Name", "Gender_MFU", "Date_of_Birth", "Other_Details") VALUES (9, 'R_ALPHA', 'E9', 'M', '1990-01-09', 'Det3');
INSERT INTO "Employees" ("Employee_ID", "Role_Code", "Employee_Name", "Gender_MFU", "Date_of_Birth", "Other_Details") VALUES (10, 'R_ALPHA', 'E10', 'F', '1990-01-10', 'Det3');
INSERT INTO "Employees" ("Employee_ID", "Role_Code", "Employee_Name", "Gender_MFU", "Date_of_Birth", "Other_Details") VALUES (11, 'R_ALPHA', 'E11', 'M', '1990-01-11', 'Det3');
INSERT INTO "Employees" ("Employee_ID", "Role_Code", "Employee_Name", "Gender_MFU", "Date_of_Birth", "Other_Details") VALUES (12, 'R_ALPHA', 'E12', 'F', '1990-01-12', 'Det3');
INSERT INTO "Employees" ("Employee_ID", "Role_Code", "Employee_Name", "Gender_MFU", "Date_of_Birth", "Other_Details") VALUES (13, 'R_ALPHA', 'E13', 'M', '1990-01-13', 'Det3');
-- R_BETA with 'Det4': count = 3 (Boundary condition n = 3; should NOT be included)
-- R_BETA with 'Det5': count = 2 (Together R_BETA has 5 rows, killing mutants that group ONLY by Role_Code)
INSERT INTO "Employees" ("Employee_ID", "Role_Code", "Employee_Name", "Gender_MFU", "Date_of_Birth", "Other_Details") VALUES (14, 'R_BETA', 'E14', 'F', '1990-01-14', 'Det4');
INSERT INTO "Employees" ("Employee_ID", "Role_Code", "Employee_Name", "Gender_MFU", "Date_of_Birth", "Other_Details") VALUES (15, 'R_BETA', 'E15', 'M', '1990-01-15', 'Det4');
INSERT INTO "Employees" ("Employee_ID", "Role_Code", "Employee_Name", "Gender_MFU", "Date_of_Birth", "Other_Details") VALUES (16, 'R_BETA', 'E16', 'F', '1990-01-16', 'Det4');
INSERT INTO "Employees" ("Employee_ID", "Role_Code", "Employee_Name", "Gender_MFU", "Date_of_Birth", "Other_Details") VALUES (17, 'R_BETA', 'E17', 'M', '1990-01-17', 'Det5');
INSERT INTO "Employees" ("Employee_ID", "Role_Code", "Employee_Name", "Gender_MFU", "Date_of_Birth", "Other_Details") VALUES (18, 'R_BETA', 'E18', 'F', '1990-01-18', 'Det5');
-- R_GAMMA with 'Det4': count = 2 (Together 'Det4' across R_BETA and R_GAMMA has 5 rows, killing mutants that group ONLY by Other_Details)
INSERT INTO "Employees" ("Employee_ID", "Role_Code", "Employee_Name", "Gender_MFU", "Date_of_Birth", "Other_Details") VALUES (19, 'R_GAMMA', 'E19', 'M', '1990-01-19', 'Det4');
INSERT INTO "Employees" ("Employee_ID", "Role_Code", "Employee_Name", "Gender_MFU", "Date_of_Birth", "Other_Details") VALUES (20, 'R_GAMMA', 'E20', 'F', '1990-01-20', 'Det4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT role_code FROM (SELECT other_details, role_code, COUNT(*) AS n FROM employees GROUP BY other_details, role_code) WHERE (n > 3) ORDER BY role_code;

/*
Gold Result:
('R_ALPHA',)
('R_ALPHA',)
('R_ZEBRA',)
*/

-- Prediction Query
SELECT role_code FROM Employees GROUP BY role_code HAVING COUNT(*) >= 3;

/*
Prediction Result:
('R_ALPHA',)
('R_BETA',)
('R_ZEBRA',)
*/