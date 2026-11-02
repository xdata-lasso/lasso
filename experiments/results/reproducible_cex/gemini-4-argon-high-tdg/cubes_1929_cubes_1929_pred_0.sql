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
INSERT INTO Roles (Role_Code, Role_Name, Role_Description) VALUES ('R_C', 'Name_B', 'Desc_D');
INSERT INTO Roles (Role_Code, Role_Name, Role_Description) VALUES ('R_A', 'Name_D', 'Desc_B');
INSERT INTO Roles (Role_Code, Role_Name, Role_Description) VALUES ('R_D', 'Name_A', 'Desc_C');
INSERT INTO Roles (Role_Code, Role_Name, Role_Description) VALUES ('R_B', 'Name_C', 'Desc_A');
INSERT INTO Employees (Employee_ID, Role_Code, Employee_Name, Gender_MFU, Date_of_Birth, Other_Details) VALUES (1, 'R_A', 'Alice Smith', 'F', '1985-04-12', 'Full-time');
INSERT INTO Employees (Employee_ID, Role_Code, Employee_Name, Gender_MFU, Date_of_Birth, Other_Details) VALUES (2, 'R_A', 'Bob Jones', 'M', '1990-08-23', 'Part-time');
INSERT INTO Employees (Employee_ID, Role_Code, Employee_Name, Gender_MFU, Date_of_Birth, Other_Details) VALUES (3, 'R_B', 'Charlie Brown', 'M', '1978-11-05', 'Contractor');
INSERT INTO Employees (Employee_ID, Role_Code, Employee_Name, Gender_MFU, Date_of_Birth, Other_Details) VALUES (4, NULL, 'Unassigned Emp', 'U', '1995-01-15', 'Pending role');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT role_code, role_name, role_description FROM roles ORDER BY role_code;

/*
Gold Result:
('R_A', 'Name_D', 'Desc_B')
('R_B', 'Name_C', 'Desc_A')
('R_C', 'Name_B', 'Desc_D')
('R_D', 'Name_A', 'Desc_C')
*/

-- Prediction Query
SELECT role_code, role_name, role_description FROM ROLES;

/*
Prediction Result:
('R_C', 'Name_B', 'Desc_D')
('R_A', 'Name_D', 'Desc_B')
('R_D', 'Name_A', 'Desc_C')
('R_B', 'Name_C', 'Desc_A')
*/