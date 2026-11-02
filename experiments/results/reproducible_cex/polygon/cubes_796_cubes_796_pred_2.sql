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
INSERT INTO "Physician" ("employeeid", "name", "position", "ssn") VALUES (25, '52', '52', 52);
INSERT INTO "Physician" ("employeeid", "name", "position", "ssn") VALUES (24, '52', '52', 52);
INSERT INTO "Department" ("departmentid", "head", "name") VALUES (27, NULL, '52');
INSERT INTO "Department" ("departmentid", "head", "name") VALUES (26, 24, '52');
INSERT INTO "Affiliated_With" ("physician", "department", "primaryaffiliation") VALUES (25, 26, 52);
INSERT INTO "Affiliated_With" ("physician", "department", "primaryaffiliation") VALUES (24, 27, 52);
INSERT INTO "Procedures" ("code", "name", "cost") VALUES (29, '52', 52);
INSERT INTO "Procedures" ("code", "name", "cost") VALUES (28, '52', 52);
INSERT INTO "Trained_In" ("physician", "treatment", "certificationdate", "certificationexpires") VALUES (25, 28, 52, 52);
INSERT INTO "Patient" ("ssn", "pcp", "name", "address", "phone", "insuranceid") VALUES (30, NULL, '52', '52', '52', 52);
INSERT INTO "Nurse" ("employeeid", "name", "position", "registered", "ssn") VALUES (39, '52', '49', 50, 51);
INSERT INTO "Nurse" ("employeeid", "name", "position", "registered", "ssn") VALUES (32, '52', '52', 52, 52);
INSERT INTO "Appointment" ("appointmentid", "physician", "prepnurse", "patient", "start", "end", "examinationroom") VALUES (33, 24, 39, NULL, 52, 52, '52');
INSERT INTO "Medication" ("code", "name", "brand", "description") VALUES (36, '52', '52', '52');
INSERT INTO "Medication" ("code", "name", "brand", "description") VALUES (35, '52', '52', '52');
INSERT INTO "Prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (25, 30, 35, 52, 33, '52');
INSERT INTO "Block" ("blockfloor", "blockcode") VALUES (40, 23);
INSERT INTO "Block" ("blockfloor", "blockcode") VALUES (21, 22);
INSERT INTO "Room" ("roomnumber", "blockfloor", "blockcode", "roomtype", "unavailable") VALUES (38, 40, 22, '52', 52);
INSERT INTO "Room" ("roomnumber", "blockfloor", "blockcode", "roomtype", "unavailable") VALUES (37, NULL, NULL, '52', 52);
INSERT INTO "On_Call" ("nurse", "blockfloor", "blockcode", "oncallstart", "oncallend") VALUES (39, 40, 22, 41, 42);
INSERT INTO "Stay" ("stayid", "room", "patient", "staystart", "stayend") VALUES (43, 38, NULL, 52, 52);
INSERT INTO "Undergoes" ("patient", "procedures", "stay", "dateundergoes", "assistingnurse", "physician") VALUES (30, 28, 43, 52, 32, 25);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM nurse ORDER BY name, nurse.employeeid NULLS LAST;

/*
Gold Result:
('52',)
('52',)
*/

-- Prediction Query
SELECT DISTINCT T1.name FROM nurse AS T1 JOIN on_call AS T2 ON T1.EmployeeID = T2.nurse;

/*
Prediction Result:
('52',)
*/