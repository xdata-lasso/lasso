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
-- 1. ORDER BY Calendar_Date vs no ORDER BY (inserted out of chronological order)
-- 2. ORDER BY Calendar_Date vs ORDER BY Day_Number (Day_Number goes inversely to Calendar_Date)
-- 3. Unreferenced Calendar_Date rows (catches mutants with accidental INNER JOINs to child tables)
-- 4. Duplicate references to the same Calendar_Date in child tables (catches mutants with JOINs lacking DISTINCT)
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('DOC_A', 'Report', 'Annual Report');
INSERT INTO "Ref_Locations" ("Location_Code", "Location_Name", "Location_Description") VALUES ('LOC_1', 'Archive', 'Main Archive');
INSERT INTO "Roles" ("Role_Code", "Role_Name", "Role_Description") VALUES ('MGR', 'Manager', 'Dept Manager');
INSERT INTO "Employees" ("Employee_ID", "Role_Code", "Employee_Name", "Gender_MFU", "Date_of_Birth", "Other_Details") VALUES (1, 'MGR', 'Alice', 'F', '1980-01-01 00:00:00', 'None');
INSERT INTO "Ref_Calendar" ("Calendar_Date", "Day_Number") VALUES ('2023-05-15 00:00:00', 10);
INSERT INTO "Ref_Calendar" ("Calendar_Date", "Day_Number") VALUES ('2021-01-01 00:00:00', 30);
INSERT INTO "Ref_Calendar" ("Calendar_Date", "Day_Number") VALUES ('2022-08-20 00:00:00', 20);
INSERT INTO "All_Documents" ("Document_ID", "Date_Stored", "Document_Type_Code", "Document_Name", "Document_Description", "Other_Details") VALUES (101, '2021-01-01 00:00:00', 'DOC_A', 'Doc 1', 'First', 'None');
INSERT INTO "All_Documents" ("Document_ID", "Date_Stored", "Document_Type_Code", "Document_Name", "Document_Description", "Other_Details") VALUES (102, '2021-01-01 00:00:00', 'DOC_A', 'Doc 2', 'Second', 'None');
INSERT INTO "Document_Locations" ("Document_ID", "Location_Code", "Date_in_Location_From", "Date_in_Locaton_To") VALUES (101, 'LOC_1', '2021-01-01 00:00:00', '2022-08-20 00:00:00');
INSERT INTO "Documents_to_be_Destroyed" ("Document_ID", "Actual_Destruction_Date", "Planned_Destruction_Date", "Destruction_Authorised_by_Employee_ID", "Destroyed_by_Employee_ID", "Other_Details") VALUES (101, '2022-08-20 00:00:00', '2021-01-01 00:00:00', 1, 1, 'Destroyed');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT calendar_date, day_number FROM ref_calendar ORDER BY calendar_date;

/*
Gold Result:
('2021-01-01 00:00:00', 30)
('2022-08-20 00:00:00', 20)
('2023-05-15 00:00:00', 10)
*/

-- Prediction Query
SELECT calendar_date, day_Number FROM Ref_calendar;

/*
Prediction Result:
('2023-05-15 00:00:00', 10)
('2021-01-01 00:00:00', 30)
('2022-08-20 00:00:00', 20)
*/