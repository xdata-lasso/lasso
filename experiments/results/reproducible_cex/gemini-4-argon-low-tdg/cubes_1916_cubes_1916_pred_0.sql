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
-- Tests basic ordering (DESC vs ASC), LIMIT 1 vs no limit, and column confusion (Document_ID vs Location_Code).
-- Also includes unreferenced rows in Ref_Locations to catch queries querying Ref_Locations instead of Document_Locations.
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('DT1', 'Report', 'Annual Report');
INSERT INTO "Ref_Calendar" ("Calendar_Date", "Day_Number") VALUES ('2023-01-01', 1);
INSERT INTO "Ref_Calendar" ("Calendar_Date", "Day_Number") VALUES ('2023-01-02', 2);
INSERT INTO "Ref_Calendar" ("Calendar_Date", "Day_Number") VALUES ('2023-01-03', 3);
INSERT INTO "Ref_Locations" ("Location_Code", "Location_Name", "Location_Description") VALUES ('LOC_A', 'Alpha', 'First');
INSERT INTO "Ref_Locations" ("Location_Code", "Location_Name", "Location_Description") VALUES ('LOC_B', 'Beta', 'Second');
INSERT INTO "Ref_Locations" ("Location_Code", "Location_Name", "Location_Description") VALUES ('LOC_Z', 'Zeta', 'Unreferenced Max');
INSERT INTO "Ref_Locations" ("Location_Code", "Location_Name", "Location_Description") VALUES ('LOC_0', 'Zero', 'Unreferenced Min');
INSERT INTO "All_Documents" ("Document_ID", "Date_Stored", "Document_Type_Code", "Document_Name", "Document_Description", "Other_Details") VALUES (10, '2023-01-03', 'DT1', 'Doc 10', 'Desc 10', 'None');
INSERT INTO "All_Documents" ("Document_ID", "Date_Stored", "Document_Type_Code", "Document_Name", "Document_Description", "Other_Details") VALUES (20, '2023-01-01', 'DT1', 'Doc 20', 'Desc 20', 'None');
-- LOC_B is lexicographically greater than LOC_A, but has a smaller Document_ID (10 vs 20) and earlier dates.
INSERT INTO "Document_Locations" ("Document_ID", "Location_Code", "Date_in_Location_From", "Date_in_Locaton_To") VALUES (20, 'LOC_A', '2023-01-02', '2023-01-03');
INSERT INTO "Document_Locations" ("Document_ID", "Location_Code", "Date_in_Location_From", "Date_in_Locaton_To") VALUES (10, 'LOC_B', '2023-01-01', '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT location_code FROM (SELECT * FROM (SELECT * FROM (SELECT document_id, location_code, date_in_location_from, date_in_locaton_to, COUNT(*) OVER () AS n FROM document_locations) ORDER BY location_code DESC) LIMIT 1);

/*
Gold Result:
('LOC_B',)
*/

-- Prediction Query
SELECT location_code FROM Document_locations GROUP BY location_code ORDER BY COUNT(*) DESC, location_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('LOC_A',)
*/