-- Schema DDL
CREATE TABLE "Ref_Address_Types" ("address_type_code" TEXT(15) PRIMARY KEY, "address_type_description" TEXT(80));

CREATE TABLE "Ref_Detention_Type" ("detention_type_code" TEXT(10) PRIMARY KEY, "detention_type_description" TEXT(80));

CREATE TABLE "Ref_Incident_Type" ("incident_type_code" TEXT(10) PRIMARY KEY, "incident_type_description" TEXT(80));

CREATE TABLE "Students" ("student_id" INTEGER PRIMARY KEY, "address_id" INTEGER, "first_name" TEXT(80), "middle_name" TEXT(40), "last_name" TEXT(40), "cell_mobile_number" TEXT(40), "email_address" TEXT(40), "date_first_rental" DATETIME, "date_left_university" DATETIME, "other_student_details" TEXT(255), FOREIGN KEY ("address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Assessment_Notes" ("teacher_id" INTEGER, "student_id" INTEGER, "notes_id" INTEGER, "date_of_notes" DATETIME, "text_of_notes" TEXT(255), "other_details" TEXT(255), FOREIGN KEY ("teacher_id") REFERENCES "Teachers" ("teacher_id"), FOREIGN KEY ("student_id") REFERENCES "Students" ("student_id"));

CREATE TABLE "Behavior_Incident" ("incident_id" INTEGER PRIMARY KEY, "student_id" INTEGER, "incident_type_code" TEXT(10), "date_incident_start" DATETIME, "date_incident_end" DATETIME, "incident_summary" TEXT(255), "recommendations" TEXT(255), "other_details" TEXT(255), FOREIGN KEY ("student_id") REFERENCES "Students" ("student_id"), FOREIGN KEY ("incident_type_code") REFERENCES "Ref_Incident_Type" ("incident_type_code"));

CREATE TABLE "Detention" ("detention_id" INTEGER PRIMARY KEY, "teacher_id" INTEGER, "detention_type_code" TEXT(10), "datetime_detention_start" DATETIME, "datetime_detention_end" DATETIME, "detention_summary" TEXT(255), "other_details" TEXT(255), FOREIGN KEY ("teacher_id") REFERENCES "Teachers" ("teacher_id"), FOREIGN KEY ("detention_type_code") REFERENCES "Ref_Detention_Type" ("detention_type_code"));

CREATE TABLE "Student_Addresses" ("student_id" INTEGER, "address_id" INTEGER, "date_address_from" DATETIME, "date_address_to" DATETIME, "monthly_rental" REAL(19, 4), "other_details" TEXT(255), FOREIGN KEY ("student_id") REFERENCES "Students" ("student_id"), FOREIGN KEY ("address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Students_in_Detention" ("student_id" INTEGER, "detention_id" INTEGER, "incident_id" INTEGER, FOREIGN KEY ("student_id") REFERENCES "Students" ("student_id"), FOREIGN KEY ("detention_id") REFERENCES "Detention" ("detention_id"), FOREIGN KEY ("incident_id") REFERENCES "Behavior_Incident" ("incident_id"));

CREATE TABLE "Addresses" ("address_id" INTEGER PRIMARY KEY, "line_1" TEXT(120), "line_2" TEXT(120), "line_3" TEXT(120), "city" TEXT(80), "zip_postcode" INTEGER, "state_province_county" TEXT(50), "country" TEXT(50), "other_address_details" TEXT(255));

CREATE TABLE "Teachers" ("teacher_id" INTEGER PRIMARY KEY, "address_id" INTEGER, "first_name" TEXT(80), "middle_name" TEXT(80), "last_name" TEXT(80), "gender" INTEGER, "cell_mobile_number" TEXT(40), "email_address" TEXT(40), "other_details" TEXT(255));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Ref_Detention_Type (detention_type_code, detention_type_description) VALUES ('STD', 'Standard Detention');
INSERT INTO Teachers (teacher_id, address_id, first_name, middle_name, last_name, gender) VALUES (1, 1, 'John', 'A', 'Smith', 0);
INSERT INTO Teachers (teacher_id, address_id, first_name, middle_name, last_name, gender) VALUES (2, 1, 'Sarah', 'B', 'Smith', 1);
INSERT INTO Teachers (teacher_id, address_id, first_name, middle_name, last_name, gender) VALUES (3, 1, 'Michael', 'C', 'Johnson', 0);
INSERT INTO Teachers (teacher_id, address_id, first_name, middle_name, last_name, gender) VALUES (4, 1, 'Emily', 'D', 'Johnson', 1);
INSERT INTO Teachers (teacher_id, address_id, first_name, middle_name, last_name, gender) VALUES (5, 1, 'David', 'E', 'Williams', 0);
INSERT INTO Teachers (teacher_id, address_id, first_name, middle_name, last_name, gender) VALUES (6, 1, 'Laura', 'F', 'Williams', 1);
INSERT INTO Detention (detention_id, teacher_id, detention_type_code, datetime_detention_start, datetime_detention_end, detention_summary) VALUES (1, 2, 'STD', '2023-06-01 15:00:00', '2023-06-01 16:00:00', 'Tardy');
INSERT INTO Detention (detention_id, teacher_id, detention_type_code, datetime_detention_start, datetime_detention_end, detention_summary) VALUES (2, 5, 'STD', '2023-06-02 15:00:00', '2023-06-02 16:00:00', 'Skipping');
INSERT INTO Detention (detention_id, teacher_id, detention_type_code, datetime_detention_start, datetime_detention_end, detention_summary) VALUES (3, 6, 'STD', '2023-06-03 15:00:00', '2023-06-03 16:00:00', 'Talking');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT last_name FROM (SELECT * FROM teachers AS LHS WHERE NOT EXISTS(SELECT 1 FROM detention AS RHS WHERE (LHS.teacher_id = RHS.teacher_id))) ORDER BY last_name;

/*
Gold Result:
('Johnson',)
('Smith',)
*/

-- Prediction Query
SELECT last_name FROM Teachers EXCEPT SELECT T1.last_name FROM Teachers AS T1 JOIN Detention AS T2 ON T1.teacher_id = T2.teacher_id;

/*
Prediction Result:
('Johnson',)
*/