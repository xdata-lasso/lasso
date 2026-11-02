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
-- Inserting into table: block --
INSERT INTO "block" ("blockfloor", "blockcode") VALUES (1, 1);

INSERT INTO "block" ("blockfloor", "blockcode") VALUES (5, -2147483647);

INSERT INTO "block" ("blockfloor", "blockcode") VALUES (-2147483646, 5);

INSERT INTO "block" ("blockfloor", "blockcode") VALUES (-2147483645, 2);

INSERT INTO "block" ("blockfloor", "blockcode") VALUES (2, -2147483644);

INSERT INTO "block" ("blockfloor", "blockcode") VALUES (-2147483643, 3);

INSERT INTO "block" ("blockfloor", "blockcode") VALUES (3, -2147483642);

INSERT INTO "block" ("blockfloor", "blockcode") VALUES (-2147483641, 4);

INSERT INTO "block" ("blockfloor", "blockcode") VALUES (4, -2147483640);

INSERT INTO "block" ("blockfloor", "blockcode") VALUES (-2147483639, 6);

INSERT INTO "block" ("blockfloor", "blockcode") VALUES (6, -2147483638);

INSERT INTO "block" ("blockfloor", "blockcode") VALUES (-2147483637, 7);

INSERT INTO "block" ("blockfloor", "blockcode") VALUES (7, -2147483636);

INSERT INTO "block" ("blockfloor", "blockcode") VALUES (-2147483635, 8);

INSERT INTO "block" ("blockfloor", "blockcode") VALUES (8, -2147483634);

-- Inserting into table: room --
INSERT INTO "room" ("roomnumber", "blockfloor", "blockcode", "roomtype", "unavailable") VALUES (-2147483648, 1, 1, 'roo_94bb39', -55602865);

INSERT INTO "room" ("roomnumber", "blockfloor", "blockcode", "roomtype", "unavailable") VALUES (-2147483647, 5, 1, 'roo_94bb39', -59984348);

INSERT INTO "room" ("roomnumber", "blockfloor", "blockcode", "roomtype", "unavailable") VALUES (-2147483646, 1, 5, 'roo_94bb39', -664303813);

INSERT INTO "room" ("roomnumber", "blockfloor", "blockcode", "roomtype", "unavailable") VALUES (-2147483645, 5, 1, 'roo_94bb39', -1022641847);

INSERT INTO "room" ("roomnumber", "blockfloor", "blockcode", "roomtype", "unavailable") VALUES (-2147483644, 1, 5, 'roo_94bb39', -1726781632);

INSERT INTO "room" ("roomnumber", "blockfloor", "blockcode", "roomtype", "unavailable") VALUES (-2147483643, 5, 1, 'roo_94bb39', 247012447);

INSERT INTO "room" ("roomnumber", "blockfloor", "blockcode", "roomtype", "unavailable") VALUES (-2147483642, 1, 5, 'roo_94bb39', -1980249628);

INSERT INTO "room" ("roomnumber", "blockfloor", "blockcode", "roomtype", "unavailable") VALUES (2, 1, 1, 'roo_94bb39', -734455130);

INSERT INTO "room" ("roomnumber", "blockfloor", "blockcode", "roomtype", "unavailable") VALUES (3, 1, 1, 'roo_94bb39', 1744686505);

INSERT INTO "room" ("roomnumber", "blockfloor", "blockcode", "roomtype", "unavailable") VALUES (-2147483639, 1, 1, 'roo_94bb39', -1633151678);

INSERT INTO "room" ("roomnumber", "blockfloor", "blockcode", "roomtype", "unavailable") VALUES (4, 2, 1, 'roo_94bb39', -55602865);

INSERT INTO "room" ("roomnumber", "blockfloor", "blockcode", "roomtype", "unavailable") VALUES (5, 3, 1, 'roo_94bb39', -59984348);

INSERT INTO "room" ("roomnumber", "blockfloor", "blockcode", "roomtype", "unavailable") VALUES (6, 4, 1, 'roo_94bb39', -664303813);

INSERT INTO "room" ("roomnumber", "blockfloor", "blockcode", "roomtype", "unavailable") VALUES (7, 6, 1, 'roo_94bb39', -1022641847);

INSERT INTO "room" ("roomnumber", "blockfloor", "blockcode", "roomtype", "unavailable") VALUES (8, 7, 1, 'roo_94bb39', -1726781632);

INSERT INTO "room" ("roomnumber", "blockfloor", "blockcode", "roomtype", "unavailable") VALUES (9, 8, 1, 'roo_94bb39', 247012447);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n AS count___, blockcode FROM (SELECT LHS.blockfloor AS blockfloor, LHS.blockcode AS blockcode, LHS.roomnumber AS roomnumber, LHS.roomtype AS roomtype, LHS.unavailable AS unavailable, RHS.n AS n FROM (SELECT LHS.blockfloor AS blockfloor, LHS.blockcode AS blockcode, RHS.roomnumber AS roomnumber, RHS.roomtype AS roomtype, RHS.unavailable AS unavailable FROM block AS LHS INNER JOIN room AS RHS ON (LHS.blockfloor = RHS.blockfloor AND LHS.blockcode = RHS.blockcode)) AS LHS CROSS JOIN (SELECT COUNT(*) AS n FROM block) AS RHS) ORDER BY count___, blockcode NULLS LAST;

/*
Gold Result:
(15, 1)
*/

-- Prediction Query
SELECT COUNT(*), T1.blockcode FROM BLOCK AS T1 JOIN room AS T2 ON T1.blockfloor = T2.blockfloor AND T1.blockcode = T2.blockcode GROUP BY T1.blockcode;

/*
Prediction Result:
(4, 1)
*/