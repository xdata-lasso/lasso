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
INSERT INTO Roles (Role_Code, Role_Name, Role_Description) VALUES ('R1', 'Manager', 'Management role');
INSERT INTO Roles (Role_Code, Role_Name, Role_Description) VALUES ('R2', 'Analyst', 'Analysis role');
INSERT INTO Roles (Role_Code, Role_Name, Role_Description) VALUES ('R3', 'Clerk', 'Clerical role');
INSERT INTO Roles (Role_Code, Role_Name, Role_Description) VALUES ('R4', 'Auditor', 'Auditing role');
INSERT INTO Roles (Role_Code, Role_Name, Role_Description) VALUES ('R5', 'Director', 'Executive role');
INSERT INTO Employees (Employee_ID, Role_Code, Employee_Name, Gender_MFU, Date_of_Birth, Other_Details) VALUES (1, 'R1', 'Alice', 'F', '1980-01-01', 'D1');
INSERT INTO Employees (Employee_ID, Role_Code, Employee_Name, Gender_MFU, Date_of_Birth, Other_Details) VALUES (2, 'R1', 'Bob', 'M', '1981-02-02', 'D1');
INSERT INTO Employees (Employee_ID, Role_Code, Employee_Name, Gender_MFU, Date_of_Birth, Other_Details) VALUES (3, 'R1', 'Charlie', 'U', '1982-03-03', 'D1');
INSERT INTO Employees (Employee_ID, Role_Code, Employee_Name, Gender_MFU, Date_of_Birth, Other_Details) VALUES (4, 'R1', 'Diana', 'F', '1983-04-04', 'D1');
INSERT INTO Employees (Employee_ID, Role_Code, Employee_Name, Gender_MFU, Date_of_Birth, Other_Details) VALUES (5, 'R2', 'Evan', 'M', '1984-05-05', 'D2');
INSERT INTO Employees (Employee_ID, Role_Code, Employee_Name, Gender_MFU, Date_of_Birth, Other_Details) VALUES (6, 'R2', 'Fiona', 'F', '1985-06-06', 'D2');
INSERT INTO Employees (Employee_ID, Role_Code, Employee_Name, Gender_MFU, Date_of_Birth, Other_Details) VALUES (7, 'R2', 'George', 'M', '1986-07-07', 'D2');
INSERT INTO Employees (Employee_ID, Role_Code, Employee_Name, Gender_MFU, Date_of_Birth, Other_Details) VALUES (8, 'R2', 'Hannah', 'F', '1987-08-08', 'D5');
INSERT INTO Employees (Employee_ID, Role_Code, Employee_Name, Gender_MFU, Date_of_Birth, Other_Details) VALUES (9, 'R3', 'Ian', 'M', '1988-09-09', 'D3');
INSERT INTO Employees (Employee_ID, Role_Code, Employee_Name, Gender_MFU, Date_of_Birth, Other_Details) VALUES (10, 'R3', 'Julia', 'F', '1989-10-10', 'D3');
INSERT INTO Employees (Employee_ID, Role_Code, Employee_Name, Gender_MFU, Date_of_Birth, Other_Details) VALUES (11, 'R3', 'Kevin', 'M', '1990-11-11', 'D3');
INSERT INTO Employees (Employee_ID, Role_Code, Employee_Name, Gender_MFU, Date_of_Birth, Other_Details) VALUES (12, 'R3', 'Laura', 'F', '1991-12-12', 'D3');
INSERT INTO Employees (Employee_ID, Role_Code, Employee_Name, Gender_MFU, Date_of_Birth, Other_Details) VALUES (13, 'R3', 'Mike', 'M', '1992-01-13', 'D3');
INSERT INTO Employees (Employee_ID, Role_Code, Employee_Name, Gender_MFU, Date_of_Birth, Other_Details) VALUES (14, 'R4', 'Nina', 'F', '1993-02-14', 'D4_A');
INSERT INTO Employees (Employee_ID, Role_Code, Employee_Name, Gender_MFU, Date_of_Birth, Other_Details) VALUES (15, 'R4', 'Oscar', 'M', '1994-03-15', 'D4_A');
INSERT INTO Employees (Employee_ID, Role_Code, Employee_Name, Gender_MFU, Date_of_Birth, Other_Details) VALUES (16, 'R4', 'Paula', 'F', '1995-04-16', 'D4_B');
INSERT INTO Employees (Employee_ID, Role_Code, Employee_Name, Gender_MFU, Date_of_Birth, Other_Details) VALUES (17, 'R4', 'Quinn', 'U', '1996-05-17', 'D4_B');
INSERT INTO Employees (Employee_ID, Role_Code, Employee_Name, Gender_MFU, Date_of_Birth, Other_Details) VALUES (18, 'R5', 'Rachel', 'F', '1997-06-18', 'D5');
INSERT INTO Employees (Employee_ID, Role_Code, Employee_Name, Gender_MFU, Date_of_Birth, Other_Details) VALUES (19, 'R5', 'Steve', 'M', '1998-07-19', 'D5');
INSERT INTO Employees (Employee_ID, Role_Code, Employee_Name, Gender_MFU, Date_of_Birth, Other_Details) VALUES (20, 'R5', 'Tina', 'F', '1999-08-20', 'D5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT role_code FROM (SELECT other_details, role_code, COUNT(*) AS n FROM employees GROUP BY other_details, role_code) WHERE (n > 3) ORDER BY role_code;

/*
Gold Result:
('R1',)
('R3',)
*/

-- Prediction Query
SELECT role_code FROM Employees GROUP BY role_code HAVING COUNT(*) >= 3;

/*
Prediction Result:
('R1',)
('R2',)
('R3',)
('R4',)
('R5',)
*/