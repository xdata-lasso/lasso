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
INSERT INTO Physician (EmployeeID, Name, Position, SSN) VALUES (1, 'Dr. Unmatched Left', 'Intern', 10001);
INSERT INTO Physician (EmployeeID, Name, Position, SSN) VALUES (2, 'Dr. Wrong Order', 'Attending', 10002);
INSERT INTO Physician (EmployeeID, Name, Position, SSN) VALUES (3, 'Dr. Gold Winner', 'Surgical Attending', 10003);
INSERT INTO Physician (EmployeeID, Name, Position, SSN) VALUES (4, 'Dr. Unused', 'Chief', 10004);
INSERT INTO Nurse (EmployeeID, Name, Position, Registered, SSN) VALUES (101, 'Nurse One', 'Head Nurse', 1, 90001);
INSERT INTO Patient (SSN, PCP, Name, Address, Phone, InsuranceID) VALUES (20001, 1, 'Patient Alpha', '10 Main St', '555-0101', 50001);
INSERT INTO Patient (SSN, PCP, Name, Address, Phone, InsuranceID) VALUES (20002, 2, 'Patient Beta', '20 Main St', '555-0102', 50002);
INSERT INTO Medication (Code, Name, Brand, Description) VALUES (1, 'Med One', 'BrandA', 'DescA');
INSERT INTO Medication (Code, Name, Brand, Description) VALUES (2, 'Med Two', 'BrandB', 'DescB');
INSERT INTO Medication (Code, Name, Brand, Description) VALUES (3, 'Med Three', 'BrandC', 'DescC');
INSERT INTO Appointment (AppointmentID, Physician, PrepNurse, Patient, Start, End, ExaminationRoom) VALUES (501, 3, 101, 20001, '2023-01-01 09:00:00', '2023-01-01 10:00:00', 'Room A');
INSERT INTO Appointment (AppointmentID, Physician, PrepNurse, Patient, Start, End, ExaminationRoom) VALUES (502, 1, 101, 20002, '2023-06-01 09:00:00', '2023-06-01 10:00:00', 'Room B');
INSERT INTO Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) VALUES (3, 20001, 2, '2023-01-02 10:00:00', 501, '05mg');
INSERT INTO Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) VALUES (1, 20002, 3, '2023-06-02 10:00:00', 502, '10mg');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM (SELECT employeeid, name, POSITION, ssn, physician, patient, date, appointment, dose, employeeid AS medication FROM (SELECT LHS.employeeid AS employeeid, LHS.name AS name, LHS.position AS POSITION, LHS.ssn AS ssn, RHS.physician AS physician, RHS.patient AS patient, RHS.date AS date, RHS.appointment AS appointment, RHS.dose AS dose FROM physician AS LHS INNER JOIN prescribes AS RHS ON (LHS.employeeid = RHS.medication))) ORDER BY physician) LIMIT 1);

/*
Gold Result:
('Dr. Gold Winner',)
*/

-- Prediction Query
SELECT T1.name FROM physician AS T1 JOIN prescribes AS T2 ON T1.employeeid = T2.physician ORDER BY T2.dose DESC, T1.employeeid NULLS LAST, T2.physician NULLS LAST, T2.patient NULLS LAST, T2.medication NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Prediction Result:
('Dr. Unmatched Left',)
*/