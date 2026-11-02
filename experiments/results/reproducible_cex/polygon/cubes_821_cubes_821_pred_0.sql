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
INSERT INTO "Physician" ("employeeid", "name", "position", "ssn") VALUES (55, '51', '51', 51);
INSERT INTO "Physician" ("employeeid", "name", "position", "ssn") VALUES (51, '51', '51', 51);
INSERT INTO "Department" ("departmentid", "head", "name") VALUES (33, 51, '51');
INSERT INTO "Department" ("departmentid", "head", "name") VALUES (32, 51, '51');
INSERT INTO "Procedures" ("code", "name", "cost") VALUES (51, '51', 51);
INSERT INTO "Procedures" ("code", "name", "cost") VALUES (55, '51', 51);
INSERT INTO "Trained_In" ("physician", "treatment", "certificationdate", "certificationexpires") VALUES (51, 55, 51, 51);
INSERT INTO "Trained_In" ("physician", "treatment", "certificationdate", "certificationexpires") VALUES (55, 55, 51, 51);
INSERT INTO "Patient" ("ssn", "pcp", "name", "address", "phone", "insuranceid") VALUES (52, 51, '47', '48', '49', 50);
INSERT INTO "Nurse" ("employeeid", "name", "position", "registered", "ssn") VALUES (59, '51', '51', 51, 51);
INSERT INTO "Nurse" ("employeeid", "name", "position", "registered", "ssn") VALUES (56, '51', '51', 51, 51);
INSERT INTO "Appointment" ("appointmentid", "physician", "prepnurse", "patient", "start", "end", "examinationroom") VALUES (34, 55, 56, 52, 51, 51, '51');
INSERT INTO "Medication" ("code", "name", "brand", "description") VALUES (35, '51', '51', '51');
INSERT INTO "Prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (51, 52, 35, 37, 34, '51');
INSERT INTO "Block" ("blockfloor", "blockcode") VALUES (30, 31);
INSERT INTO "Room" ("roomnumber", "blockfloor", "blockcode", "roomtype", "unavailable") VALUES (39, 30, 31, '51', 51);
INSERT INTO "On_Call" ("nurse", "blockfloor", "blockcode", "oncallstart", "oncallend") VALUES (56, 30, 31, 51, 41);
INSERT INTO "Stay" ("stayid", "room", "patient", "staystart", "stayend") VALUES (57, 39, 52, 51, 51);
INSERT INTO "Stay" ("stayid", "room", "patient", "staystart", "stayend") VALUES (53, 39, 52, 51, 51);
INSERT INTO "Undergoes" ("patient", "procedures", "stay", "dateundergoes", "assistingnurse", "physician") VALUES (52, 51, 57, 58, 59, 55);
INSERT INTO "Undergoes" ("patient", "procedures", "stay", "dateundergoes", "assistingnurse", "physician") VALUES (52, 55, 53, 54, 56, 51);
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
(52,)
*/