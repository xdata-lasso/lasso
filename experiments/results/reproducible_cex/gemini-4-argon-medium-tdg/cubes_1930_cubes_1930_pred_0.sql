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
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('DT1', 'Resume', 'Curriculum Vitae');
INSERT INTO "Ref_Calendar" ("Calendar_Date", "Day_Number") VALUES ('2023-01-01', 1);
INSERT INTO "Ref_Calendar" ("Calendar_Date", "Day_Number") VALUES ('2023-01-02', 2);
INSERT INTO "Ref_Calendar" ("Calendar_Date", "Day_Number") VALUES ('2023-01-03', 3);
INSERT INTO "Ref_Locations" ("Location_Code", "Location_Name", "Location_Description") VALUES ('LOC1', 'Zebra Room', 'Archive Z');
INSERT INTO "Ref_Locations" ("Location_Code", "Location_Name", "Location_Description") VALUES ('LOC2', 'Alpha Room', 'Archive A');
INSERT INTO "Ref_Locations" ("Location_Code", "Location_Name", "Location_Description") VALUES ('LOC3', NULL, 'Unknown Location');
INSERT INTO "Ref_Locations" ("Location_Code", "Location_Name", "Location_Description") VALUES ('LOC4', 'Unused Room', 'No documents here');
INSERT INTO "All_Documents" ("Document_ID", "Date_Stored", "Document_Type_Code", "Document_Name", "Document_Description", "Other_Details") VALUES (1, '2023-01-01', 'DT1', 'Robin CV', 'Robin Resume', 'None');
INSERT INTO "All_Documents" ("Document_ID", "Date_Stored", "Document_Type_Code", "Document_Name", "Document_Description", "Other_Details") VALUES (2, '2023-01-01', 'DT1', 'Batman CV', 'Robin CV', 'Robin CV');
INSERT INTO "All_Documents" ("Document_ID", "Date_Stored", "Document_Type_Code", "Document_Name", "Document_Description", "Other_Details") VALUES (3, '2023-01-01', 'DT1', 'robin cv', 'Lowercase name', 'None');
INSERT INTO "All_Documents" ("Document_ID", "Date_Stored", "Document_Type_Code", "Document_Name", "Document_Description", "Other_Details") VALUES (4, '2023-01-01', 'DT1', 'Robin CV', 'Robin Resume Unplaced', 'No location entry');
INSERT INTO "Document_Locations" ("Document_ID", "Location_Code", "Date_in_Location_From", "Date_in_Locaton_To") VALUES (1, 'LOC1', '2023-01-01', '2023-01-02');
INSERT INTO "Document_Locations" ("Document_ID", "Location_Code", "Date_in_Location_From", "Date_in_Locaton_To") VALUES (1, 'LOC1', '2023-01-02', '2023-01-03');
INSERT INTO "Document_Locations" ("Document_ID", "Location_Code", "Date_in_Location_From", "Date_in_Locaton_To") VALUES (1, 'LOC2', '2023-01-01', '2023-01-02');
INSERT INTO "Document_Locations" ("Document_ID", "Location_Code", "Date_in_Location_From", "Date_in_Locaton_To") VALUES (1, 'LOC3', '2023-01-01', '2023-01-02');
INSERT INTO "Document_Locations" ("Document_ID", "Location_Code", "Date_in_Location_From", "Date_in_Locaton_To") VALUES (2, 'LOC2', '2023-01-01', '2023-01-02');
INSERT INTO "Document_Locations" ("Document_ID", "Location_Code", "Date_in_Location_From", "Date_in_Locaton_To") VALUES (3, 'LOC1', '2023-01-01', '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "location_name" FROM (SELECT "LHS"."location_code" AS "location_code", "LHS"."location_name" AS "location_name", "LHS"."location_description" AS "location_description", "LHS"."document_id" AS "document_id", "LHS"."date_stored" AS "date_stored", "LHS"."document_type_code" AS "document_type_code", "LHS"."document_name" AS "document_name", "LHS"."document_description" AS "document_description", "LHS"."other_details" AS "other_details", "RHS"."date_in_location_from" AS "date_in_location_from", "RHS"."date_in_locaton_to" AS "date_in_locaton_to" FROM (SELECT "LHS"."location_code" AS "location_code", "LHS"."location_name" AS "location_name", "LHS"."location_description" AS "location_description", "RHS"."document_id" AS "document_id", "RHS"."date_stored" AS "date_stored", "RHS"."document_type_code" AS "document_type_code", "RHS"."document_name" AS "document_name", "RHS"."document_description" AS "document_description", "RHS"."other_details" AS "other_details" FROM "ref_locations" AS "LHS" CROSS JOIN "all_documents" AS "RHS") AS "LHS" INNER JOIN "document_locations" AS "RHS" ON ("LHS"."location_code" = "RHS"."location_code" AND "LHS"."document_id" = "RHS"."document_id")) WHERE ("document_name" = 'Robin CV') ORDER BY location_name, "location_name" NULLS LAST;

/*
Gold Result:
(None,)
('Alpha Room',)
('Zebra Room',)
('Zebra Room',)
*/

-- Prediction Query
SELECT T3.location_name FROM All_documents AS T1 JOIN Document_locations AS T2 ON T1.document_id = T2.document_id JOIN Ref_locations AS T3 ON T2.location_code = T3.location_code WHERE T1.document_name = 'Robin CV';

/*
Prediction Result:
('Zebra Room',)
('Zebra Room',)
('Alpha Room',)
(None,)
*/