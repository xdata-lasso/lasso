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
-- 1. Strict descending order of COUNT(*) with 5 locations (kills LIMIT 1, 2, 4, 5, no LIMIT, and ASC order).
-- 2. Reverse alphabetical correlation with count (Z > Y > X > W > V) to kill mutants ordering by location_code ASC/DESC.
-- 3. Multiple occurrences of the same Document_ID in the same Location_Code at different dates to kill COUNT(DISTINCT Document_ID) vs COUNT(*).
-- 4. NULL values in Date_in_Locaton_To to kill COUNT(Date_in_Locaton_To) vs COUNT(*).
-- 5. Unreferenced rows in Ref_Locations and All_Documents to kill LEFT/RIGHT JOINs without proper filtering.
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('DT1', 'Report', 'Standard Report');
INSERT INTO "Ref_Calendar" ("Calendar_Date", "Day_Number") VALUES ('2023-01-01', 1);
INSERT INTO "Ref_Calendar" ("Calendar_Date", "Day_Number") VALUES ('2023-01-02', 2);
INSERT INTO "Ref_Calendar" ("Calendar_Date", "Day_Number") VALUES ('2023-01-03', 3);
INSERT INTO "Ref_Calendar" ("Calendar_Date", "Day_Number") VALUES ('2023-01-04', 4);
INSERT INTO "Ref_Calendar" ("Calendar_Date", "Day_Number") VALUES ('2023-01-05', 5);
INSERT INTO "Ref_Locations" ("Location_Code", "Location_Name", "Location_Description") VALUES ('LOC_Z', 'Alpha', 'Desc Z');
INSERT INTO "Ref_Locations" ("Location_Code", "Location_Name", "Location_Description") VALUES ('LOC_Y', 'Beta', 'Desc Y');
INSERT INTO "Ref_Locations" ("Location_Code", "Location_Name", "Location_Description") VALUES ('LOC_X', 'Gamma', 'Desc X');
INSERT INTO "Ref_Locations" ("Location_Code", "Location_Name", "Location_Description") VALUES ('LOC_W', 'Delta', 'Desc W');
INSERT INTO "Ref_Locations" ("Location_Code", "Location_Name", "Location_Description") VALUES ('LOC_V', 'Epsilon', 'Desc V');
INSERT INTO "Ref_Locations" ("Location_Code", "Location_Name", "Location_Description") VALUES ('LOC_UNUSED', 'Zeta', 'Unused Location');
INSERT INTO "All_Documents" ("Document_ID", "Date_Stored", "Document_Type_Code", "Document_Name", "Document_Description", "Other_Details") VALUES (10, '2023-01-01', 'DT1', 'Doc 10', 'Desc', 'Details');
INSERT INTO "All_Documents" ("Document_ID", "Date_Stored", "Document_Type_Code", "Document_Name", "Document_Description", "Other_Details") VALUES (20, '2023-01-01', 'DT1', 'Doc 20', 'Desc', 'Details');
INSERT INTO "All_Documents" ("Document_ID", "Date_Stored", "Document_Type_Code", "Document_Name", "Document_Description", "Other_Details") VALUES (30, '2023-01-01', 'DT1', 'Doc 30', 'Desc', 'Details');
INSERT INTO "All_Documents" ("Document_ID", "Date_Stored", "Document_Type_Code", "Document_Name", "Document_Description", "Other_Details") VALUES (40, '2023-01-01', 'DT1', 'Doc 40', 'Desc', 'Details');
INSERT INTO "All_Documents" ("Document_ID", "Date_Stored", "Document_Type_Code", "Document_Name", "Document_Description", "Other_Details") VALUES (99, '2023-01-01', 'DT1', 'Doc Unused', 'Desc', 'Details');
-- LOC_Z: 5 rows total, but only 1 distinct Document_ID (10), and NULLs in Date_in_Locaton_To
INSERT INTO "Document_Locations" ("Document_ID", "Location_Code", "Date_in_Location_From", "Date_in_Locaton_To") VALUES (10, 'LOC_Z', '2023-01-01', NULL);
INSERT INTO "Document_Locations" ("Document_ID", "Location_Code", "Date_in_Location_From", "Date_in_Locaton_To") VALUES (10, 'LOC_Z', '2023-01-02', NULL);
INSERT INTO "Document_Locations" ("Document_ID", "Location_Code", "Date_in_Location_From", "Date_in_Locaton_To") VALUES (10, 'LOC_Z', '2023-01-03', NULL);
INSERT INTO "Document_Locations" ("Document_ID", "Location_Code", "Date_in_Location_From", "Date_in_Locaton_To") VALUES (10, 'LOC_Z', '2023-01-04', NULL);
INSERT INTO "Document_Locations" ("Document_ID", "Location_Code", "Date_in_Location_From", "Date_in_Locaton_To") VALUES (10, 'LOC_Z', '2023-01-05', '2023-01-05');
-- LOC_Y: 4 rows total, 2 distinct Document_IDs (10, 20)
INSERT INTO "Document_Locations" ("Document_ID", "Location_Code", "Date_in_Location_From", "Date_in_Locaton_To") VALUES (10, 'LOC_Y', '2023-01-01', '2023-01-02');
INSERT INTO "Document_Locations" ("Document_ID", "Location_Code", "Date_in_Location_From", "Date_in_Locaton_To") VALUES (10, 'LOC_Y', '2023-01-02', '2023-01-03');
INSERT INTO "Document_Locations" ("Document_ID", "Location_Code", "Date_in_Location_From", "Date_in_Locaton_To") VALUES (20, 'LOC_Y', '2023-01-01', NULL);
INSERT INTO "Document_Locations" ("Document_ID", "Location_Code", "Date_in_Location_From", "Date_in_Locaton_To") VALUES (20, 'LOC_Y', '2023-01-02', NULL);
-- LOC_X: 3 rows total, 3 distinct Document_IDs (10, 20, 30)
INSERT INTO "Document_Locations" ("Document_ID", "Location_Code", "Date_in_Location_From", "Date_in_Locaton_To") VALUES (10, 'LOC_X', '2023-01-01', '2023-01-02');
INSERT INTO "Document_Locations" ("Document_ID", "Location_Code", "Date_in_Location_From", "Date_in_Locaton_To") VALUES (20, 'LOC_X', '2023-01-01', '2023-01-02');
INSERT INTO "Document_Locations" ("Document_ID", "Location_Code", "Date_in_Location_From", "Date_in_Locaton_To") VALUES (30, 'LOC_X', '2023-01-01', '2023-01-02');
-- LOC_W: 2 rows total, 2 distinct Document_IDs (30, 40) - higher SUM(Document_ID) than LOC_X and LOC_Z
INSERT INTO "Document_Locations" ("Document_ID", "Location_Code", "Date_in_Location_From", "Date_in_Locaton_To") VALUES (30, 'LOC_W', '2023-01-01', '2023-01-02');
INSERT INTO "Document_Locations" ("Document_ID", "Location_Code", "Date_in_Location_From", "Date_in_Locaton_To") VALUES (40, 'LOC_W', '2023-01-01', '2023-01-02');
-- LOC_V: 1 row total, 1 distinct Document_ID (40) - highest AVG/MIN(Document_ID)
INSERT INTO "Document_Locations" ("Document_ID", "Location_Code", "Date_in_Location_From", "Date_in_Locaton_To") VALUES (40, 'LOC_V', '2023-01-01', '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT location_code FROM (SELECT * FROM (SELECT * FROM (SELECT location_code, COUNT(*) AS n FROM document_locations GROUP BY location_code) ORDER BY n DESC) LIMIT 3);

/*
Gold Result:
('LOC_Z',)
('LOC_Y',)
('LOC_X',)
*/

-- Prediction Query
SELECT location_code FROM Document_locations GROUP BY location_code HAVING COUNT(*) >= 3;

/*
Prediction Result:
('LOC_X',)
('LOC_Y',)
('LOC_Z',)
*/