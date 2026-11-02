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
INSERT INTO Roles (Role_Code, Role_Name, Role_Description) VALUES ('R1', 'Admin', 'Admin Role');
INSERT INTO Employees (Employee_ID, Role_Code, Employee_Name, Gender_MFU, Date_of_Birth, Other_Details) VALUES (1, 'R1', 'Alice', 'F', '1980-01-01', NULL);
INSERT INTO Employees (Employee_ID, Role_Code, Employee_Name, Gender_MFU, Date_of_Birth, Other_Details) VALUES (2, 'R1', 'Bob', 'M', '1985-01-01', NULL);
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('DT1', 'Report', 'Report Type');
INSERT INTO Ref_Calendar (Calendar_Date, Day_Number) VALUES ('2020-01-01', 1);
INSERT INTO All_Documents (Document_ID, Date_Stored, Document_Type_Code, Document_Name, Document_Description, Other_Details) VALUES (1, '2020-01-01', 'DT1', 'Doc1', 'Desc1', NULL);
INSERT INTO All_Documents (Document_ID, Date_Stored, Document_Type_Code, Document_Name, Document_Description, Other_Details) VALUES (2, '2020-01-01', 'DT1', 'Doc2', 'Desc2', NULL);
INSERT INTO Documents_to_be_Destroyed (Document_ID, Actual_Destruction_Date, Planned_Destruction_Date, Destruction_Authorised_by_Employee_ID, Destroyed_by_Employee_ID, Other_Details) VALUES (1, '2020-01-01', '2020-01-01', 1, 2, NULL);
INSERT INTO Documents_to_be_Destroyed (Document_ID, Actual_Destruction_Date, Planned_Destruction_Date, Destruction_Authorised_by_Employee_ID, Destroyed_by_Employee_ID, Other_Details) VALUES (2, '2020-01-01', '2020-01-01', 1, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT destroyed_by_employee_id FROM documents_to_be_destroyed ORDER BY destroyed_by_employee_id;

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
SELECT DISTINCT Destroyed_by_Employee_ID FROM Documents_to_be_destroyed;

/*
Prediction Result:
(2,)
(1,)
*/