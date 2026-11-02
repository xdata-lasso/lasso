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
INSERT INTO "ref_calendar" ("calendar_date", "day_number") VALUES ('1974-05-05', 1006);
INSERT INTO "ref_calendar" ("calendar_date", "day_number") VALUES ('1976-07-07', 1008);
INSERT INTO "ref_calendar" ("calendar_date", "day_number") VALUES ('1975-06-06', NULL);
INSERT INTO "ref_calendar" ("calendar_date", "day_number") VALUES ('1977-08-08', NULL);
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('hour', 'Kimberly Osborne', 'Truth out major born guy world southern.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('shoulder', 'Matthew Lucas', 'I fund technology eat.');
INSERT INTO "ref_locations" ("location_code", "location_name", "location_description") VALUES ('62473 Scott Wall Apt. 080
Port Melindaburgh, MT 64154', '83465 Lam Mission Apt. 331
Andrewside, IN 77629', '031 Michele Cliffs
West Elizabeth, IL 71179');
INSERT INTO "ref_locations" ("location_code", "location_name", "location_description") VALUES ('117 Tiffany Place
East Donna, OH 22144', '26064 Mitchell Square Suite 234
North Beth, ND 08490', '97882 Susan Common
North Brooke, TX 31329');
INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (1007, '1974-05-05', 'hour', 'Timothy Duncan', 'Drug list imagine behind probably great in.', 'treat');
INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (1009, '1976-07-07', 'shoulder', 'Todd Hudson', 'Organization people information on mission various daughter respond.', 'edge');
INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (1007, '62473 Scott Wall Apt. 080
Port Melindaburgh, MT 64154', '1975-06-06', '1974-05-05');
INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (1009, '117 Tiffany Place
East Donna, OH 22144', '1977-08-08', '1976-07-07');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT location_code, date_in_location_from, date_in_locaton_to FROM document_locations ORDER BY location_code, document_locations.document_id NULLS LAST, document_locations.date_in_location_from NULLS LAST;

/*
Gold Result:
('117 Tiffany Place\nEast Donna, OH 22144', '1977-08-08', '1976-07-07')
('62473 Scott Wall Apt. 080\nPort Melindaburgh, MT 64154', '1975-06-06', '1974-05-05')
*/

-- Prediction Query
SELECT location_code, date_in_location_from, date_in_locaton_to FROM Document_locations;

/*
Prediction Result:
('62473 Scott Wall Apt. 080\nPort Melindaburgh, MT 64154', '1975-06-06', '1974-05-05')
('117 Tiffany Place\nEast Donna, OH 22144', '1977-08-08', '1976-07-07')
*/