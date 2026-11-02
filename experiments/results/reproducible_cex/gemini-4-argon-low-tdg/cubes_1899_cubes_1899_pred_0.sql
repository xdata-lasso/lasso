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
-- Tests: INNER JOIN vs LEFT/RIGHT/FULL OUTER JOIN, DISTINCT vs ALL (multiplicity), and secondary sort on date_stored when day_number is tied.
INSERT INTO "Ref_Document_Types" ("Document_Type_Code", "Document_Type_Name", "Document_Type_Description") VALUES ('DT1', 'Invoice', 'Standard Invoice');
INSERT INTO "Ref_Calendar" ("Calendar_Date", "Day_Number") VALUES ('2023-01-10', 5);
INSERT INTO "Ref_Calendar" ("Calendar_Date", "Day_Number") VALUES ('2023-01-05', 5);
INSERT INTO "Ref_Calendar" ("Calendar_Date", "Day_Number") VALUES ('2023-01-20', 2);
INSERT INTO "Ref_Calendar" ("Calendar_Date", "Day_Number") VALUES ('2023-01-30', 9);
INSERT INTO "All_Documents" ("Document_ID", "Date_Stored", "Document_Type_Code", "Document_Name", "Document_Description", "Other_Details") VALUES (1, '2023-01-10', 'DT1', 'Doc A', 'Desc A', 'Details A');
INSERT INTO "All_Documents" ("Document_ID", "Date_Stored", "Document_Type_Code", "Document_Name", "Document_Description", "Other_Details") VALUES (2, '2023-01-05', 'DT1', 'Doc B', 'Desc B', 'Details B');
INSERT INTO "All_Documents" ("Document_ID", "Date_Stored", "Document_Type_Code", "Document_Name", "Document_Description", "Other_Details") VALUES (3, '2023-01-05', 'DT1', 'Doc C', 'Desc C', 'Details C');
INSERT INTO "All_Documents" ("Document_ID", "Date_Stored", "Document_Type_Code", "Document_Name", "Document_Description", "Other_Details") VALUES (4, '2023-01-20', 'DT1', 'Doc D', 'Desc D', 'Details D');
INSERT INTO "All_Documents" ("Document_ID", "Date_Stored", "Document_Type_Code", "Document_Name", "Document_Description", "Other_Details") VALUES (5, NULL, 'DT1', 'Doc E', 'Desc E', 'Details E');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT day_number, calendar_date AS date_stored FROM (SELECT LHS.calendar_date AS calendar_date, LHS.day_number AS day_number, RHS.document_id AS document_id, RHS.document_type_code AS document_type_code, RHS.document_name AS document_name, RHS.document_description AS document_description, RHS.other_details AS other_details FROM ref_calendar AS LHS INNER JOIN all_documents AS RHS ON (LHS.calendar_date = RHS.date_stored)) ORDER BY day_number, date_stored NULLS LAST;

/*
Gold Result:
(2, '2023-01-20')
(5, '2023-01-05')
(5, '2023-01-05')
(5, '2023-01-10')
*/

-- Prediction Query
SELECT T2.day_Number, T1.Date_Stored FROM All_documents AS T1 JOIN Ref_calendar AS T2 ON T1.date_stored = T2.calendar_date;

/*
Prediction Result:
(5, '2023-01-10')
(5, '2023-01-05')
(5, '2023-01-05')
(2, '2023-01-20')
*/