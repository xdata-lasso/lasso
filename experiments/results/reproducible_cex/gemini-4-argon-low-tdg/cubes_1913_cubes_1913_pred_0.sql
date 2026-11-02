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
-- Tests standard composite GROUP BY (Employee_ID + Other_Details), duplicate counts, and ordering by Employee_ID and count___.
-- Also distinguishes Destruction_Authorised_by_Employee_ID from Destroyed_by_Employee_ID.
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('DOC1', 'Type 1', 'Desc 1');
INSERT INTO Ref_Calendar (Calendar_Date, Day_Number) VALUES ('2023-01-01', 1);
INSERT INTO Roles (Role_Code, Role_Name, Role_Description) VALUES ('R1', 'Manager', 'Role 1');
INSERT INTO Employees (Employee_ID, Role_Code, Employee_Name, Gender_MFU, Date_of_Birth, Other_Details) VALUES (10, 'R1', 'Alice', 'F', '1980-01-01', 'Emp1');
INSERT INTO Employees (Employee_ID, Role_Code, Employee_Name, Gender_MFU, Date_of_Birth, Other_Details) VALUES (20, 'R1', 'Bob', 'M', '1985-01-01', 'Emp2');
INSERT INTO Employees (Employee_ID, Role_Code, Employee_Name, Gender_MFU, Date_of_Birth, Other_Details) VALUES (99, 'R1', 'Charlie', 'M', '1990-01-01', 'Unused Emp');
INSERT INTO All_Documents (Document_ID, Date_Stored, Document_Type_Code, Document_Name, Document_Description, Other_Details) VALUES (1, '2023-01-01', 'DOC1', 'D1', 'Desc', 'DocDetail1');
INSERT INTO All_Documents (Document_ID, Date_Stored, Document_Type_Code, Document_Name, Document_Description, Other_Details) VALUES (2, '2023-01-01', 'DOC1', 'D2', 'Desc', 'DocDetail2');
INSERT INTO All_Documents (Document_ID, Date_Stored, Document_Type_Code, Document_Name, Document_Description, Other_Details) VALUES (3, '2023-01-01', 'DOC1', 'D3', 'Desc', 'DocDetail3');
INSERT INTO All_Documents (Document_ID, Date_Stored, Document_Type_Code, Document_Name, Document_Description, Other_Details) VALUES (4, '2023-01-01', 'DOC1', 'D4', 'Desc', 'DocDetail4');
INSERT INTO All_Documents (Document_ID, Date_Stored, Document_Type_Code, Document_Name, Document_Description, Other_Details) VALUES (5, '2023-01-01', 'DOC1', 'D5', 'Desc', 'DocDetail5');
INSERT INTO All_Documents (Document_ID, Date_Stored, Document_Type_Code, Document_Name, Document_Description, Other_Details) VALUES (6, '2023-01-01', 'DOC1', 'D6', 'Desc', 'DocDetail6');
INSERT INTO All_Documents (Document_ID, Date_Stored, Document_Type_Code, Document_Name, Document_Description, Other_Details) VALUES (7, '2023-01-01', 'DOC1', 'D7', 'Desc', 'DocDetail7');
-- Employee 20 has two groups of Other_Details: 'Detail_B' (count 2) and 'Detail_A' (count 1) -> tests secondary sort on count___
INSERT INTO Documents_to_be_Destroyed (Document_ID, Actual_Destruction_Date, Planned_Destruction_Date, Destruction_Authorised_by_Employee_ID, Destroyed_by_Employee_ID, Other_Details) VALUES (1, '2023-01-01', '2023-01-01', 20, 10, 'Detail_B');
INSERT INTO Documents_to_be_Destroyed (Document_ID, Actual_Destruction_Date, Planned_Destruction_Date, Destruction_Authorised_by_Employee_ID, Destroyed_by_Employee_ID, Other_Details) VALUES (2, '2023-01-01', '2023-01-01', 20, 10, 'Detail_B');
INSERT INTO Documents_to_be_Destroyed (Document_ID, Actual_Destruction_Date, Planned_Destruction_Date, Destruction_Authorised_by_Employee_ID, Destroyed_by_Employee_ID, Other_Details) VALUES (3, '2023-01-01', '2023-01-01', 20, 20, 'Detail_A');
-- Employee 10 has two groups of Other_Details, both with count 1 -> tests SELECT DISTINCT mutations
INSERT INTO Documents_to_be_Destroyed (Document_ID, Actual_Destruction_Date, Planned_Destruction_Date, Destruction_Authorised_by_Employee_ID, Destroyed_by_Employee_ID, Other_Details) VALUES (4, '2023-01-01', '2023-01-01', 10, 20, 'Detail_X');
INSERT INTO Documents_to_be_Destroyed (Document_ID, Actual_Destruction_Date, Planned_Destruction_Date, Destruction_Authorised_by_Employee_ID, Destroyed_by_Employee_ID, Other_Details) VALUES (5, '2023-01-01', '2023-01-01', 10, 20, 'Detail_Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT destruction_authorised_by_employee_id, n AS count___ FROM (SELECT destruction_authorised_by_employee_id, other_details, COUNT(*) AS n FROM documents_to_be_destroyed GROUP BY destruction_authorised_by_employee_id, other_details) ORDER BY destruction_authorised_by_employee_id, count___ NULLS LAST;

/*
Gold Result:
(10, 1)
(10, 1)
(20, 1)
(20, 2)
*/

-- Prediction Query
SELECT Destruction_Authorised_by_Employee_ID, COUNT(*) FROM Documents_to_be_destroyed GROUP BY Destruction_Authorised_by_Employee_ID;

/*
Prediction Result:
(10, 2)
(20, 3)
*/