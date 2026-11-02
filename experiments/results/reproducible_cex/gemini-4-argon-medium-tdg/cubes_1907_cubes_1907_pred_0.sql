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
-- Tests basic ordering (insertion order differs from Location_Code order, and Location_Name order differs from Location_Code order),
-- and tests joins with Document_Locations (Location L1 has 2 documents, L2 has 0, L3 has 1).
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('DT1', 'Report', 'Annual Report');
INSERT INTO "Ref_Calendar" ("Calendar_Date", "Day_Number") VALUES ('2023-01-01', 1);
INSERT INTO "Ref_Calendar" ("Calendar_Date", "Day_Number") VALUES ('2023-01-02', 2);
INSERT INTO "Ref_Locations" ("Location_Code", "Location_Name", "Location_Description") VALUES ('LOC_C', 'Alpha Room', 'Desc Alpha');
INSERT INTO "Ref_Locations" ("Location_Code", "Location_Name", "Location_Description") VALUES ('LOC_A', 'Zulu Room', 'Desc Zulu');
INSERT INTO "Ref_Locations" ("Location_Code", "Location_Name", "Location_Description") VALUES ('LOC_B', 'Mike Room', 'Desc Mike');
INSERT INTO "All_Documents" ("Document_ID", "Date_Stored", "Document_Type_Code", "Document_Name", "Document_Description", "Other_Details") VALUES (1, '2023-01-01', 'DT1', 'Doc 1', 'D1', 'None');
INSERT INTO "All_Documents" ("Document_ID", "Date_Stored", "Document_Type_Code", "Document_Name", "Document_Description", "Other_Details") VALUES (2, '2023-01-01', 'DT1', 'Doc 2', 'D2', 'None');
INSERT INTO "Document_Locations" ("Document_ID", "Location_Code", "Date_in_Location_From", "Date_in_Locaton_To") VALUES (1, 'LOC_A', '2023-01-01', '2023-01-02');
INSERT INTO "Document_Locations" ("Document_ID", "Location_Code", "Date_in_Location_From", "Date_in_Locaton_To") VALUES (2, 'LOC_A', '2023-01-01', '2023-01-02');
INSERT INTO "Document_Locations" ("Document_ID", "Location_Code", "Date_in_Location_From", "Date_in_Locaton_To") VALUES (1, 'LOC_C', '2023-01-02', '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT location_code, location_name FROM ref_locations ORDER BY location_code;

/*
Gold Result:
('LOC_A', 'Zulu Room')
('LOC_B', 'Mike Room')
('LOC_C', 'Alpha Room')
*/

-- Prediction Query
SELECT location_code, location_name FROM Ref_locations;

/*
Prediction Result:
('LOC_C', 'Alpha Room')
('LOC_A', 'Zulu Room')
('LOC_B', 'Mike Room')
*/