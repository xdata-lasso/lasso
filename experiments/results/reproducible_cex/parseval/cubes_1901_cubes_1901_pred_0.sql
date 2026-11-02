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
-- Inserting into table: ref_calendar --
INSERT INTO "ref_calendar" ("calendar_date", "day_number") VALUES ('2024-12-15 00:56:33+00:00', 600401919);

INSERT INTO "ref_calendar" ("calendar_date", "day_number") VALUES ('2024-06-15 00:00:00+00:00', -1437333179);

-- Inserting into table: all_documents --
INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (1, '2024-12-15 00:56:33+00:00', 'document_type_1', 'Robin CV', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483647, '2024-06-15 00:00:00+00:00', 'document_type_1', 'Robin CV', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (3, '2024-06-15 00:00:00+00:00', 'document_type_1', 'Robin CV', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (2, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (4, '2024-06-15 00:00:00+00:00', 'document_type_1', NULL, 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (5, '2024-06-15 00:00:00+00:00', 'document_type_1', 'Robin CV', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (6, '2024-06-15 00:00:00+00:00', 'document_type_1', 'Robin CV', 'all_d886d2', 'all_650696');

-- Inserting into table: ref_document_types --
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('document_type_1', 'ref_4df9bb', 'ref_df47b1');

-- Inserting into table: ref_locations --
INSERT INTO "ref_locations" ("location_code", "location_name", "location_description") VALUES ('location_code_1', 'ref_53b3b6', 'ref_ffd82f');

INSERT INTO "ref_locations" ("location_code", "location_name", "location_description") VALUES ('location_code_2', 'ref_53b3b6', 'ref_ffd82f');

INSERT INTO "ref_locations" ("location_code", "location_name", "location_description") VALUES ('location_code_3', 'ref_53b3b6', 'ref_ffd82f');

INSERT INTO "ref_locations" ("location_code", "location_name", "location_description") VALUES ('location_code_4', 'ref_53b3b6', 'ref_ffd82f');

INSERT INTO "ref_locations" ("location_code", "location_name", "location_description") VALUES ('location_code_5', 'ref_53b3b6', 'ref_ffd82f');

INSERT INTO "ref_locations" ("location_code", "location_name", "location_description") VALUES ('location_code_6', 'ref_53b3b6', 'ref_ffd82f');

INSERT INTO "ref_locations" ("location_code", "location_name", "location_description") VALUES ('location_code_7', 'ref_53b3b6', 'ref_ffd82f');

INSERT INTO "ref_locations" ("location_code", "location_name", "location_description") VALUES ('location_code_8', 'ref_53b3b6', 'ref_ffd82f');

INSERT INTO "ref_locations" ("location_code", "location_name", "location_description") VALUES ('location_code_9', 'ref_53b3b6', 'ref_ffd82f');

INSERT INTO "ref_locations" ("location_code", "location_name", "location_description") VALUES ('location_cod_10', 'ref_53b3b6', 'ref_ffd82f');

INSERT INTO "ref_locations" ("location_code", "location_name", "location_description") VALUES ('location_cod_11', 'ref_53b3b6', 'ref_ffd82f');

INSERT INTO "ref_locations" ("location_code", "location_name", "location_description") VALUES ('location_cod_12', 'ref_53b3b6', 'ref_ffd82f');

-- Inserting into table: document_locations --
INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (1, 'location_code_1', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (1, 'location_code_2', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (1, 'location_code_3', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (2, 'location_code_2', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (2, 'location_code_3', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (2, 'location_code_1', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (1, 'location_code_4', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (1, 'location_code_5', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (1, 'location_code_6', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (1, 'location_code_7', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (1, 'location_code_8', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (1, 'location_code_9', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (1, 'location_cod_10', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (1, 'location_cod_11', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (1, 'location_cod_12', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (4, 'location_code_6', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (5, 'location_code_6', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (6, 'location_code_5', '2024-12-15 00:56:33+00:00', '2024-12-15 00:56:33+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "date_in_location_from", "date_in_locaton_to" FROM (SELECT * FROM "document_locations" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "all_documents" WHERE ("document_name" <> 'Robin CV')) AS RHS WHERE (LHS.document_id = RHS.document_id))) ORDER BY date_in_location_from, "date_in_location_from" NULLS LAST, "date_in_locaton_to" NULLS LAST;

/*
Gold Result:
('2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00')
('2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00')
('2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00')
('2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00')
('2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00')
('2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00')
('2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00')
('2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00')
('2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00')
('2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00')
('2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00')
('2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00')
('2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00')
('2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00')
('2024-12-15 00:56:33+00:00', '2024-12-15 00:56:33+00:00')
*/

-- Prediction Query
SELECT T1.date_in_location_from, T1.date_in_locaton_to FROM Document_locations AS T1 JOIN All_documents AS T2 ON T1.document_id = T2.document_id WHERE T2.document_name = 'Robin CV';

/*
Prediction Result:
('2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00')
('2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00')
('2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00')
('2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00')
('2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00')
('2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00')
('2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00')
('2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00')
('2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00')
('2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00')
('2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00')
('2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00')
('2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00')
('2024-12-15 00:56:33+00:00', '2024-12-15 00:56:33+00:00')
*/