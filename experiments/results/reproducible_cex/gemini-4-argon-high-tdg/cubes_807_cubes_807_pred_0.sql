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
INSERT INTO Physician (EmployeeID, Name, Position, SSN) VALUES (1, 'Dr. Smith', 'Attending', 9001);
INSERT INTO Physician (EmployeeID, Name, Position, SSN) VALUES (2, 'Dr. Adams', 'Resident', 9002);
INSERT INTO Block (BlockFloor, BlockCode) VALUES (1, 1);
INSERT INTO Block (BlockFloor, BlockCode) VALUES (2, 2);
INSERT INTO Room (RoomNumber, BlockFloor, BlockCode, RoomType, Unavailable) VALUES (110, 1, 1, 'Single', 0);
INSERT INTO Room (RoomNumber, BlockFloor, BlockCode, RoomType, Unavailable) VALUES (111, 1, 1, 'Single', 0);
INSERT INTO Room (RoomNumber, BlockFloor, BlockCode, RoomType, Unavailable) VALUES (112, 2, 2, 'Double', 0);
INSERT INTO Patient (SSN, PCP, Name, Address, Phone, InsuranceID) VALUES (300, 1, 'Alice', '10 First St', '555-0100', 10);
INSERT INTO Patient (SSN, PCP, Name, Address, Phone, InsuranceID) VALUES (100, 2, 'Zack', '20 Second St', '555-0200', 20);
INSERT INTO Patient (SSN, PCP, Name, Address, Phone, InsuranceID) VALUES (50, 1, 'Bob', '30 Third St', '555-0300', 30);
INSERT INTO Patient (SSN, PCP, Name, Address, Phone, InsuranceID) VALUES (200, 2, 'Charlie', '40 Fourth St', '555-0400', 40);
INSERT INTO Patient (SSN, PCP, Name, Address, Phone, InsuranceID) VALUES (400, 1, 'Diana', '50 Fifth St', '555-0500', 50);
INSERT INTO Patient (SSN, PCP, Name, Address, Phone, InsuranceID) VALUES (500, 2, 'Evan', '60 Sixth St', '555-0600', 60);
INSERT INTO Stay (StayID, Room, Patient, StayStart, StayEnd) VALUES (1, 111, 300, '2023-01-01', '2023-01-05');
INSERT INTO Stay (StayID, Room, Patient, StayStart, StayEnd) VALUES (2, 111, 100, '2023-02-01', '2023-02-05');
INSERT INTO Stay (StayID, Room, Patient, StayStart, StayEnd) VALUES (3, 110, 50, '2023-01-10', '2023-01-15');
INSERT INTO Stay (StayID, Room, Patient, StayStart, StayEnd) VALUES (4, 112, 400, '2023-01-20', '2023-01-25');
INSERT INTO Stay (StayID, Room, Patient, StayStart, StayEnd) VALUES (5, NULL, 500, '2023-03-01', '2023-03-05');
INSERT INTO Stay (StayID, Room, Patient, StayStart, StayEnd) VALUES (6, 111, NULL, '2023-04-01', '2023-04-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ssn AS patient FROM (SELECT LHS.ssn AS ssn, LHS.name AS name, LHS.address AS address, LHS.phone AS phone, LHS.insuranceid AS insuranceid, LHS.pcp AS pcp, RHS.stayid AS stayid, RHS.room AS room, RHS.staystart AS staystart, RHS.stayend AS stayend FROM patient AS LHS INNER JOIN (SELECT * FROM stay WHERE (room = 111)) AS RHS ON (LHS.ssn = RHS.patient)) ORDER BY patient;

/*
Gold Result:
(100,)
(300,)
*/

-- Prediction Query
SELECT patient FROM stay WHERE room = 111 ORDER BY staystart DESC, stay.stayid NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/