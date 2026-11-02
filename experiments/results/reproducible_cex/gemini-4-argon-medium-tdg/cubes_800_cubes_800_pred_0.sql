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
-- Tests:
-- 1. INNER JOIN vs LEFT/FULL JOIN (Medication 100 has no prescriptions and should be excluded).
-- 2. DISTINCT vs ALL (Medication 200 has prescriptions in multiple appointments and also NULL appointments, generating multiple rows in the inner subquery that must be deduplicated).
-- 3. NULL handling in GROUP BY and HAVING/WHERE (Medication 200 and 300 have NULL appointments).
-- 4. ORDER BY code ASC, name NULLS LAST (Codes inserted out of order; Medication 300 has NULL name).
-- 5. Confounding columns (Medication Name differs from Brand, Description, and Procedures.Name).
INSERT INTO "Physician" ("EmployeeID", "Name", "Position", "SSN") VALUES (1, 'Dr. Alice', 'Attending', 111111111);
INSERT INTO "Physician" ("EmployeeID", "Name", "Position", "SSN") VALUES (2, 'Dr. Bob', 'Resident', 222222222);
INSERT INTO "Patient" ("SSN", "PCP", "Name", "Address", "Phone", "InsuranceID") VALUES (1001, 1, 'Patient Zero', '123 Main St', '555-0100', 9001);
INSERT INTO "Patient" ("SSN", "PCP", "Name", "Address", "Phone", "InsuranceID") VALUES (1002, 2, 'Patient One', '456 Oak St', '555-0101', 9002);
INSERT INTO "Nurse" ("EmployeeID", "Name", "Position", "Registered", "SSN") VALUES (10, 'Nurse Carla', 'Head Nurse', 1, 333333333);
INSERT INTO "Appointment" ("AppointmentID", "Physician", "PrepNurse", "Patient", "Start", "End", "ExaminationRoom") VALUES (501, 1, 10, 1001, '2023-01-10 09:00:00', '2023-01-10 10:00:00', 'Room A');
INSERT INTO "Appointment" ("AppointmentID", "Physician", "PrepNurse", "Patient", "Start", "End", "ExaminationRoom") VALUES (502, 2, 10, 1002, '2023-01-11 11:00:00', '2023-01-11 12:00:00', 'Room B');
INSERT INTO "Medication" ("Code", "Name", "Brand", "Description") VALUES (300, NULL, 'BrandX', 'DescX');
INSERT INTO "Medication" ("Code", "Name", "Brand", "Description") VALUES (100, 'UnprescribedMed', 'BrandY', 'DescY');
INSERT INTO "Medication" ("Code", "Name", "Brand", "Description") VALUES (200, 'Amoxicillin', 'Amoxil', 'Antibiotic');
INSERT INTO "Medication" ("Code", "Name", "Brand", "Description") VALUES (50, 'Zyrtec', 'CetirizineBrand', 'Allergy');
INSERT INTO "Procedures" ("Code", "Name", "Cost") VALUES (200, 'WrongTableProcedure', 1500.0);
INSERT INTO "Procedures" ("Code", "Name", "Cost") VALUES (50, 'AnotherProcedure', 500.0);
INSERT INTO "Prescribes" ("Physician", "Patient", "Medication", "Date", "Appointment", "Dose") VALUES (1, 1001, 200, '2023-01-10 09:30:00', 501, '500mg');
INSERT INTO "Prescribes" ("Physician", "Patient", "Medication", "Date", "Appointment", "Dose") VALUES (2, 1001, 200, '2023-01-10 09:45:00', 501, '250mg');
INSERT INTO "Prescribes" ("Physician", "Patient", "Medication", "Date", "Appointment", "Dose") VALUES (1, 1002, 200, '2023-01-11 11:30:00', 502, '500mg');
INSERT INTO "Prescribes" ("Physician", "Patient", "Medication", "Date", "Appointment", "Dose") VALUES (1, 1001, 200, '2023-01-12 08:00:00', NULL, '100mg');
INSERT INTO "Prescribes" ("Physician", "Patient", "Medication", "Date", "Appointment", "Dose") VALUES (2, 1002, 300, '2023-01-15 14:00:00', NULL, '10mg');
INSERT INTO "Prescribes" ("Physician", "Patient", "Medication", "Date", "Appointment", "Dose") VALUES (1, 1001, 50, '2023-01-10 09:50:00', 501, '5mg');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT code AS count___, name FROM (SELECT LHS.code AS code, LHS.name AS name, LHS.brand AS brand, LHS.description AS description, RHS.appointment AS appointment, RHS.n AS n FROM medication AS LHS INNER JOIN (SELECT appointment, medication, COUNT(*) AS n FROM prescribes GROUP BY appointment, medication) AS RHS ON (LHS.code = RHS.medication)) ORDER BY count___, name NULLS LAST;

/*
Gold Result:
(50, 'Zyrtec')
(200, 'Amoxicillin')
(300, None)
*/

-- Prediction Query
SELECT COUNT(*), T1.name FROM medication AS T1 JOIN prescribes AS T2 ON T1.code = T2.medication GROUP BY T1.brand;

/*
Prediction Result:
(4, 'Amoxicillin')
(1, None)
(1, 'Zyrtec')
*/