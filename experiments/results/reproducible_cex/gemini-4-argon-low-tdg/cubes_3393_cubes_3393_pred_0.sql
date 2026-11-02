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
INSERT INTO "Physician" ("EmployeeID", "Name", "Position", "SSN") VALUES (1, 'Dr. Smith', 'Attending', 1001);
INSERT INTO "Physician" ("EmployeeID", "Name", "Position", "SSN") VALUES (2, 'Dr. Jones', 'Resident', 1002);
INSERT INTO "Physician" ("EmployeeID", "Name", "Position", "SSN") VALUES (3, 'Dr. Brown', 'Specialist', 1003);
INSERT INTO "Nurse" ("EmployeeID", "Name", "Position", "Registered", "SSN") VALUES (10, 'Nurse Joy', 'Head Nurse', 1, 2001);
INSERT INTO "Patient" ("SSN", "PCP", "Name", "Address", "Phone", "InsuranceID") VALUES (101, 1, 'Alice', '101 Main St', '555-0101', 9001);
INSERT INTO "Patient" ("SSN", "PCP", "Name", "Address", "Phone", "InsuranceID") VALUES (102, 2, 'Bob', '102 Oak Ave', '555-0102', 9002);
INSERT INTO "Patient" ("SSN", "PCP", "Name", "Address", "Phone", "InsuranceID") VALUES (103, 1, 'Charlie', '103 Pine Rd', '555-0103', 9003);
INSERT INTO "Patient" ("SSN", "PCP", "Name", "Address", "Phone", "InsuranceID") VALUES (104, 3, 'Diana', '104 Elm St', '555-0104', 9004);
INSERT INTO "Patient" ("SSN", "PCP", "Name", "Address", "Phone", "InsuranceID") VALUES (105, 1, 'Eve', '105 Maple Dr', '555-0105', 9005);
-- Alice (101): 2 appointments with Physician 2 (NOT her PCP), 1 with Physician 1 (her PCP)
INSERT INTO "Appointment" ("AppointmentID", "Physician", "PrepNurse", "Patient", "Start", "End", "ExaminationRoom") VALUES (1, 2, 10, 101, '2023-01-01 09:00:00', '2023-01-01 09:30:00', 'Room A');
INSERT INTO "Appointment" ("AppointmentID", "Physician", "PrepNurse", "Patient", "Start", "End", "ExaminationRoom") VALUES (2, 2, NULL, 101, '2023-01-02 09:00:00', '2023-01-02 09:30:00', 'Room A');
INSERT INTO "Appointment" ("AppointmentID", "Physician", "PrepNurse", "Patient", "Start", "End", "ExaminationRoom") VALUES (3, 1, 10, 101, '2023-01-03 09:00:00', '2023-01-03 09:30:00', 'Room B');
-- Bob (102): 1 appointment with Physician 1, 1 appointment with Physician 2 (Total = 2, but 1 per physician)
INSERT INTO "Appointment" ("AppointmentID", "Physician", "PrepNurse", "Patient", "Start", "End", "ExaminationRoom") VALUES (4, 1, 10, 102, '2023-01-04 10:00:00', '2023-01-04 10:30:00', 'Room A');
INSERT INTO "Appointment" ("AppointmentID", "Physician", "PrepNurse", "Patient", "Start", "End", "ExaminationRoom") VALUES (5, 2, 10, 102, '2023-01-05 10:00:00', '2023-01-05 10:30:00', 'Room B');
-- Charlie (103): 3 appointments with Physician 1
INSERT INTO "Appointment" ("AppointmentID", "Physician", "PrepNurse", "Patient", "Start", "End", "ExaminationRoom") VALUES (6, 1, NULL, 103, '2023-01-06 11:00:00', '2023-01-06 11:30:00', 'Room C');
INSERT INTO "Appointment" ("AppointmentID", "Physician", "PrepNurse", "Patient", "Start", "End", "ExaminationRoom") VALUES (7, 1, 10, 103, '2023-01-07 11:00:00', '2023-01-07 11:30:00', 'Room C');
INSERT INTO "Appointment" ("AppointmentID", "Physician", "PrepNurse", "Patient", "Start", "End", "ExaminationRoom") VALUES (8, 1, 10, 103, '2023-01-08 11:00:00', '2023-01-08 11:30:00', 'Room C');
-- Diana (104): 1 appointment with Physician 3
INSERT INTO "Appointment" ("AppointmentID", "Physician", "PrepNurse", "Patient", "Start", "End", "ExaminationRoom") VALUES (9, 3, 10, 104, '2023-01-09 12:00:00', '2023-01-09 12:30:00', 'Room D');
-- Eve (105): 0 appointments;
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, phone FROM (SELECT LHS.ssn AS ssn, LHS.name AS name, LHS.address AS address, LHS.phone AS phone, LHS.insuranceid AS insuranceid, LHS.pcp AS pcp, RHS.physician AS physician, RHS.n AS n FROM patient AS LHS INNER JOIN (SELECT * FROM (SELECT patient, physician, COUNT(*) AS n FROM appointment GROUP BY patient, physician) WHERE (n <> 1)) AS RHS ON (LHS.ssn = RHS.patient)) ORDER BY name, phone NULLS LAST;

/*
Gold Result:
('Alice', '555-0101')
('Charlie', '555-0103')
*/

-- Prediction Query
SELECT name, phone FROM appointment AS T1 JOIN patient AS T2 ON T1.patient = T2.ssn GROUP BY T1.patient HAVING COUNT(*) > 1;

/*
Prediction Result:
('Alice', '555-0101')
('Bob', '555-0102')
('Charlie', '555-0103')
*/