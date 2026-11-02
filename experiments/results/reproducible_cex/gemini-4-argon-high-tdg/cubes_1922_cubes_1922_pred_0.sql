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
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('DOC_A', 'Report', 'Annual Report');
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('DOC_B', 'Memo', 'Internal Memo');
INSERT INTO Ref_Calendar (Calendar_Date, Day_Number) VALUES ('2023-01-01', 1);
INSERT INTO Ref_Calendar (Calendar_Date, Day_Number) VALUES ('2023-02-01', 32);
INSERT INTO Ref_Calendar (Calendar_Date, Day_Number) VALUES ('2023-03-01', 60);
INSERT INTO Ref_Calendar (Calendar_Date, Day_Number) VALUES ('2023-04-01', 91);
INSERT INTO Ref_Locations (Location_Code, Location_Name, Location_Description) VALUES ('LOC1', 'Archive', 'Main Archive');
INSERT INTO Ref_Locations (Location_Code, Location_Name, Location_Description) VALUES ('LOC2', 'Vault', 'Secure Vault');
INSERT INTO Roles (Role_Code, Role_Name, Role_Description) VALUES ('MGR', 'Manager', 'Department Manager');
INSERT INTO Roles (Role_Code, Role_Name, Role_Description) VALUES ('CLK', 'Clerk', 'Filing Clerk');
INSERT INTO Employees (Employee_ID, Role_Code, Employee_Name, Gender_MFU, Date_of_Birth, Other_Details) VALUES (10, 'CLK', 'Alice', 'F', '1990-05-10', 'Staff');
INSERT INTO Employees (Employee_ID, Role_Code, Employee_Name, Gender_MFU, Date_of_Birth, Other_Details) VALUES (20, 'CLK', 'Bob', 'M', '1985-08-20', 'Staff');
INSERT INTO Employees (Employee_ID, Role_Code, Employee_Name, Gender_MFU, Date_of_Birth, Other_Details) VALUES (30, 'MGR', 'Charlie', 'M', '1978-11-15', 'Supervisor');
INSERT INTO Employees (Employee_ID, Role_Code, Employee_Name, Gender_MFU, Date_of_Birth, Other_Details) VALUES (40, 'MGR', 'Diana', 'F', '1982-03-25', 'Authoriser Only');
INSERT INTO All_Documents (Document_ID, Date_Stored, Document_Type_Code, Document_Name, Document_Description, Other_Details) VALUES (1, '2023-01-01', 'DOC_A', 'Doc 1', 'First Doc', 'None');
INSERT INTO All_Documents (Document_ID, Date_Stored, Document_Type_Code, Document_Name, Document_Description, Other_Details) VALUES (2, '2023-01-01', 'DOC_B', 'Doc 2', 'Second Doc', 'None');
INSERT INTO All_Documents (Document_ID, Date_Stored, Document_Type_Code, Document_Name, Document_Description, Other_Details) VALUES (3, '2023-02-01', 'DOC_A', 'Doc 3', 'Third Doc', 'None');
INSERT INTO All_Documents (Document_ID, Date_Stored, Document_Type_Code, Document_Name, Document_Description, Other_Details) VALUES (4, '2023-02-01', 'DOC_B', 'Doc 4', 'Fourth Doc', 'None');
INSERT INTO All_Documents (Document_ID, Date_Stored, Document_Type_Code, Document_Name, Document_Description, Other_Details) VALUES (5, '2023-03-01', 'DOC_A', 'Doc 5', 'Kept Doc', 'Not Destroyed');
INSERT INTO Document_Locations (Document_ID, Location_Code, Date_in_Location_From, Date_in_Locaton_To) VALUES (1, 'LOC1', '2023-01-01', '2023-02-01');
INSERT INTO Document_Locations (Document_ID, Location_Code, Date_in_Location_From, Date_in_Locaton_To) VALUES (1, 'LOC2', '2023-02-01', '2023-03-01');
INSERT INTO Document_Locations (Document_ID, Location_Code, Date_in_Location_From, Date_in_Locaton_To) VALUES (5, 'LOC1', '2023-03-01', '2023-04-01');
INSERT INTO Documents_to_be_Destroyed (Document_ID, Actual_Destruction_Date, Planned_Destruction_Date, Destruction_Authorised_by_Employee_ID, Destroyed_by_Employee_ID, Other_Details) VALUES (1, '2023-04-01', '2023-03-01', 40, 30, 'Batch 1');
INSERT INTO Documents_to_be_Destroyed (Document_ID, Actual_Destruction_Date, Planned_Destruction_Date, Destruction_Authorised_by_Employee_ID, Destroyed_by_Employee_ID, Other_Details) VALUES (2, '2023-03-01', '2023-03-01', 10, 10, 'Self Auth');
INSERT INTO Documents_to_be_Destroyed (Document_ID, Actual_Destruction_Date, Planned_Destruction_Date, Destruction_Authorised_by_Employee_ID, Destroyed_by_Employee_ID, Other_Details) VALUES (3, '2023-02-01', '2023-04-01', 40, 20, 'Early');
INSERT INTO Documents_to_be_Destroyed (Document_ID, Actual_Destruction_Date, Planned_Destruction_Date, Destruction_Authorised_by_Employee_ID, Destroyed_by_Employee_ID, Other_Details) VALUES (4, '2023-04-01', '2023-04-01', 20, 30, 'Batch 2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT destroyed_by_employee_id FROM documents_to_be_destroyed ORDER BY destroyed_by_employee_id;

/*
Gold Result:
(10,)
(20,)
(30,)
*/

-- Prediction Query
SELECT DISTINCT Destroyed_by_Employee_ID FROM Documents_to_be_destroyed;

/*
Prediction Result:
(30,)
(10,)
(20,)
*/