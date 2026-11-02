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
-- 1. SELECT DISTINCT vs SELECT ALL (BlockCode 20 has 3 rooms).
-- 2. Total COUNT(*) of Block (4) vs COUNT(*) of joined rooms (5) vs COUNT(*) per blockcode (1, 3, 1, 0).
-- 3. Both join predicates (LHS.blockfloor = RHS.blockfloor AND LHS.blockcode = RHS.blockcode) vs single predicate or OR predicate (Room 105 has floor 1 and code 20, which exist in Block separately but not together).
-- 4. INNER JOIN vs LEFT/RIGHT/FULL OUTER JOIN (Block (4, 40) has no rooms; Room 105 and 106 do not match any single Block on both floor and code).
-- 5. ORDER BY blockcode ASC vs DESC (BlockCodes inserted out of order: 30, 10, 20, 40).
-- 6. Projection of blockcode vs blockfloor (BlockFloor 1, 2, 3, 4 are distinct from BlockCode 10, 20, 30, 40).
-- 7. Unexpected filtering on Room.Unavailable or Room.RoomType (includes Unavailable = 0, 1, NULL and various RoomTypes).
INSERT INTO "Block" ("BlockFloor", "BlockCode") VALUES (3, 30);
INSERT INTO "Block" ("BlockFloor", "BlockCode") VALUES (1, 10);
INSERT INTO "Block" ("BlockFloor", "BlockCode") VALUES (2, 20);
INSERT INTO "Block" ("BlockFloor", "BlockCode") VALUES (4, 40);
INSERT INTO "Room" ("RoomNumber", "BlockFloor", "BlockCode", "RoomType", "Unavailable") VALUES (101, 3, 30, 'Single', 0);
INSERT INTO "Room" ("RoomNumber", "BlockFloor", "BlockCode", "RoomType", "Unavailable") VALUES (102, 2, 20, 'Single', 1);
INSERT INTO "Room" ("RoomNumber", "BlockFloor", "BlockCode", "RoomType", "Unavailable") VALUES (103, 2, 20, 'Double', 0);
INSERT INTO "Room" ("RoomNumber", "BlockFloor", "BlockCode", "RoomType", "Unavailable") VALUES (104, 2, 20, NULL, NULL);
INSERT INTO "Room" ("RoomNumber", "BlockFloor", "BlockCode", "RoomType", "Unavailable") VALUES (105, 1, 20, 'Single', 0);
INSERT INTO "Room" ("RoomNumber", "BlockFloor", "BlockCode", "RoomType", "Unavailable") VALUES (106, NULL, NULL, 'Single', 0);
INSERT INTO "Room" ("RoomNumber", "BlockFloor", "BlockCode", "RoomType", "Unavailable") VALUES (107, 1, 10, 'Double', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n AS count___, blockcode FROM (SELECT LHS.blockfloor AS blockfloor, LHS.blockcode AS blockcode, LHS.roomnumber AS roomnumber, LHS.roomtype AS roomtype, LHS.unavailable AS unavailable, RHS.n AS n FROM (SELECT LHS.blockfloor AS blockfloor, LHS.blockcode AS blockcode, RHS.roomnumber AS roomnumber, RHS.roomtype AS roomtype, RHS.unavailable AS unavailable FROM block AS LHS INNER JOIN room AS RHS ON (LHS.blockfloor = RHS.blockfloor AND LHS.blockcode = RHS.blockcode)) AS LHS CROSS JOIN (SELECT COUNT(*) AS n FROM block) AS RHS) ORDER BY count___, blockcode NULLS LAST;

/*
Gold Result:
(4, 10)
(4, 20)
(4, 30)
*/

-- Prediction Query
SELECT COUNT(*), T1.blockcode FROM BLOCK AS T1 JOIN room AS T2 ON T1.blockfloor = T2.blockfloor AND T1.blockcode = T2.blockcode GROUP BY T1.blockcode;

/*
Prediction Result:
(1, 10)
(3, 20)
(1, 30)
*/