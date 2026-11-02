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
INSERT INTO "block" ("blockfloor", "blockcode") VALUES (1060, 1061);
INSERT INTO "nurse" ("employeeid", "name", "position", "registered", "ssn") VALUES (1062, 'Sherry Decker', 'food', 1063, 1064);
INSERT INTO "physician" ("employeeid", "name", "position", "ssn") VALUES (1065, 'David Bradley', 'bar', 1066);
INSERT INTO "physician" ("employeeid", "name", "position", "ssn") VALUES (1073, NULL, NULL, NULL);
INSERT INTO "procedures" ("code", "name", "cost") VALUES (1065, 'John Jones', 1067.5);
INSERT INTO "procedures" ("code", "name", "cost") VALUES (1074, NULL, NULL);
INSERT INTO "patient" ("ssn", "pcp", "name", "address", "phone", "insuranceid") VALUES (1068, 1065, 'Pamela Anderson', '8963 Jennifer Locks
Samuelhaven, NV 16361', '531.250.9839', 1069);
INSERT INTO "room" ("roomnumber", "blockfloor", "blockcode", "roomtype", "unavailable") VALUES (1070, 1060, 1061, 'avoid', 1071);
INSERT INTO "stay" ("stayid", "room", "patient", "staystart", "stayend") VALUES (1072, 1070, 1068, '1988-08-19', '1989-09-20');
INSERT INTO "undergoes" ("patient", "procedures", "stay", "dateundergoes", "assistingnurse", "physician") VALUES (1068, 1065, 1072, '1990-10-21', 1062, 1073);
INSERT INTO "undergoes" ("patient", "procedures", "stay", "dateundergoes", "assistingnurse", "physician") VALUES (1068, 1074, 1072, '1991-11-22', 1062, 1065);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT patient FROM (SELECT LHS.ssn AS ssn, LHS.name AS name, LHS.address AS address, LHS.phone AS phone, LHS.insuranceid AS insuranceid, LHS.pcp AS pcp, LHS.patient AS patient, LHS.procedures AS procedures, LHS.stay AS stay, LHS.dateundergoes AS dateundergoes, LHS.physician AS physician, LHS.assistingnurse AS assistingnurse, RHS.procedures_other AS procedures_other, RHS.stay_other AS stay_other, RHS.dateundergoes_other AS dateundergoes_other, RHS.assistingnurse_other AS assistingnurse_other FROM (SELECT LHS.ssn AS ssn, LHS.name AS name, LHS.address AS address, LHS.phone AS phone, LHS.insuranceid AS insuranceid, LHS.pcp AS pcp, RHS.patient AS patient, RHS.procedures AS procedures, RHS.stay AS stay, RHS.dateundergoes AS dateundergoes, RHS.physician AS physician, RHS.assistingnurse AS assistingnurse FROM patient AS LHS CROSS JOIN undergoes AS RHS) AS LHS INNER JOIN (SELECT patient, procedures, stay, dateundergoes, procedures AS physician, assistingnurse, procedures_other, stay_other, dateundergoes_other, assistingnurse_other FROM (SELECT LHS.patient AS patient, LHS.procedures AS procedures, LHS.stay AS stay, LHS.dateundergoes AS dateundergoes, LHS.physician AS physician, LHS.assistingnurse AS assistingnurse, RHS.procedures AS procedures_other, RHS.stay AS stay_other, RHS.dateundergoes AS dateundergoes_other, RHS.assistingnurse AS assistingnurse_other FROM undergoes AS LHS INNER JOIN undergoes AS RHS ON (LHS.patient = RHS.patient AND LHS.procedures = RHS.physician))) AS RHS ON (LHS.patient = RHS.patient AND LHS.procedures = RHS.procedures AND LHS.stay = RHS.stay AND LHS.dateundergoes = RHS.dateundergoes AND LHS.physician = RHS.physician AND LHS.assistingnurse = RHS.assistingnurse)) ORDER BY patient;

/*
Gold Result:
*/

-- Prediction Query
SELECT patient FROM undergoes ORDER BY dateundergoes, undergoes.patient NULLS LAST, undergoes.procedures NULLS LAST, undergoes.stay NULLS LAST LIMIT 1;

/*
Prediction Result:
(1068,)
*/