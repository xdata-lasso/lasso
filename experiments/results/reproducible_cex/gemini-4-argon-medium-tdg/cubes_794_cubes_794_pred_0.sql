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
-- DATASET 2
-- Tests DISTINCT vs ALL (duplicate names and multiple primary affiliations), ORDER BY direction, and tie-breaking.
INSERT INTO "Physician" ("EmployeeID", "Name", "Position", "SSN") VALUES (101, 'Dr. Smith', 'Surgeon', 55501);
INSERT INTO "Physician" ("EmployeeID", "Name", "Position", "SSN") VALUES (102, 'Dr. Smith', 'Pediatrician', 55502);
INSERT INTO "Physician" ("EmployeeID", "Name", "Position", "SSN") VALUES (103, 'Dr. Adams', 'Physician', 55503);
INSERT INTO "Department" ("DepartmentID", "Head", "Name") VALUES (1, 101, 'Surgery');
INSERT INTO "Department" ("DepartmentID", "Head", "Name") VALUES (2, 102, 'Surgery');
INSERT INTO "Department" ("DepartmentID", "Head", "Name") VALUES (3, 103, 'Pediatrics');
INSERT INTO "Department" ("DepartmentID", "Head", "Name") VALUES (4, 103, 'Cardiology');
INSERT INTO "Affiliated_With" ("Physician", "Department", "PrimaryAffiliation") VALUES (101, 1, 1);
INSERT INTO "Affiliated_With" ("Physician", "Department", "PrimaryAffiliation") VALUES (102, 2, 1);
INSERT INTO "Affiliated_With" ("Physician", "Department", "PrimaryAffiliation") VALUES (103, 3, 1);
INSERT INTO "Affiliated_With" ("Physician", "Department", "PrimaryAffiliation") VALUES (103, 4, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS name___1, name_other AS name___2 FROM (SELECT LHS.employeeid AS employeeid, LHS.name AS name, LHS.position AS POSITION, LHS.ssn AS ssn, RHS.departmentid AS departmentid, RHS.name AS name_other, RHS.head AS head, RHS.primaryaffiliation AS primaryaffiliation, RHS.department AS department FROM physician AS LHS INNER JOIN (SELECT * FROM (SELECT departmentid, name, head, physician, primaryaffiliation, departmentid AS department FROM (SELECT LHS.departmentid AS departmentid, LHS.name AS name, LHS.head AS head, RHS.physician AS physician, RHS.primaryaffiliation AS primaryaffiliation FROM department AS LHS INNER JOIN affiliated_with AS RHS ON (LHS.departmentid = RHS.department))) WHERE (primaryaffiliation = 1)) AS RHS ON (LHS.employeeid = RHS.physician)) ORDER BY name___1, name___2 NULLS LAST;

/*
Gold Result:
('Dr. Adams', 'Cardiology')
('Dr. Adams', 'Pediatrics')
('Dr. Smith', 'Surgery')
('Dr. Smith', 'Surgery')
*/

-- Prediction Query
SELECT T1.name, T3.name FROM physician AS T1 JOIN affiliated_with AS T2 ON T1.EmployeeID = T2.physician JOIN department AS T3 ON T2.department = T3.DepartmentID WHERE T2.PrimaryAffiliation = 1;

/*
Prediction Result:
('Dr. Smith', 'Surgery')
('Dr. Smith', 'Surgery')
('Dr. Adams', 'Pediatrics')
('Dr. Adams', 'Cardiology')
*/