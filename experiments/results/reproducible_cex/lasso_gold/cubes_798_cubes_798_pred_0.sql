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
INSERT INTO "nurse" ("employeeid", "name", "position", "registered", "ssn") VALUES (1049, 'Krista Williams', 'now', 1050, 1051);
INSERT INTO "nurse" ("employeeid", "name", "position", "registered", "ssn") VALUES (1065, 'Michele Carr', 'surface', 1066, 1067);
INSERT INTO "nurse" ("employeeid", "name", "position", "registered", "ssn") VALUES (1057, NULL, NULL, NULL, NULL);
INSERT INTO "physician" ("employeeid", "name", "position", "ssn") VALUES (1052, 'Tracy House', 'time', 1053);
INSERT INTO "physician" ("employeeid", "name", "position", "ssn") VALUES (1068, 'Aimee Montoya', 'firm', 1069);
INSERT INTO "physician" ("employeeid", "name", "position", "ssn") VALUES (1060, NULL, NULL, NULL);
INSERT INTO "patient" ("ssn", "pcp", "name", "address", "phone", "insuranceid") VALUES (1054, 1052, 'Jason Olson', '60647 Henderson Street
Mooreport, IL 08166', '001-480-250-0978', 1055);
INSERT INTO "patient" ("ssn", "pcp", "name", "address", "phone", "insuranceid") VALUES (1070, 1068, 'Ashley Humphrey', '824 Jacobs Stravenue
Jamesview, NY 64533', '801-264-0052x427', 1071);
INSERT INTO "appointment" ("appointmentid", "physician", "prepnurse", "patient", "start", "end", "examinationroom") VALUES (1056, 1052, 1049, 1054, '1980-11-11', '1981-01-12', 'Malawi');
INSERT INTO "appointment" ("appointmentid", "physician", "prepnurse", "patient", "start", "end", "examinationroom") VALUES (1064, 1060, 1057, 1054, '1982-02-13', '1983-03-14', 'Kazakhstan');
INSERT INTO "appointment" ("appointmentid", "physician", "prepnurse", "patient", "start", "end", "examinationroom") VALUES (1072, 1068, 1065, 1070, '1984-04-15', '1985-05-16', 'Bouvet Island (Bouvetoya)');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.ssn AS ssn, LHS.name AS name, LHS.address AS address, LHS.phone AS phone, LHS.insuranceid AS insuranceid, LHS.pcp AS pcp, RHS.appointmentid AS appointmentid, RHS.prepnurse AS prepnurse, RHS.physician AS physician, RHS.start AS START, RHS.end AS END, RHS.examinationroom AS examinationroom FROM patient AS LHS INNER JOIN appointment AS RHS ON (LHS.ssn = RHS.patient)) ORDER BY name;

/*
Gold Result:
('Ashley Humphrey',)
('Jason Olson',)
('Jason Olson',)
*/

-- Prediction Query
SELECT name FROM appointment AS T1 JOIN patient AS T2 ON T1.patient = T2.ssn;

/*
Prediction Result:
('Jason Olson',)
('Jason Olson',)
('Ashley Humphrey',)
*/