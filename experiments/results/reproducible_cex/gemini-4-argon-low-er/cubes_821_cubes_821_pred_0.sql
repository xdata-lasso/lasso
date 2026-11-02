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
INSERT INTO "Physician" ("EmployeeID", "Name", "Position", "SSN") VALUES (2, 'Dr. Smith', 'Surgeon', 1002);
INSERT INTO "Patient" ("SSN", "PCP", "Name", "Address", "Phone", "InsuranceID") VALUES (1, 2, 'John Doe', '123 Main St', '555-1234', 999);
INSERT INTO "Procedures" ("Code", "Name", "Cost") VALUES (1, 'Appendectomy', 1500.0);
INSERT INTO "Block" ("BlockFloor", "BlockCode") VALUES (1, 1);
INSERT INTO "Room" ("RoomNumber", "BlockFloor", "BlockCode", "RoomType", "Unavailable") VALUES (101, 1, 1, 'Single', 0);
INSERT INTO "Stay" ("StayID", "Room", "Patient", "StayStart", "StayEnd") VALUES (1, 101, 1, '2023-01-01', '2023-01-05');
INSERT INTO "Nurse" ("EmployeeID", "Name", "Position", "Registered", "SSN") VALUES (1, 'Nurse Joy', 'Head Nurse', 1, 2001);
INSERT INTO "Undergoes" ("Patient", "Procedures", "Stay", "DateUndergoes", "AssistingNurse", "Physician") VALUES (1, 1, 1, '2023-01-02', 1, 2);
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
(1,)
*/