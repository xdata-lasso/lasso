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
INSERT INTO "ref_calendar" ("calendar_date", "day_number") VALUES ('1970-01-04', 1016.0);
INSERT INTO "ref_calendar" ("calendar_date", "day_number") VALUES ('1974-05-05', NULL);
INSERT INTO "ref_calendar" ("calendar_date", "day_number") VALUES ('1974-05-06', NULL);
INSERT INTO "ref_calendar" ("calendar_date", "day_number") VALUES ('1974-05-07', NULL);
INSERT INTO "ref_calendar" ("calendar_date", "day_number") VALUES ('1974-05-08', NULL);
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('purpose', 'Patrick Sanchez', 'Say quality throughout beautiful.');
INSERT INTO "ref_locations" ("location_code", "location_name", "location_description") VALUES ('33890 Jennifer Squares
Robinsonshire, KY 01352', '503 Linda Locks
Carlshire, FM 94599', '809 Burns Creek
Natashaport, IA 08093');
INSERT INTO "ref_locations" ("location_code", "location_name", "location_description") VALUES ('654 Jason Track
Curtisfurt, CT 47553', '7242 Julie Plain Suite 969
Coxberg, NY 65187', '71822 Arroyo Expressway
Allisonchester, IL 71187');
INSERT INTO "ref_locations" ("location_code", "location_name", "location_description") VALUES ('78161 Calderon River Suite 931
Lake Jeremyport, CO 31013', '22691 James Mountain
Tashatown, TX 94967', '465 Lam Mission
East Jeffreymouth, AK 77611');
INSERT INTO "ref_locations" ("location_code", "location_name", "location_description") VALUES ('7525 Clark Grove Apt. 928
East Steven, KY 84387', '514 Moore Alley Suite 828
Port Colleenhaven, PA 26572', '10310 Jones Freeway
Elizabethborough, ND 17843');
INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (1005, '1970-01-01', 'purpose', 'Kaitlyn Mueller', 'Art rock song body.', 'institution');
INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (1006, '1970-01-01', 'purpose', 'Cheryl Davis', 'Couple large instead everything economic.', 'weight');
INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (1007, '1970-01-01', 'purpose', 'Jeff Owens', 'Kitchen technology nearly anything.', 'artist');
INSERT INTO "all_documents" ("document_id", "date_stored", "document_type_code", "document_name", "document_description", "other_details") VALUES (1008, '1970-01-01', 'purpose', 'Megan Joyce', 'Structure why unit support coach magazine degree.', 'community');
INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (1005, '33890 Jennifer Squares
Robinsonshire, KY 01352', '1974-05-05', '1970-01-01');
INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (1005, '654 Jason Track
Curtisfurt, CT 47553', '1974-05-06', '1970-01-02');
INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (1005, '78161 Calderon River Suite 931
Lake Jeremyport, CO 31013', '1974-05-07', '1970-01-03');
INSERT INTO "document_locations" ("document_id", "location_code", "date_in_location_from", "date_in_locaton_to") VALUES (1005, '7525 Clark Grove Apt. 928
East Steven, KY 84387', '1974-05-08', '1970-01-04');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT location_code FROM (SELECT * FROM (SELECT * FROM (SELECT document_id, location_code, date_in_location_from, date_in_locaton_to, COUNT(*) OVER () AS n FROM document_locations) ORDER BY location_code DESC) LIMIT 1);

/*
Gold Result:
('78161 Calderon River Suite 931\nLake Jeremyport, CO 31013',)
*/

-- Prediction Query
SELECT location_code FROM Document_locations GROUP BY location_code ORDER BY COUNT(*) DESC, location_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('33890 Jennifer Squares\nRobinsonshire, KY 01352',)
*/