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
INSERT INTO "roles" ("role_code", "role_name", "role_description") VALUES ('Museum/gallery conservator', 'Designer, textile', 'Geologist, engineering');
INSERT INTO "roles" ("role_code", "role_name", "role_description") VALUES ('Health physicist', 'Metallurgist', 'Building surveyor');
INSERT INTO "roles" ("role_code", "role_name", "role_description") VALUES ('Professor Emeritus', 'Marine scientist', 'Transport planner');
INSERT INTO "roles" ("role_code", "role_name", "role_description") VALUES ('Medical sales representative', 'Engineer, manufacturing systems', 'Dramatherapist');
INSERT INTO "roles" ("role_code", "role_name", "role_description") VALUES ('Tax adviser', 'Occupational hygienist', 'Corporate treasurer');
INSERT INTO "roles" ("role_code", "role_name", "role_description") VALUES ('International aid/development worker', 'Proofreader', 'Fine artist');
INSERT INTO "roles" ("role_code", "role_name", "role_description") VALUES ('Engineer, petroleum', 'Customer service manager', 'Surveyor, mining');
INSERT INTO "employees" ("employee_id", "role_code", "employee_name", "gender_mfu", "date_of_birth", "other_details") VALUES (1010, 'Museum/gallery conservator', 'Danielle Ford', 'institution', '1978-09-09', 'white');
INSERT INTO "employees" ("employee_id", "role_code", "employee_name", "gender_mfu", "date_of_birth", "other_details") VALUES (1011, 'Museum/gallery conservator', 'Timothy Watts', 'executive', '1978-09-10', 'white');
INSERT INTO "employees" ("employee_id", "role_code", "employee_name", "gender_mfu", "date_of_birth", "other_details") VALUES (1012, 'Museum/gallery conservator', 'Frederick Tate', 'attorney', '1978-09-11', 'white');
INSERT INTO "employees" ("employee_id", "role_code", "employee_name", "gender_mfu", "date_of_birth", "other_details") VALUES (1013, 'Museum/gallery conservator', 'Rodney Trujillo', 'development', '1978-09-12', 'white');
INSERT INTO "employees" ("employee_id", "role_code", "employee_name", "gender_mfu", "date_of_birth", "other_details") VALUES (1014, 'Museum/gallery conservator', 'Nicole Patterson', 'response', '1982-02-13', 'yes');
INSERT INTO "employees" ("employee_id", "role_code", "employee_name", "gender_mfu", "date_of_birth", "other_details") VALUES (1015, 'Museum/gallery conservator', 'Heidi Osborn', 'knowledge', '1982-02-14', 'yes');
INSERT INTO "employees" ("employee_id", "role_code", "employee_name", "gender_mfu", "date_of_birth", "other_details") VALUES (1016, 'Museum/gallery conservator', 'Johnny Campos', 'pick', '1982-02-15', 'yes');
INSERT INTO "employees" ("employee_id", "role_code", "employee_name", "gender_mfu", "date_of_birth", "other_details") VALUES (1017, 'Museum/gallery conservator', 'Brittany Moore', 'attack', '1982-02-16', 'yes');
INSERT INTO "employees" ("employee_id", "role_code", "employee_name", "gender_mfu", "date_of_birth", "other_details") VALUES (1018, 'Museum/gallery conservator', 'Brittany Moore', 'attack', '1982-02-16', 'yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT role_code FROM (SELECT other_details, role_code, COUNT(*) AS n FROM employees GROUP BY other_details, role_code) WHERE (n > 3) ORDER BY role_code;

/*
Gold Result:
('Museum/gallery conservator',)
('Museum/gallery conservator',)
*/

-- Prediction Query
SELECT role_code FROM Employees GROUP BY role_code HAVING COUNT(*) >= 3;

/*
Prediction Result:
('Museum/gallery conservator',)
*/