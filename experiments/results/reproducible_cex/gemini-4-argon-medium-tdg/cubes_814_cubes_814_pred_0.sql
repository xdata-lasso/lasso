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
-- Tests basic inner join, exclusion of physicians with 0 patients (catches LEFT JOIN mutants), and ordering by name vs count.
INSERT INTO "Physician" ("EmployeeID", "Name", "Position", "SSN") VALUES (1, 'Dr. Zeke', 'Staff Internist', 111111111);
INSERT INTO "Physician" ("EmployeeID", "Name", "Position", "SSN") VALUES (2, 'Dr. Alice', 'Attending Physician', 222222222);
INSERT INTO "Physician" ("EmployeeID", "Name", "Position", "SSN") VALUES (3, 'Dr. Bob', 'Surgical Attending Physician', 333333333);
INSERT INTO "Patient" ("SSN", "PCP", "Name", "Address", "Phone", "InsuranceID") VALUES (100000001, 1, 'Patient One', '101 Main St', '555-0101', 1001);
INSERT INTO "Patient" ("SSN", "PCP", "Name", "Address", "Phone", "InsuranceID") VALUES (100000002, 2, 'Patient Two', '102 Main St', '555-0102', 1002);
INSERT INTO "Patient" ("SSN", "PCP", "Name", "Address", "Phone", "InsuranceID") VALUES (100000003, 2, 'Patient Three', '103 Main St', '555-0103', 1003);
INSERT INTO "Patient" ("SSN", "PCP", "Name", "Address", "Phone", "InsuranceID") VALUES (100000004, 2, 'Patient Four', '104 Main St', '555-0104', 1004);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.employeeid AS employeeid, LHS.name AS name, LHS.position AS POSITION, LHS.ssn AS ssn, RHS.n AS n FROM physician AS LHS INNER JOIN (SELECT pcp, COUNT(*) AS n FROM patient GROUP BY pcp) AS RHS ON (LHS.employeeid = RHS.pcp)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Dr. Alice', 3)
('Dr. Zeke', 1)
*/

-- Prediction Query
SELECT T1.name, COUNT(*) FROM physician AS T1 JOIN patient AS T2 ON T1.employeeid = T2.PCP GROUP BY T1.employeeid;

/*
Prediction Result:
('Dr. Zeke', 1)
('Dr. Alice', 3)
*/