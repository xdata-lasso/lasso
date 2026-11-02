-- Schema DDL
CREATE TABLE "Physician" ("EmployeeID" INTEGER PRIMARY KEY, "Name" TEXT(30), "Position" TEXT(30), "SSN" INTEGER);

CREATE TABLE "Department" ("DepartmentID" INTEGER PRIMARY KEY, "Head" INTEGER, "Name" TEXT(30), FOREIGN KEY ("Head") REFERENCES "Physician" ("EmployeeID"));

CREATE TABLE "Affiliated_With" ("Physician" INTEGER, "Department" INTEGER, "PrimaryAffiliation" INTEGER, PRIMARY KEY ("Physician", "Department"), FOREIGN KEY ("Department") REFERENCES "Department" ("DepartmentID"), FOREIGN KEY ("Physician") REFERENCES "Physician" ("EmployeeID"));

CREATE TABLE "Procedures" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(30), "Cost" REAL);

CREATE TABLE "Trained_In" ("Physician" INTEGER, "Treatment" INTEGER, "CertificationDate" DATETIME, "CertificationExpires" DATETIME, PRIMARY KEY ("Physician", "Treatment"), FOREIGN KEY ("Treatment") REFERENCES "Procedures" ("Code"), FOREIGN KEY ("Physician") REFERENCES "Physician" ("EmployeeID"));

CREATE TABLE "Patient" ("SSN" INTEGER PRIMARY KEY, "PCP" INTEGER, "Name" TEXT(30), "Address" TEXT(30), "Phone" TEXT(30), "InsuranceID" INTEGER, FOREIGN KEY ("PCP") REFERENCES "Physician" ("EmployeeID"));

CREATE TABLE "Nurse" ("EmployeeID" INTEGER PRIMARY KEY, "Name" TEXT(30), "Position" TEXT(30), "Registered" INTEGER, "SSN" INTEGER);

CREATE TABLE "Appointment" ("AppointmentID" INTEGER PRIMARY KEY, "Physician" INTEGER, "PrepNurse" INTEGER, "Patient" INTEGER, "Start" DATETIME, "End" DATETIME, "ExaminationRoom" TEXT, FOREIGN KEY ("Physician") REFERENCES "Physician" ("EmployeeID"), FOREIGN KEY ("PrepNurse") REFERENCES "Nurse" ("EmployeeID"), FOREIGN KEY ("Patient") REFERENCES "Patient" ("SSN"));

CREATE TABLE "Medication" ("Code" INTEGER PRIMARY KEY, "Name" TEXT(30), "Brand" TEXT(30), "Description" TEXT(30));

CREATE TABLE "Prescribes" ("Physician" INTEGER, "Patient" INTEGER, "Medication" INTEGER, "Date" DATETIME, "Appointment" INTEGER, "Dose" TEXT(30), PRIMARY KEY ("Physician", "Patient", "Medication", "Date"), FOREIGN KEY ("Appointment") REFERENCES "Appointment" ("AppointmentID"), FOREIGN KEY ("Medication") REFERENCES "Medication" ("Code"), FOREIGN KEY ("Patient") REFERENCES "Patient" ("SSN"), FOREIGN KEY ("Physician") REFERENCES "Physician" ("EmployeeID"));

CREATE TABLE "Block" ("BlockFloor" INTEGER UNIQUE, "BlockCode" INTEGER UNIQUE, PRIMARY KEY ("BlockFloor", "BlockCode"));

CREATE TABLE "Room" ("RoomNumber" INTEGER PRIMARY KEY, "BlockFloor" INTEGER, "BlockCode" INTEGER, "RoomType" TEXT(30), "Unavailable" INTEGER, FOREIGN KEY ("BlockFloor") REFERENCES "Block" ("BlockFloor"), FOREIGN KEY ("BlockCode") REFERENCES "Block" ("BlockCode"));

CREATE TABLE "On_Call" ("Nurse" INTEGER, "BlockFloor" INTEGER, "BlockCode" INTEGER, "OnCallStart" DATETIME, "OnCallEnd" DATETIME, PRIMARY KEY ("Nurse", "BlockFloor", "BlockCode", "OnCallStart", "OnCallEnd"), FOREIGN KEY ("BlockFloor") REFERENCES "Block" ("BlockFloor"), FOREIGN KEY ("BlockCode") REFERENCES "Block" ("BlockCode"), FOREIGN KEY ("Nurse") REFERENCES "Nurse" ("EmployeeID"));

CREATE TABLE "Stay" ("StayID" INTEGER PRIMARY KEY, "Room" INTEGER, "Patient" INTEGER, "StayStart" DATETIME, "StayEnd" DATETIME, FOREIGN KEY ("Room") REFERENCES "Room" ("RoomNumber"), FOREIGN KEY ("Patient") REFERENCES "Patient" ("SSN"));

CREATE TABLE "Undergoes" ("Patient" INTEGER, "Procedures" INTEGER, "Stay" INTEGER, "DateUndergoes" DATETIME, "AssistingNurse" INTEGER, "Physician" INTEGER, PRIMARY KEY ("Patient", "Procedures", "Stay", "DateUndergoes"), FOREIGN KEY ("AssistingNurse") REFERENCES "Nurse" ("EmployeeID"), FOREIGN KEY ("Physician") REFERENCES "Physician" ("EmployeeID"), FOREIGN KEY ("Stay") REFERENCES "Stay" ("StayID"), FOREIGN KEY ("Procedures") REFERENCES "Procedures" ("Code"), FOREIGN KEY ("Patient") REFERENCES "Patient" ("SSN"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Core logic, DISTINCT check, ORDER BY check, and <> condition ("name" <> "name_other")
INSERT INTO "Physician" ("EmployeeID", "Name", "Position", "SSN") VALUES (1, 'Dr. Zelda', 'Attending', 1001);
INSERT INTO "Physician" ("EmployeeID", "Name", "Position", "SSN") VALUES (2, 'Dr. Alpha', 'Intern', 1002);
INSERT INTO "Physician" ("EmployeeID", "Name", "Position", "SSN") VALUES (3, 'Thesisin', 'Surgeon', 1003);
INSERT INTO "Patient" ("SSN", "PCP", "Name", "Address", "Phone", "InsuranceID") VALUES (101, 1, 'Patient One', '123 St', '555-0101', 9001);
INSERT INTO "Patient" ("SSN", "PCP", "Name", "Address", "Phone", "InsuranceID") VALUES (102, 2, 'Patient Two', '124 St', '555-0102', 9002);
INSERT INTO "Medication" ("Code", "Name", "Brand", "Description") VALUES (10, 'Thesisin', 'BrandX', 'DescX');
INSERT INTO "Prescribes" ("Physician", "Patient", "Medication", "Date", "Appointment", "Dose") VALUES (1, 101, 10, '2023-01-01 10:00:00', NULL, '10mg');
INSERT INTO "Prescribes" ("Physician", "Patient", "Medication", "Date", "Appointment", "Dose") VALUES (1, 102, 10, '2023-01-02 10:00:00', NULL, '20mg');
INSERT INTO "Prescribes" ("Physician", "Patient", "Medication", "Date", "Appointment", "Dose") VALUES (2, 101, 10, '2023-01-03 10:00:00', NULL, '15mg');
INSERT INTO "Prescribes" ("Physician", "Patient", "Medication", "Date", "Appointment", "Dose") VALUES (3, 101, 10, '2023-01-04 10:00:00', NULL, '5mg');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "name_other" AS "name" FROM (SELECT "physician", "patient", "medication", "date", "appointment", "dose", "name", "brand", "description", "name_other", "position", "ssn", "physician" AS "employeeid" FROM (SELECT "LHS"."physician" AS "physician", "LHS"."patient" AS "patient", "LHS"."medication" AS "medication", "LHS"."date" AS "date", "LHS"."appointment" AS "appointment", "LHS"."dose" AS "dose", "RHS"."name" AS "name", "RHS"."brand" AS "brand", "RHS"."description" AS "description", "RHS"."name_other" AS "name_other", "RHS"."position" AS "position", "RHS"."ssn" AS "ssn" FROM "prescribes" AS "LHS" INNER JOIN (SELECT * FROM (SELECT * FROM (SELECT "LHS"."code" AS "code", "LHS"."name" AS "name", "LHS"."brand" AS "brand", "LHS"."description" AS "description", "RHS"."employeeid" AS "employeeid", "RHS"."name" AS "name_other", "RHS"."position" AS "position", "RHS"."ssn" AS "ssn" FROM "medication" AS "LHS" CROSS JOIN "physician" AS "RHS") WHERE ("name" <> "name_other")) WHERE ("name" = 'Thesisin')) AS RHS ON (LHS.physician = RHS.employeeid AND LHS.medication = RHS.code))) ORDER BY name;

/*
Gold Result:
('Dr. Alpha',)
('Dr. Zelda',)
*/

-- Prediction Query
SELECT DISTINCT T1.name FROM physician AS T1 JOIN prescribes AS T2 ON T1.employeeid = T2.physician JOIN medication AS T3 ON T3.code = T2.medication WHERE T3.name = 'Thesisin';

/*
Prediction Result:
('Dr. Zelda',)
('Dr. Alpha',)
('Thesisin',)
*/