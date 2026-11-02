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
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('DT1', 'Report', 'Standard Report');
INSERT INTO Ref_Calendar (Calendar_Date, Day_Number) VALUES ('2023-01-01', 1);
INSERT INTO Ref_Calendar (Calendar_Date, Day_Number) VALUES ('2023-01-02', 2);
INSERT INTO Ref_Locations (Location_Code, Location_Name, Location_Description) VALUES ('L1', 'Alpha', 'First Location');
INSERT INTO Ref_Locations (Location_Code, Location_Name, Location_Description) VALUES ('L2', 'Beta', 'Second Location');
INSERT INTO Ref_Locations (Location_Code, Location_Name, Location_Description) VALUES ('L3', 'Gamma', 'Third Location');
INSERT INTO Ref_Locations (Location_Code, Location_Name, Location_Description) VALUES ('L4', 'Delta', 'Fourth Location');
INSERT INTO Ref_Locations (Location_Code, Location_Name, Location_Description) VALUES ('L5', 'Epsilon', 'Fifth Location');
INSERT INTO All_Documents (Document_ID, Date_Stored, Document_Type_Code, Document_Name, Document_Description, Other_Details) VALUES (1, '2023-01-01', 'DT1', 'Doc 1', 'Desc 1', NULL);
INSERT INTO All_Documents (Document_ID, Date_Stored, Document_Type_Code, Document_Name, Document_Description, Other_Details) VALUES (2, '2023-01-01', 'DT1', 'Doc 2', 'Desc 2', NULL);
INSERT INTO All_Documents (Document_ID, Date_Stored, Document_Type_Code, Document_Name, Document_Description, Other_Details) VALUES (3, '2023-01-01', 'DT1', 'Doc 3', 'Desc 3', NULL);
INSERT INTO All_Documents (Document_ID, Date_Stored, Document_Type_Code, Document_Name, Document_Description, Other_Details) VALUES (4, '2023-01-01', 'DT1', 'Doc 4', 'Desc 4', NULL);
INSERT INTO All_Documents (Document_ID, Date_Stored, Document_Type_Code, Document_Name, Document_Description, Other_Details) VALUES (5, '2023-01-01', 'DT1', 'Doc 5', 'Desc 5', NULL);
INSERT INTO All_Documents (Document_ID, Date_Stored, Document_Type_Code, Document_Name, Document_Description, Other_Details) VALUES (6, '2023-01-01', 'DT1', 'Doc 6', 'Desc 6', NULL);
INSERT INTO All_Documents (Document_ID, Date_Stored, Document_Type_Code, Document_Name, Document_Description, Other_Details) VALUES (7, '2023-01-01', 'DT1', 'Doc 7', 'Desc 7', NULL);
INSERT INTO All_Documents (Document_ID, Date_Stored, Document_Type_Code, Document_Name, Document_Description, Other_Details) VALUES (100, '2023-01-01', 'DT1', 'Doc 100', 'Desc 100', NULL);
INSERT INTO All_Documents (Document_ID, Date_Stored, Document_Type_Code, Document_Name, Document_Description, Other_Details) VALUES (200, '2023-01-01', 'DT1', 'Doc 200', 'Desc 200', NULL);
INSERT INTO All_Documents (Document_ID, Date_Stored, Document_Type_Code, Document_Name, Document_Description, Other_Details) VALUES (1000, '2023-01-01', 'DT1', 'Doc 1000', 'Desc 1000', NULL);
INSERT INTO Document_Locations (Document_ID, Location_Code, Date_in_Location_From, Date_in_Locaton_To) VALUES (1, 'L3', '2023-01-01', '2023-01-02');
INSERT INTO Document_Locations (Document_ID, Location_Code, Date_in_Location_From, Date_in_Locaton_To) VALUES (2, 'L3', '2023-01-01', '2023-01-02');
INSERT INTO Document_Locations (Document_ID, Location_Code, Date_in_Location_From, Date_in_Locaton_To) VALUES (3, 'L3', '2023-01-01', '2023-01-02');
INSERT INTO Document_Locations (Document_ID, Location_Code, Date_in_Location_From, Date_in_Locaton_To) VALUES (4, 'L3', '2023-01-01', '2023-01-02');
INSERT INTO Document_Locations (Document_ID, Location_Code, Date_in_Location_From, Date_in_Locaton_To) VALUES (5, 'L3', '2023-01-01', '2023-01-02');
INSERT INTO Document_Locations (Document_ID, Location_Code, Date_in_Location_From, Date_in_Locaton_To) VALUES (1, 'L1', '2023-01-01', '2023-01-02');
INSERT INTO Document_Locations (Document_ID, Location_Code, Date_in_Location_From, Date_in_Locaton_To) VALUES (2, 'L1', '2023-01-01', '2023-01-02');
INSERT INTO Document_Locations (Document_ID, Location_Code, Date_in_Location_From, Date_in_Locaton_To) VALUES (3, 'L1', '2023-01-01', '2023-01-02');
INSERT INTO Document_Locations (Document_ID, Location_Code, Date_in_Location_From, Date_in_Locaton_To) VALUES (6, 'L1', '2023-01-01', '2023-01-02');
INSERT INTO Document_Locations (Document_ID, Location_Code, Date_in_Location_From, Date_in_Locaton_To) VALUES (1, 'L5', '2023-01-01', '2023-01-02');
INSERT INTO Document_Locations (Document_ID, Location_Code, Date_in_Location_From, Date_in_Locaton_To) VALUES (2, 'L5', '2023-01-01', '2023-01-02');
INSERT INTO Document_Locations (Document_ID, Location_Code, Date_in_Location_From, Date_in_Locaton_To) VALUES (7, 'L5', '2023-01-01', '2023-01-02');
INSERT INTO Document_Locations (Document_ID, Location_Code, Date_in_Location_From, Date_in_Locaton_To) VALUES (100, 'L2', '2023-01-01', '2023-01-02');
INSERT INTO Document_Locations (Document_ID, Location_Code, Date_in_Location_From, Date_in_Locaton_To) VALUES (200, 'L2', '2023-01-01', '2023-01-02');
INSERT INTO Document_Locations (Document_ID, Location_Code, Date_in_Location_From, Date_in_Locaton_To) VALUES (1000, 'L4', '2023-01-01', '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT location_code FROM (SELECT * FROM (SELECT * FROM (SELECT location_code, COUNT(*) AS n FROM document_locations GROUP BY location_code) ORDER BY n DESC) LIMIT 3);

/*
Gold Result:
('L3',)
('L1',)
('L5',)
*/

-- Prediction Query
SELECT location_code FROM Document_locations GROUP BY location_code HAVING COUNT(*) >= 3;

/*
Prediction Result:
('L1',)
('L3',)
('L5',)
*/