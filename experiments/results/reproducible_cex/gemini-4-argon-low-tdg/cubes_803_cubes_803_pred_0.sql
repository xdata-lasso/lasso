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
-- 1. OR vs AND in WHERE clause (blockcode < 1 vs blockcode = blockfloor vs both)
-- 2. Boundary condition: blockcode < 1 vs blockcode <= 1 (using blockcode = 1 with blockfloor = 5)
-- 3. Multiplicity/Duplicates (SELECT vs SELECT DISTINCT)
-- 4. INNER JOIN vs LEFT JOIN (Nurse with no On_Call records)
-- 5. Ordering (ORDER BY nurse ASC vs DESC vs insertion order)
INSERT INTO "Nurse" ("EmployeeID", "Name", "Position", "Registered", "SSN") VALUES (30, 'Cathy', 'Nurse', 1, 1003);
INSERT INTO "Nurse" ("EmployeeID", "Name", "Position", "Registered", "SSN") VALUES (10, 'Alice', 'Head Nurse', 1, 1001);
INSERT INTO "Nurse" ("EmployeeID", "Name", "Position", "Registered", "SSN") VALUES (20, 'Bob', 'Nurse', 0, 1002);
INSERT INTO "Nurse" ("EmployeeID", "Name", "Position", "Registered", "SSN") VALUES (40, 'David', 'Nurse', 1, 1004);
INSERT INTO "Nurse" ("EmployeeID", "Name", "Position", "Registered", "SSN") VALUES (50, 'Eve', 'Nurse', 0, 1005);
INSERT INTO "Block" ("BlockFloor", "BlockCode") VALUES (2, 0);
INSERT INTO "Block" ("BlockFloor", "BlockCode") VALUES (3, 3);
INSERT INTO "Block" ("BlockFloor", "BlockCode") VALUES (-1, -1);
INSERT INTO "Block" ("BlockFloor", "BlockCode") VALUES (5, 1);
INSERT INTO "Block" ("BlockFloor", "BlockCode") VALUES (4, 6);
-- Nurse 30: satisfies only blockcode < 1 (0 < 1, 0 != 2) -> Included
INSERT INTO "On_Call" ("Nurse", "BlockFloor", "BlockCode", "OnCallStart", "OnCallEnd") VALUES (30, 2, 0, '2023-01-01 08:00:00', '2023-01-01 16:00:00');
-- Nurse 10: satisfies only blockcode = blockfloor (3 = 3, 3 >= 1) twice -> Included twice (tests DISTINCT and ORDER BY)
INSERT INTO "On_Call" ("Nurse", "BlockFloor", "BlockCode", "OnCallStart", "OnCallEnd") VALUES (10, 3, 3, '2023-01-01 08:00:00', '2023-01-01 16:00:00');
INSERT INTO "On_Call" ("Nurse", "BlockFloor", "BlockCode", "OnCallStart", "OnCallEnd") VALUES (10, 3, 3, '2023-01-02 08:00:00', '2023-01-02 16:00:00');
-- Nurse 20: satisfies both (-1 < 1 and -1 = -1) -> Included
INSERT INTO "On_Call" ("Nurse", "BlockFloor", "BlockCode", "OnCallStart", "OnCallEnd") VALUES (20, -1, -1, '2023-01-01 08:00:00', '2023-01-01 16:00:00');
-- Nurse 40: boundary failure (blockcode = 1, blockfloor = 5) -> Excluded (catches blockcode <= 1)
INSERT INTO "On_Call" ("Nurse", "BlockFloor", "BlockCode", "OnCallStart", "OnCallEnd") VALUES (40, 5, 1, '2023-01-01 08:00:00', '2023-01-01 16:00:00');
-- Nurse 40: general failure (blockcode = 6, blockfloor = 4) -> Excluded
INSERT INTO "On_Call" ("Nurse", "BlockFloor", "BlockCode", "OnCallStart", "OnCallEnd") VALUES (40, 4, 6, '2023-01-02 08:00:00', '2023-01-02 16:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT employeeid AS nurse FROM (SELECT LHS.employeeid AS employeeid, LHS.name AS name, LHS.position AS POSITION, LHS.registered AS registered, LHS.ssn AS ssn, RHS.blockfloor AS blockfloor, RHS.blockcode AS blockcode, RHS.oncallstart AS oncallstart, RHS.oncallend AS oncallend FROM nurse AS LHS INNER JOIN (SELECT * FROM on_call WHERE (blockcode < 1 OR blockcode = blockfloor)) AS RHS ON (LHS.employeeid = RHS.nurse)) ORDER BY nurse;

/*
Gold Result:
(10,)
(10,)
(20,)
(30,)
*/

-- Prediction Query
SELECT nurse FROM on_call WHERE blockfloor = 1 AND blockcode = 1;

/*
Prediction Result:
*/