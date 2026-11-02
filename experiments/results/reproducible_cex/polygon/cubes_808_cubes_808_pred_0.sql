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
INSERT INTO "Physician" ("employeeid", "name", "position", "ssn") VALUES (25, '1', '1', 1);
INSERT INTO "Physician" ("employeeid", "name", "position", "ssn") VALUES (45, '1', '1', 1);
INSERT INTO "Department" ("departmentid", "head", "name") VALUES (1, 45, NULL);
INSERT INTO "Department" ("departmentid", "head", "name") VALUES (46, 25, NULL);
INSERT INTO "Affiliated_With" ("physician", "department", "primaryaffiliation") VALUES (45, 46, 1);
INSERT INTO "Procedures" ("code", "name", "cost") VALUES (27, '1', 1);
INSERT INTO "Trained_In" ("physician", "treatment", "certificationdate", "certificationexpires") VALUES (45, 27, 1, 1);
INSERT INTO "Trained_In" ("physician", "treatment", "certificationdate", "certificationexpires") VALUES (25, 27, 1, 1);
INSERT INTO "Patient" ("ssn", "pcp", "name", "address", "phone", "insuranceid") VALUES (28, 45, '1', '1', '1', 1);
INSERT INTO "Nurse" ("employeeid", "name", "position", "registered", "ssn") VALUES (30, '1', '1', 1, 1);
INSERT INTO "Appointment" ("appointmentid", "physician", "prepnurse", "patient", "start", "end", "examinationroom") VALUES (31, 25, 30, NULL, 1, 1, '1');
INSERT INTO "Medication" ("code", "name", "brand", "description") VALUES (34, '1', '1', '1');
INSERT INTO "Medication" ("code", "name", "brand", "description") VALUES (33, '1', '1', '1');
INSERT INTO "Block" ("blockfloor", "blockcode") VALUES (22, 23);
INSERT INTO "Room" ("roomnumber", "blockfloor", "blockcode", "roomtype", "unavailable") VALUES (35, 22, 23, '1', 1);
INSERT INTO "On_Call" ("nurse", "blockfloor", "blockcode", "oncallstart", "oncallend") VALUES (30, 22, 23, 1, 1);
INSERT INTO "Stay" ("stayid", "room", "patient", "staystart", "stayend") VALUES (37, 35, 28, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.departmentid AS departmentid, LHS.name AS name, LHS.head AS head, RHS.departmentid AS departmentid_other FROM department AS LHS INNER JOIN (SELECT departmentid, COUNT(DISTINCT departmentid) AS n_distinct FROM department GROUP BY departmentid) AS RHS ON (LHS.departmentid = RHS.n_distinct)) ORDER BY name;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT name FROM department GROUP BY departmentID ORDER BY COUNT(departmentID) DESC, name NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/