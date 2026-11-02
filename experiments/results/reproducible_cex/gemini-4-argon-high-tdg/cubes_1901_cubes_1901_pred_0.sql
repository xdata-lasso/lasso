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
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('CV', 'Curriculum Vitae', 'Resume document');
INSERT INTO Ref_Document_Types (Document_Type_Code, Document_Type_Name, Document_Type_Description) VALUES ('REP', 'Report', 'Internal report');
INSERT INTO Ref_Calendar (Calendar_Date, Day_Number) VALUES ('2023-01-01', 1);
INSERT INTO Ref_Calendar (Calendar_Date, Day_Number) VALUES ('2023-01-10', 10);
INSERT INTO Ref_Calendar (Calendar_Date, Day_Number) VALUES ('2023-02-01', 32);
INSERT INTO Ref_Calendar (Calendar_Date, Day_Number) VALUES ('2023-02-15', 46);
INSERT INTO Ref_Calendar (Calendar_Date, Day_Number) VALUES ('2023-03-01', 60);
INSERT INTO Ref_Calendar (Calendar_Date, Day_Number) VALUES ('2023-03-20', 79);
INSERT INTO Ref_Calendar (Calendar_Date, Day_Number) VALUES ('2023-04-01', 91);
INSERT INTO Ref_Calendar (Calendar_Date, Day_Number) VALUES ('2023-04-10', 100);
INSERT INTO Ref_Locations (Location_Code, Location_Name, Location_Description) VALUES ('LOC1', 'Archive A', 'Main archive');
INSERT INTO Ref_Locations (Location_Code, Location_Name, Location_Description) VALUES ('LOC2', 'Office B', 'HR office');
INSERT INTO All_Documents (Document_ID, Date_Stored, Document_Type_Code, Document_Name, Document_Description, Other_Details) VALUES (1, '2023-01-01', 'CV', 'Robin CV', 'Robin application', 'None');
INSERT INTO All_Documents (Document_ID, Date_Stored, Document_Type_Code, Document_Name, Document_Description, Other_Details) VALUES (2, '2023-01-01', 'CV', 'Batman CV', 'Batman application', 'None');
INSERT INTO All_Documents (Document_ID, Date_Stored, Document_Type_Code, Document_Name, Document_Description, Other_Details) VALUES (3, '2023-01-01', 'REP', 'Robin Report', 'Annual report', 'None');
INSERT INTO Document_Locations (Document_ID, Location_Code, Date_in_Location_From, Date_in_Locaton_To) VALUES (1, 'LOC1', '2023-03-01', '2023-03-20');
INSERT INTO Document_Locations (Document_ID, Location_Code, Date_in_Location_From, Date_in_Locaton_To) VALUES (1, 'LOC2', '2023-01-10', '2023-02-01');
INSERT INTO Document_Locations (Document_ID, Location_Code, Date_in_Location_From, Date_in_Locaton_To) VALUES (1, 'LOC1', '2023-02-01', '2023-02-15');
INSERT INTO Document_Locations (Document_ID, Location_Code, Date_in_Location_From, Date_in_Locaton_To) VALUES (2, 'LOC1', '2023-04-01', '2023-04-10');
INSERT INTO Document_Locations (Document_ID, Location_Code, Date_in_Location_From, Date_in_Locaton_To) VALUES (3, 'LOC2', '2023-01-01', '2023-01-10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "date_in_location_from", "date_in_locaton_to" FROM (SELECT * FROM "document_locations" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "all_documents" WHERE ("document_name" <> 'Robin CV')) AS RHS WHERE (LHS.document_id = RHS.document_id))) ORDER BY date_in_location_from, "date_in_location_from" NULLS LAST, "date_in_locaton_to" NULLS LAST;

/*
Gold Result:
('2023-01-10', '2023-02-01')
('2023-02-01', '2023-02-15')
('2023-03-01', '2023-03-20')
*/

-- Prediction Query
SELECT T1.date_in_location_from, T1.date_in_locaton_to FROM Document_locations AS T1 JOIN All_documents AS T2 ON T1.document_id = T2.document_id WHERE T2.document_name = 'Robin CV';

/*
Prediction Result:
('2023-02-01', '2023-02-15')
('2023-03-01', '2023-03-20')
('2023-01-10', '2023-02-01')
*/