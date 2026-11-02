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
INSERT INTO "Physician" ("employeeid", "name", "position", "ssn") VALUES (24, '24', '24', 24);
INSERT INTO "Department" ("departmentid", "head", "name") VALUES (26, 24, '24');
INSERT INTO "Department" ("departmentid", "head", "name") VALUES (25, 24, '24');
INSERT INTO "Affiliated_With" ("physician", "department", "primaryaffiliation") VALUES (24, 25, 24);
INSERT INTO "Procedures" ("code", "name", "cost") VALUES (28, '24', 24);
INSERT INTO "Procedures" ("code", "name", "cost") VALUES (27, '24', 24);
INSERT INTO "Trained_In" ("physician", "treatment", "certificationdate", "certificationexpires") VALUES (24, 27, 24, 24);
INSERT INTO "Patient" ("ssn", "pcp", "name", "address", "phone", "insuranceid") VALUES (29, 24, '24', '24', '24', 24);
INSERT INTO "Nurse" ("employeeid", "name", "position", "registered", "ssn") VALUES (31, '24', '24', 24, 24);
INSERT INTO "Appointment" ("appointmentid", "physician", "prepnurse", "patient", "start", "end", "examinationroom") VALUES (32, NULL, 31, NULL, 24, 24, '24');
INSERT INTO "Medication" ("code", "name", "brand", "description") VALUES (35, '24', '24', '24');
INSERT INTO "Medication" ("code", "name", "brand", "description") VALUES (34, '24', '24', '24');
INSERT INTO "Prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (24, 29, 34, 24, NULL, '24');
INSERT INTO "Block" ("blockfloor", "blockcode") VALUES (21, 22);
INSERT INTO "Room" ("roomnumber", "blockfloor", "blockcode", "roomtype", "unavailable") VALUES (113, 21, 22, '24', 24);
INSERT INTO "Room" ("roomnumber", "blockfloor", "blockcode", "roomtype", "unavailable") VALUES (114, 21, 22, '24', 24);
INSERT INTO "On_Call" ("nurse", "blockfloor", "blockcode", "oncallstart", "oncallend") VALUES (31, 21, 22, 24, 24);
INSERT INTO "Stay" ("stayid", "room", "patient", "staystart", "stayend") VALUES (39, 113, NULL, 24, 24);
INSERT INTO "Stay" ("stayid", "room", "patient", "staystart", "stayend") VALUES (38, 114, NULL, 24, 24);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n AS count_patient_ FROM (SELECT patient, room, COUNT(*) AS n FROM stay GROUP BY patient, room) WHERE (room > 112 OR room <= patient) ORDER BY count_patient_;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(patient) FROM stay WHERE room = 112;

/*
Prediction Result:
(0,)
*/