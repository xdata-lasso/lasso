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
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('DT1', 'Contract', 'Legal Contract');
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('DT2', 'Invoice', 'Billing Invoice');
INSERT INTO Ref_Calendar (Calendar_Date, Day_Number) VALUES ('2023-01-01', 1);
INSERT INTO Ref_Calendar (Calendar_Date, Day_Number) VALUES ('2023-01-02', 2);
INSERT INTO Ref_Calendar (Calendar_Date, Day_Number) VALUES ('2023-01-03', 3);
INSERT INTO Ref_Calendar (Calendar_Date, Day_Number) VALUES ('2023-01-04', 4);
INSERT INTO Ref_Calendar (Calendar_Date, Day_Number) VALUES ('2023-01-05', 5);
INSERT INTO Ref_Calendar (Calendar_Date, Day_Number) VALUES ('2023-01-06', 6);
INSERT INTO Ref_Locations (Location_Code, Location_Name, Location_Description) VALUES ('LOC_A', 'Alpha Room', 'First Floor');
INSERT INTO Ref_Locations (Location_Code, Location_Name, Location_Description) VALUES ('LOC_B', 'Beta Room', 'Second Floor');
INSERT INTO Ref_Locations (Location_Code, Location_Name, Location_Description) VALUES ('LOC_C', 'Gamma Room', 'Third Floor');
INSERT INTO Ref_Locations (Location_Code, Location_Name, Location_Description) VALUES ('LOC_Z', 'Unused Vault', 'Basement');
INSERT INTO Roles (Role_Code, Role_Name, Role_Description) VALUES ('MGR', 'Manager', 'Department Manager');
INSERT INTO Employees (Employee_ID, Role_Code, Employee_Name, Gender_MFU, Date_of_Birth, Other_Details) VALUES (1, 'MGR', 'Alice Smith', 'F', '1980-05-15', 'Senior');
INSERT INTO All_Documents (Document_ID, Date_Stored, Document_Type_Code, Document_Name, Document_Description, Other_Details) VALUES (10, '2023-01-01', 'DT1', 'Doc 10', 'First Doc', 'None');
INSERT INTO All_Documents (Document_ID, Date_Stored, Document_Type_Code, Document_Name, Document_Description, Other_Details) VALUES (20, '2023-01-02', 'DT2', 'Doc 20', 'Second Doc', 'None');
INSERT INTO All_Documents (Document_ID, Date_Stored, Document_Type_Code, Document_Name, Document_Description, Other_Details) VALUES (30, '2023-01-03', 'DT1', 'Doc 30', 'Third Doc', 'None');
INSERT INTO All_Documents (Document_ID, Date_Stored, Document_Type_Code, Document_Name, Document_Description, Other_Details) VALUES (40, '2023-01-04', 'DT2', 'Doc 40', 'Fourth Doc', 'None');
INSERT INTO Document_Locations (Document_ID, Location_Code, Date_in_Location_From, Date_in_Locaton_To) VALUES (40, 'LOC_B', '2023-01-05', '2023-01-06');
INSERT INTO Document_Locations (Document_ID, Location_Code, Date_in_Location_From, Date_in_Locaton_To) VALUES (10, 'LOC_A', '2023-01-01', '2023-01-02');
INSERT INTO Document_Locations (Document_ID, Location_Code, Date_in_Location_From, Date_in_Locaton_To) VALUES (20, 'LOC_C', '2023-01-02', '2023-01-03');
INSERT INTO Document_Locations (Document_ID, Location_Code, Date_in_Location_From, Date_in_Locaton_To) VALUES (30, 'LOC_C', '2023-01-03', '2023-01-04');
INSERT INTO Document_Locations (Document_ID, Location_Code, Date_in_Location_From, Date_in_Locaton_To) VALUES (10, 'LOC_B', '2023-01-03', '2023-01-05');
INSERT INTO Document_Locations (Document_ID, Location_Code, Date_in_Location_From, Date_in_Locaton_To) VALUES (20, 'LOC_B', '2023-01-04', '2023-01-06');
INSERT INTO Documents_to_be_Destroyed (Document_ID, Actual_Destruction_Date, Planned_Destruction_Date, Destruction_Authorised_by_Employee_ID, Destroyed_by_Employee_ID, Other_Details) VALUES (10, '2023-01-06', '2023-01-06', 1, 1, 'Destroyed');
INSERT INTO Documents_to_be_Destroyed (Document_ID, Actual_Destruction_Date, Planned_Destruction_Date, Destruction_Authorised_by_Employee_ID, Destroyed_by_Employee_ID, Other_Details) VALUES (40, '2023-01-06', '2023-01-06', 1, 1, 'Destroyed');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT location_code FROM (SELECT * FROM (SELECT * FROM (SELECT document_id, location_code, date_in_location_from, date_in_locaton_to, COUNT(*) OVER () AS n FROM document_locations) ORDER BY location_code DESC) LIMIT 1);

/*
Gold Result:
('LOC_C',)
*/

-- Prediction Query
SELECT location_code FROM Document_locations GROUP BY location_code ORDER BY COUNT(*) DESC, location_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('LOC_B',)
*/