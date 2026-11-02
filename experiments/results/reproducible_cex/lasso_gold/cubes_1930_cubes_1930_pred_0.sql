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
INSERT INTO "ref_calendar" ("calendar_date", "day_number") VALUES ('1971-09-08', 1032);
INSERT INTO "ref_calendar" ("calendar_date", "day_number") VALUES ('1975-02-12', 1036);
INSERT INTO "ref_calendar" ("calendar_date", "day_number") VALUES ('1972-10-09', NULL);
INSERT INTO "ref_calendar" ("calendar_date", "day_number") VALUES ('1973-11-10', NULL);
INSERT INTO "ref_calendar" ("calendar_date", "day_number") VALUES ('1974-01-11', NULL);
INSERT INTO "ref_calendar" ("calendar_date", "day_number") VALUES ('1976-03-13', NULL);
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('none', 'Eugene Higgins', 'Their along attention piece TV young section.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('shake', 'Jennifer Singleton', 'Hand so add Mr lawyer pull public.');
INSERT INTO "ref_locations" ("location_code", "location_name", "location_description") VALUES ('172 Berger Cape
Lauraport, MI 49632', '692 Gregory Ridge
Harveybury, NM 76936', '474 Rachel Mountain Suite 821
Landryshire, ME 84247');
INSERT INTO "ref_locations" ("location_code", "location_name", "location_description") VALUES ('37098 Herman Forges Apt. 746
East Brandonton, ME 65070', '267 Santiago Summit
Matthewsberg, FM 54880', '640 Robinson Mills Apt. 515
Bruceview, ID 16512');
INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (1033, '1971-09-08', 'none', 'Robin CV', 'Real lead few yourself table blood.', 'I');
INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (1037, '1975-02-12', 'shake', 'Robin CV', 'Begin deep police wife anything four writer.', 'stop');
INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (1033, '172 Berger Cape
Lauraport, MI 49632', '1972-10-09', '1971-09-08');
INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (1033, '172 Berger Cape
Lauraport, MI 49632', '1974-01-11', '1973-11-10');
INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (1037, '37098 Herman Forges Apt. 746
East Brandonton, ME 65070', '1976-03-13', '1975-02-12');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "location_name" FROM (SELECT "LHS"."location_code" AS "location_code", "LHS"."location_name" AS "location_name", "LHS"."location_description" AS "location_description", "LHS"."document_id" AS "document_id", "LHS"."date_stored" AS "date_stored", "LHS"."document_type_code" AS "document_type_code", "LHS"."document_name" AS "document_name", "LHS"."document_description" AS "document_description", "LHS"."other_details" AS "other_details", "RHS"."date_in_location_from" AS "date_in_location_from", "RHS"."date_in_locaton_to" AS "date_in_locaton_to" FROM (SELECT "LHS"."location_code" AS "location_code", "LHS"."location_name" AS "location_name", "LHS"."location_description" AS "location_description", "RHS"."document_id" AS "document_id", "RHS"."date_stored" AS "date_stored", "RHS"."document_type_code" AS "document_type_code", "RHS"."document_name" AS "document_name", "RHS"."document_description" AS "document_description", "RHS"."other_details" AS "other_details" FROM "ref_locations" AS "LHS" CROSS JOIN "all_documents" AS "RHS") AS "LHS" INNER JOIN "document_locations" AS "RHS" ON ("LHS"."location_code" = "RHS"."location_code" AND "LHS"."document_id" = "RHS"."document_id")) WHERE ("document_name" = 'Robin CV') ORDER BY location_name, "location_name" NULLS LAST;

/*
Gold Result:
('267 Santiago Summit\nMatthewsberg, FM 54880',)
('692 Gregory Ridge\nHarveybury, NM 76936',)
('692 Gregory Ridge\nHarveybury, NM 76936',)
*/

-- Prediction Query
SELECT T3.location_name FROM All_documents AS T1 JOIN Document_locations AS T2 ON T1.document_id = T2.document_id JOIN Ref_locations AS T3 ON T2.location_code = T3.location_code WHERE T1.document_name = 'Robin CV';

/*
Prediction Result:
('692 Gregory Ridge\nHarveybury, NM 76936',)
('692 Gregory Ridge\nHarveybury, NM 76936',)
('267 Santiago Summit\nMatthewsberg, FM 54880',)
*/