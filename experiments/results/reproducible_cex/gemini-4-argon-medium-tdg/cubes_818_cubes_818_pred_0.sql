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
-- 1. Boundary conditions for room > 112 (room = 112 vs room = 113)
-- 2. Boundary conditions for room <= patient (room = patient vs room > patient)
-- 3. Logical OR vs AND (cases where only left is true, only right is true, both are true, both are false)
-- 4. GROUP BY (patient, room) vs GROUP BY patient or GROUP BY room alone
-- 5. DISTINCT on output count n
-- 6. ORDER BY count_patient_ ASC vs DESC
INSERT INTO "Physician" ("EmployeeID", "Name", "Position", "SSN") VALUES (1, 'Dr. Smith', 'Staff', 111111);
INSERT INTO "Patient" ("SSN", "PCP", "Name", "Address", "Phone", "InsuranceID") VALUES (50, 1, 'Pat A', 'Addr 1', '555-0001', 1001);
INSERT INTO "Patient" ("SSN", "PCP", "Name", "Address", "Phone", "InsuranceID") VALUES (100, 1, 'Pat B', 'Addr 2', '555-0002', 1002);
INSERT INTO "Patient" ("SSN", "PCP", "Name", "Address", "Phone", "InsuranceID") VALUES (112, 1, 'Pat C', 'Addr 3', '555-0003', 1003);
INSERT INTO "Patient" ("SSN", "PCP", "Name", "Address", "Phone", "InsuranceID") VALUES (200, 1, 'Pat D', 'Addr 4', '555-0004', 1004);
INSERT INTO "Block" ("BlockFloor", "BlockCode") VALUES (1, 1);
INSERT INTO "Room" ("RoomNumber", "BlockFloor", "BlockCode", "RoomType", "Unavailable") VALUES (100, 1, 1, 'Single', 0);
INSERT INTO "Room" ("RoomNumber", "BlockFloor", "BlockCode", "RoomType", "Unavailable") VALUES (105, 1, 1, 'Single', 0);
INSERT INTO "Room" ("RoomNumber", "BlockFloor", "BlockCode", "RoomType", "Unavailable") VALUES (112, 1, 1, 'Single', 0);
INSERT INTO "Room" ("RoomNumber", "BlockFloor", "BlockCode", "RoomType", "Unavailable") VALUES (113, 1, 1, 'Single', 0);
INSERT INTO "Room" ("RoomNumber", "BlockFloor", "BlockCode", "RoomType", "Unavailable") VALUES (150, 1, 1, 'Single', 0);
-- Group 1: (patient=50, room=112) -> room > 112 (False), room <= patient (False). Excluded. Count = 4.
INSERT INTO "Stay" ("StayID", "Room", "Patient", "StayStart", "StayEnd") VALUES (1, 112, 50, '2023-01-01', '2023-01-02');
INSERT INTO "Stay" ("StayID", "Room", "Patient", "StayStart", "StayEnd") VALUES (2, 112, 50, '2023-01-03', '2023-01-04');
INSERT INTO "Stay" ("StayID", "Room", "Patient", "StayStart", "StayEnd") VALUES (3, 112, 50, '2023-01-05', '2023-01-06');
INSERT INTO "Stay" ("StayID", "Room", "Patient", "StayStart", "StayEnd") VALUES (4, 112, 50, '2023-01-07', '2023-01-08');
-- Group 2: (patient=50, room=113) -> room > 112 (True), room <= patient (False). Included. Count = 3.
INSERT INTO "Stay" ("StayID", "Room", "Patient", "StayStart", "StayEnd") VALUES (5, 113, 50, '2023-02-01', '2023-02-02');
INSERT INTO "Stay" ("StayID", "Room", "Patient", "StayStart", "StayEnd") VALUES (6, 113, 50, '2023-02-03', '2023-02-04');
INSERT INTO "Stay" ("StayID", "Room", "Patient", "StayStart", "StayEnd") VALUES (7, 113, 50, '2023-02-05', '2023-02-06');
-- Group 3: (patient=100, room=100) -> room > 112 (False), room <= patient (True, equality boundary). Included. Count = 2.
INSERT INTO "Stay" ("StayID", "Room", "Patient", "StayStart", "StayEnd") VALUES (8, 100, 100, '2023-03-01', '2023-03-02');
INSERT INTO "Stay" ("StayID", "Room", "Patient", "StayStart", "StayEnd") VALUES (9, 100, 100, '2023-03-03', '2023-03-04');
-- Group 4: (patient=200, room=105) -> room > 112 (False), room <= patient (True, strict <). Included. Count = 1.
INSERT INTO "Stay" ("StayID", "Room", "Patient", "StayStart", "StayEnd") VALUES (10, 105, 200, '2023-04-01', '2023-04-02');
-- Group 5: (patient=200, room=150) -> room > 112 (True), room <= patient (True). Included. Count = 1 (Tests DISTINCT with Group 4).
INSERT INTO "Stay" ("StayID", "Room", "Patient", "StayStart", "StayEnd") VALUES (11, 150, 200, '2023-05-01', '2023-05-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n AS count_patient_ FROM (SELECT patient, room, COUNT(*) AS n FROM stay GROUP BY patient, room) WHERE (room > 112 OR room <= patient) ORDER BY count_patient_;

/*
Gold Result:
(1,)
(2,)
(3,)
*/

-- Prediction Query
SELECT COUNT(patient) FROM stay WHERE room = 112;

/*
Prediction Result:
(4,)
*/