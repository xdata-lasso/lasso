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
INSERT INTO "ref_calendar" ("calendar_date", "day_number") VALUES ('1970-01-01', 1001);
INSERT INTO "ref_calendar" ("calendar_date", "day_number") VALUES ('1970-01-02', 1006.0);
INSERT INTO "ref_calendar" ("calendar_date", "day_number") VALUES ('1970-01-03', 1011.0);
INSERT INTO "ref_calendar" ("calendar_date", "day_number") VALUES ('1973-04-04', NULL);
INSERT INTO "ref_calendar" ("calendar_date", "day_number") VALUES ('1973-04-05', NULL);
INSERT INTO "ref_calendar" ("calendar_date", "day_number") VALUES ('1973-04-06', NULL);
INSERT INTO "ref_calendar" ("calendar_date", "day_number") VALUES ('1976-07-07', NULL);
INSERT INTO "ref_calendar" ("calendar_date", "day_number") VALUES ('1976-07-08', NULL);
INSERT INTO "ref_calendar" ("calendar_date", "day_number") VALUES ('1976-07-09', NULL);
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('purpose', 'Patrick Sanchez', 'Say quality throughout beautiful.');
INSERT INTO "ref_locations" ("location_code", "location_name", "location_description") VALUES ('33890 Jennifer Squares
Robinsonshire, KY 01352', '7525 Clark Grove Apt. 928
East Steven, KY 84387', '22691 James Mountain
Tashatown, TX 94967');
INSERT INTO "ref_locations" ("location_code", "location_name", "location_description") VALUES ('654 Jason Track
Curtisfurt, CT 47553', '503 Linda Locks
Carlshire, FM 94599', '514 Moore Alley Suite 828
Port Colleenhaven, PA 26572');
INSERT INTO "ref_locations" ("location_code", "location_name", "location_description") VALUES ('78161 Calderon River Suite 931
Lake Jeremyport, CO 31013', '7242 Julie Plain Suite 969
Coxberg, NY 65187', '809 Burns Creek
Natashaport, IA 08093');
INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (1004, '1970-01-01', 'purpose', 'Angela Dennis', 'Enter their institution deep.', 'program');
INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (1005, '1970-01-01', 'purpose', 'Vanessa Patel', 'Sense ready require human public health tonight.', 'artist');
INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (1006, '1970-01-01', 'purpose', 'Matthew Arroyo', 'Building different full open discover detail audience.', 'drop');
INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (1004, '33890 Jennifer Squares
Robinsonshire, KY 01352', '1973-04-04', '1970-01-01');
INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (1005, '33890 Jennifer Squares
Robinsonshire, KY 01352', '1973-04-05', '1970-01-01');
INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (1006, '33890 Jennifer Squares
Robinsonshire, KY 01352', '1973-04-06', '1970-01-01');
INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (1004, '33890 Jennifer Squares
Robinsonshire, KY 01352', '1976-07-07', '1970-01-01');
INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (1005, '33890 Jennifer Squares
Robinsonshire, KY 01352', '1976-07-08', '1970-01-01');
INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (1006, '33890 Jennifer Squares
Robinsonshire, KY 01352', '1976-07-09', '1970-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT location_code FROM (SELECT LHS.date_in_locaton_to AS date_in_locaton_to, LHS.location_code AS location_code, LHS.maxn AS maxn, RHS.date_in_locaton_to AS date_in_locaton_to_other, RHS.location_code AS location_code_other, RHS.maxn AS maxn_other FROM (SELECT date_in_locaton_to, location_code, MAX(n) AS maxn FROM (SELECT date_in_locaton_to, location_code, COUNT(*) AS n FROM document_locations GROUP BY date_in_locaton_to, location_code) GROUP BY date_in_locaton_to, location_code) AS LHS CROSS JOIN (SELECT date_in_locaton_to, location_code, MAX(n) AS maxn FROM (SELECT date_in_locaton_to, location_code, COUNT(*) AS n FROM document_locations GROUP BY date_in_locaton_to, location_code) GROUP BY date_in_locaton_to, location_code) AS RHS) WHERE (maxn > maxn_other) ORDER BY location_code;

/*
Gold Result:
*/

-- Prediction Query
SELECT location_code FROM Document_locations GROUP BY location_code ORDER BY COUNT(*) DESC, location_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('33890 Jennifer Squares\nRobinsonshire, KY 01352',)
*/