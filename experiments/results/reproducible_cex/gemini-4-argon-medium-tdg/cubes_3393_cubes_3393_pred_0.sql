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
-- Tests basic GROUP BY (patient, physician), count boundaries (n=0, n=1, n=2, n=3),
-- and distinguishes grouping by (patient, physician) vs grouping by (patient) only.
INSERT INTO Physician (EmployeeID, Name, Position, SSN) VALUES (1, 'Dr. Smith', 'Attending', 111);
INSERT INTO Physician (EmployeeID, Name, Position, SSN) VALUES (2, 'Dr. Jones', 'Resident', 222);
INSERT INTO Patient (SSN, PCP, Name, Address, Phone, InsuranceID) VALUES (101, 1, 'Alice', '101 Main St', '555-0101', 1001);
INSERT INTO Patient (SSN, PCP, Name, Address, Phone, InsuranceID) VALUES (102, 1, 'Bob', '102 Main St', '555-0102', 1002);
INSERT INTO Patient (SSN, PCP, Name, Address, Phone, InsuranceID) VALUES (103, 2, 'Charlie', '103 Main St', '555-0103', 1003);
INSERT INTO Patient (SSN, PCP, Name, Address, Phone, InsuranceID) VALUES (104, 2, 'David', '104 Main St', '555-0104', 1004);
INSERT INTO Patient (SSN, PCP, Name, Address, Phone, InsuranceID) VALUES (105, 1, 'Eve', '105 Main St', '555-0105', 1005);
-- Alice: 2 appointments with Dr. Smith (n = 2 -> included)
INSERT INTO Appointment (AppointmentID, Physician, PrepNurse, Patient, Start, End, ExaminationRoom) VALUES (1, 1, NULL, 101, '2023-01-01 09:00:00', '2023-01-01 10:00:00', 'A');
INSERT INTO Appointment (AppointmentID, Physician, PrepNurse, Patient, Start, End, ExaminationRoom) VALUES (2, 1, NULL, 101, '2023-01-02 09:00:00', '2023-01-02 10:00:00', 'A');
-- Bob: 1 appointment with Dr. Smith, 1 appointment with Dr. Jones (n = 1 per physician -> excluded, catches missing physician in GROUP BY)
INSERT INTO Appointment (AppointmentID, Physician, PrepNurse, Patient, Start, End, ExaminationRoom) VALUES (3, 1, NULL, 102, '2023-01-03 09:00:00', '2023-01-03 10:00:00', 'B');
INSERT INTO Appointment (AppointmentID, Physician, PrepNurse, Patient, Start, End, ExaminationRoom) VALUES (4, 2, NULL, 102, '2023-01-04 09:00:00', '2023-01-04 10:00:00', 'B');
-- Charlie: 1 appointment total (n = 1 -> excluded)
INSERT INTO Appointment (AppointmentID, Physician, PrepNurse, Patient, Start, End, ExaminationRoom) VALUES (5, 2, NULL, 103, '2023-01-05 09:00:00', '2023-01-05 10:00:00', 'C');
-- David: 3 appointments with Dr. Jones (n = 3 -> included, catches n = 2 vs n > 1 / n <> 1)
INSERT INTO Appointment (AppointmentID, Physician, PrepNurse, Patient, Start, End, ExaminationRoom) VALUES (6, 2, NULL, 104, '2023-01-06 09:00:00', '2023-01-06 10:00:00', 'D');
INSERT INTO Appointment (AppointmentID, Physician, PrepNurse, Patient, Start, End, ExaminationRoom) VALUES (7, 2, NULL, 104, '2023-01-07 09:00:00', '2023-01-07 10:00:00', 'D');
INSERT INTO Appointment (AppointmentID, Physician, PrepNurse, Patient, Start, End, ExaminationRoom) VALUES (8, 2, NULL, 104, '2023-01-08 09:00:00', '2023-01-08 10:00:00', 'D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, phone FROM (SELECT LHS.ssn AS ssn, LHS.name AS name, LHS.address AS address, LHS.phone AS phone, LHS.insuranceid AS insuranceid, LHS.pcp AS pcp, RHS.physician AS physician, RHS.n AS n FROM patient AS LHS INNER JOIN (SELECT * FROM (SELECT patient, physician, COUNT(*) AS n FROM appointment GROUP BY patient, physician) WHERE (n <> 1)) AS RHS ON (LHS.ssn = RHS.patient)) ORDER BY name, phone NULLS LAST;

/*
Gold Result:
('Alice', '555-0101')
('David', '555-0104')
*/

-- Prediction Query
SELECT name, phone FROM appointment AS T1 JOIN patient AS T2 ON T1.patient = T2.ssn GROUP BY T1.patient HAVING COUNT(*) > 1;

/*
Prediction Result:
('Alice', '555-0101')
('Bob', '555-0102')
('David', '555-0104')
*/