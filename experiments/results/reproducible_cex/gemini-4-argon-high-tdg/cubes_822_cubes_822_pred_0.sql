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
INSERT INTO Medication (Code, Name, Brand, Description) VALUES (1, 'Prozac', 'Eli Lilly', 'Antidepressant');
INSERT INTO Medication (Code, Name, Brand, Description) VALUES (2, 'Advil', 'Pfizer', 'Pain reliever');
INSERT INTO Medication (Code, Name, Brand, Description) VALUES (3, 'Zoloft', 'AstraZeneca', 'SSRI');
INSERT INTO Medication (Code, Name, Brand, Description) VALUES (4, 'Advil', 'Generic', 'Ibuprofen tablet');
INSERT INTO Procedures (Code, Name, Cost) VALUES (1, 'Rhinoplasty', 1500.0);
INSERT INTO Procedures (Code, Name, Cost) VALUES (2, 'Appendectomy', 3200.0);
INSERT INTO Physician (EmployeeID, Name, Position, SSN) VALUES (101, 'Dr. Alice Smith', 'Staff Internist', 111111111);
INSERT INTO Department (DepartmentID, Head, Name) VALUES (10, 101, 'General Medicine');
INSERT INTO Nurse (EmployeeID, Name, Position, Registered, SSN) VALUES (201, 'Carla Espinosa', 'Head Nurse', 1, 222222222);
INSERT INTO Patient (SSN, PCP, Name, Address, Phone, InsuranceID) VALUES (301, 101, 'John Doe', '123 Main St', '555-0100', 9001);
INSERT INTO Appointment (AppointmentID, Physician, PrepNurse, Patient, Start, End, ExaminationRoom) VALUES (401, 101, 201, 301, '2023-01-10 09:00:00', '2023-01-10 09:30:00', 'Room A');
INSERT INTO Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) VALUES (101, 301, 1, '2023-01-10 09:30:00', 401, '20mg');
INSERT INTO Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) VALUES (101, 301, 1, '2023-02-10 09:30:00', NULL, '40mg');
INSERT INTO Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) VALUES (101, 301, 2, '2023-01-10 09:30:00', 401, '200mg');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM medication ORDER BY name, medication.code NULLS LAST;

/*
Gold Result:
('Advil',)
('Advil',)
('Prozac',)
('Zoloft',)
*/

-- Prediction Query
SELECT DISTINCT name FROM medication ORDER BY name;

/*
Prediction Result:
('Advil',)
('Prozac',)
('Zoloft',)
*/