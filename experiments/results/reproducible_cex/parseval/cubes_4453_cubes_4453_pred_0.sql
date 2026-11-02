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
INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483648, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483647, '2024-06-15 00:00:00+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483646, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483645, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483644, '2024-06-15 00:00:00+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483643, '2024-06-15 00:00:00+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483642, '2024-06-15 00:00:00+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483641, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483640, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483639, '2024-06-15 00:00:00+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483638, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483637, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483636, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483635, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483634, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483633, '2024-06-15 00:00:00+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483632, '2024-06-15 00:00:00+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483631, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483630, '2024-06-15 00:00:00+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483629, '2024-06-15 00:00:00+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483628, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483627, '2024-06-15 00:00:00+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483626, '2024-06-15 00:00:00+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483625, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483624, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483623, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483622, '2024-06-15 00:00:00+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483621, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483620, '2024-06-15 00:00:00+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483619, '2024-06-15 00:00:00+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483618, '2024-06-15 00:00:00+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483617, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483616, '2024-06-15 00:00:00+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483615, '2024-06-15 00:00:00+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483614, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483613, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483612, '2024-06-15 00:00:00+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483611, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483610, '2024-06-15 00:00:00+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483609, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483608, '2024-06-15 00:00:00+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483607, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483606, '2024-06-15 00:00:00+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483605, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483604, '2024-06-15 00:00:00+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483603, '2024-06-15 00:00:00+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483602, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483601, '2024-06-15 00:00:00+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483600, '2024-06-15 00:00:00+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483599, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483598, '2024-06-15 00:00:00+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483597, '2024-06-15 00:00:00+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483596, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483595, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483594, '2024-06-15 00:00:00+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (-2147483593, '2024-12-15 00:56:33+00:00', 'document_type_1', 'all_aaa0da', 'all_d886d2', 'all_650696');

-- Inserting into table: ref_document_types --
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('document_type_1', 'ref_4df9bb', 'ref_df47b1');

-- Inserting into table: ref_locations --
INSERT INTO "ref_locations" ("location_code", "location_name", "location_description") VALUES ('doc_c62a89', 'ref_53b3b6', 'ref_ffd82f');

INSERT INTO "ref_locations" ("location_code", "location_name", "location_description") VALUES ('doc_f76a18', 'ref_53b3b6', 'ref_ffd82f');

-- Inserting into table: document_locations --
INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483648, 'doc_c62a89', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483647, 'doc_c62a89', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483646, 'doc_c62a89', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483646, 'doc_f76a18', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483647, 'doc_f76a18', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483648, 'doc_f76a18', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483645, 'doc_c62a89', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483645, 'doc_c62a89', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483646, 'doc_c62a89', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483644, 'doc_f76a18', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483646, 'doc_f76a18', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483643, 'doc_f76a18', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483648, 'doc_c62a89', '2024-12-15 00:56:33+00:00', '2024-12-15 00:56:33+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483644, 'doc_c62a89', '2024-06-15 00:00:00+00:00', '2024-12-15 00:56:33+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483643, 'doc_c62a89', '2024-06-15 00:00:00+00:00', '2024-12-15 00:56:33+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483642, 'doc_f76a18', '2024-06-15 00:00:00+00:00', '2024-12-15 00:56:33+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483641, 'doc_f76a18', '2024-12-15 00:56:33+00:00', '2024-12-15 00:56:33+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483645, 'doc_f76a18', '2024-12-15 00:56:33+00:00', '2024-12-15 00:56:33+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483640, 'doc_c62a89', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483639, 'doc_c62a89', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483643, 'doc_c62a89', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483638, 'doc_f76a18', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483638, 'doc_f76a18', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483639, 'doc_f76a18', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483637, 'doc_c62a89', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483639, 'doc_c62a89', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483637, 'doc_c62a89', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483636, 'doc_f76a18', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483635, 'doc_f76a18', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483645, 'doc_f76a18', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483641, 'doc_c62a89', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483634, 'doc_c62a89', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483636, 'doc_c62a89', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483633, 'doc_f76a18', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483632, 'doc_f76a18', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483641, 'doc_f76a18', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483631, 'doc_c62a89', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483630, 'doc_c62a89', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483638, 'doc_c62a89', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483643, 'doc_f76a18', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483640, 'doc_f76a18', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483635, 'doc_f76a18', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483629, 'doc_c62a89', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483641, 'doc_c62a89', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483634, 'doc_c62a89', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483631, 'doc_f76a18', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483628, 'doc_f76a18', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483627, 'doc_f76a18', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483644, 'doc_c62a89', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483626, 'doc_c62a89', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483625, 'doc_c62a89', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483625, 'doc_f76a18', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483640, 'doc_f76a18', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483624, 'doc_f76a18', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483638, 'doc_c62a89', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483623, 'doc_c62a89', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483622, 'doc_c62a89', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483621, 'doc_f76a18', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483623, 'doc_f76a18', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483620, 'doc_f76a18', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483623, 'doc_c62a89', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483619, 'doc_c62a89', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483621, 'doc_c62a89', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483618, 'doc_f76a18', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483626, 'doc_f76a18', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483617, 'doc_f76a18', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483616, 'doc_c62a89', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483624, 'doc_c62a89', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483625, 'doc_c62a89', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483615, 'doc_f76a18', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483614, 'doc_f76a18', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483613, 'doc_f76a18', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483612, 'doc_c62a89', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483632, 'doc_c62a89', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483611, 'doc_c62a89', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483610, 'doc_f76a18', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483629, 'doc_f76a18', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483622, 'doc_f76a18', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483609, 'doc_c62a89', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483608, 'doc_c62a89', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483619, 'doc_c62a89', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483608, 'doc_f76a18', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483607, 'doc_f76a18', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483606, 'doc_f76a18', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483605, 'doc_c62a89', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483604, 'doc_c62a89', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483603, 'doc_c62a89', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483602, 'doc_f76a18', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483601, 'doc_f76a18', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483600, 'doc_f76a18', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483599, 'doc_c62a89', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483598, 'doc_c62a89', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483597, 'doc_c62a89', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483612, 'doc_f76a18', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483596, 'doc_f76a18', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483595, 'doc_f76a18', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483617, 'doc_c62a89', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483595, 'doc_c62a89', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483631, 'doc_c62a89', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483639, 'doc_f76a18', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483594, 'doc_f76a18', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');

INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (-2147483593, 'doc_f76a18', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT location_code FROM (SELECT LHS.date_in_locaton_to AS date_in_locaton_to, LHS.location_code AS location_code, LHS.maxn AS maxn, RHS.date_in_locaton_to AS date_in_locaton_to_other, RHS.location_code AS location_code_other, RHS.maxn AS maxn_other FROM (SELECT date_in_locaton_to, location_code, MAX(n) AS maxn FROM (SELECT date_in_locaton_to, location_code, COUNT(*) AS n FROM document_locations GROUP BY date_in_locaton_to, location_code) GROUP BY date_in_locaton_to, location_code) AS LHS CROSS JOIN (SELECT date_in_locaton_to, location_code, MAX(n) AS maxn FROM (SELECT date_in_locaton_to, location_code, COUNT(*) AS n FROM document_locations GROUP BY date_in_locaton_to, location_code) GROUP BY date_in_locaton_to, location_code) AS RHS) WHERE (maxn > maxn_other) ORDER BY location_code;

/*
Gold Result:
('doc_c62a89',)
('doc_f76a18',)
*/

-- Prediction Query
SELECT location_code FROM Document_locations GROUP BY location_code ORDER BY COUNT(*) DESC, location_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('doc_c62a89',)
*/