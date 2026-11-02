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
-- Inserting into table: physician --
INSERT INTO "physician" ("employeeid", "name", "position", "ssn") VALUES (-2147483648, 'phy_ca3025', 'phy_84ffea', -55602865);

-- Inserting into table: patient --
INSERT INTO "patient" ("ssn", "pcp", "name", "address", "phone", "insuranceid") VALUES (1, -2147483648, 't1__758e68', 'pat_5bfaed', 'pat_433878', -59984348);

INSERT INTO "patient" ("ssn", "pcp", "name", "address", "phone", "insuranceid") VALUES (2, -2147483648, 't1__758e68', 'pat_5bfaed', 'pat_433878', 1744686505);

INSERT INTO "patient" ("ssn", "pcp", "name", "address", "phone", "insuranceid") VALUES (3, -2147483648, 't1__758e68', 'pat_5bfaed', 'pat_433878', 1160656988);

INSERT INTO "patient" ("ssn", "pcp", "name", "address", "phone", "insuranceid") VALUES (-2147483645, -2147483648, 't1__c42ec2', 'pat_5bfaed', 'pat_433878', 1526238907);

INSERT INTO "patient" ("ssn", "pcp", "name", "address", "phone", "insuranceid") VALUES (4, -2147483648, 'pat_bb38a7', 'pat_5bfaed', 'pat_433878', -1610064545);

INSERT INTO "patient" ("ssn", "pcp", "name", "address", "phone", "insuranceid") VALUES (0, -2147483648, 't1__c42ec2', 'pat_5bfaed', 'pat_433878', -1823627488);

INSERT INTO "patient" ("ssn", "pcp", "name", "address", "phone", "insuranceid") VALUES (-2147483642, -2147483648, 't1__c42ec2', 'pat_5bfaed', 'pat_433878', 947159877);

INSERT INTO "patient" ("ssn", "pcp", "name", "address", "phone", "insuranceid") VALUES (-2147483641, -2147483648, 't1__c42ec2', 'pat_5bfaed', 'pat_433878', 528680845);

INSERT INTO "patient" ("ssn", "pcp", "name", "address", "phone", "insuranceid") VALUES (-2147483640, -2147483648, 't1__c42ec2', 'pat_5bfaed', 'pat_433878', 226938182);

INSERT INTO "patient" ("ssn", "pcp", "name", "address", "phone", "insuranceid") VALUES (-2147483639, -2147483648, 't1__c42ec2', 'pat_5bfaed', 'pat_433878', -953437896);

INSERT INTO "patient" ("ssn", "pcp", "name", "address", "phone", "insuranceid") VALUES (-2147483638, -2147483648, 't1__c42ec2', 'pat_5bfaed', 'pat_433878', 1692174491);

INSERT INTO "patient" ("ssn", "pcp", "name", "address", "phone", "insuranceid") VALUES (5, -2147483648, NULL, 'pat_5bfaed', 'pat_433878', -1437333179);

-- Inserting into table: nurse --
INSERT INTO "nurse" ("employeeid", "name", "position", "registered", "ssn") VALUES (-2147483648, 'nur_c69651', 'nur_b1bacd', 1258409369, -1981402255);

-- Inserting into table: appointment --
INSERT INTO "appointment" ("appointmentid", "physician", "prepnurse", "patient", "start", "end", "examinationroom") VALUES (1, -2147483648, -2147483648, 1, '2022-06-28 11:34:24+00:00', '2021-06-17 14:22:38+00:00', '9n8c4pgu7v');

INSERT INTO "appointment" ("appointmentid", "physician", "prepnurse", "patient", "start", "end", "examinationroom") VALUES (-2147483647, -2147483648, -2147483648, 2, '2023-03-21 21:13:18+00:00', '2022-01-21 14:23:36+00:00', 'uzhsrwbbp6lu');

INSERT INTO "appointment" ("appointmentid", "physician", "prepnurse", "patient", "start", "end", "examinationroom") VALUES (-2147483646, -2147483648, -2147483648, 4, '1970-01-01 00:00:00+00:00', '2022-01-18 15:57:55+00:00', 'mdpos');

INSERT INTO "appointment" ("appointmentid", "physician", "prepnurse", "patient", "start", "end", "examinationroom") VALUES (-2147483645, -2147483648, -2147483648, 4, '1970-01-01 00:00:00+00:00', '2021-06-25 00:51:07+00:00', 'a9');

INSERT INTO "appointment" ("appointmentid", "physician", "prepnurse", "patient", "start", "end", "examinationroom") VALUES (-2147483644, -2147483648, -2147483648, 4, '1969-12-31 23:59:59+00:00', '2024-12-29 01:35:14+00:00', 'ci');

INSERT INTO "appointment" ("appointmentid", "physician", "prepnurse", "patient", "start", "end", "examinationroom") VALUES (-2147483643, -2147483648, -2147483648, 4, '1969-12-31 23:59:59+00:00', '2021-08-19 01:10:02+00:00', '52zbuo4nrq');

INSERT INTO "appointment" ("appointmentid", "physician", "prepnurse", "patient", "start", "end", "examinationroom") VALUES (2, -2147483648, -2147483648, 1, '2024-12-28 10:57:01+00:00', '2022-03-17 22:33:35+00:00', 'p5s5bbp');

INSERT INTO "appointment" ("appointmentid", "physician", "prepnurse", "patient", "start", "end", "examinationroom") VALUES (-2147483641, -2147483648, -2147483648, 1, '1970-01-01 00:00:00+00:00', '2020-08-18 16:30:34+00:00', 'x14ji7zwau2d');

INSERT INTO "appointment" ("appointmentid", "physician", "prepnurse", "patient", "start", "end", "examinationroom") VALUES (-2147483640, -2147483648, -2147483648, 1, '1970-01-01 00:00:00+00:00', '2022-10-12 16:19:32+00:00', '8d99rljsl');

INSERT INTO "appointment" ("appointmentid", "physician", "prepnurse", "patient", "start", "end", "examinationroom") VALUES (-2147483639, -2147483648, -2147483648, 1, '1969-12-31 23:59:59+00:00', '2022-04-27 23:55:02+00:00', 'f9v');

INSERT INTO "appointment" ("appointmentid", "physician", "prepnurse", "patient", "start", "end", "examinationroom") VALUES (3, -2147483648, -2147483648, 5, '2023-01-16 20:10:41+00:00', '2022-03-24 16:30:12+00:00', 'g');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM (SELECT LHS.ssn AS ssn, LHS.name AS name, LHS.address AS address, LHS.phone AS phone, LHS.insuranceid AS insuranceid, LHS.pcp AS pcp, RHS.appointmentid AS appointmentid, RHS.patient AS patient, RHS.prepnurse AS prepnurse, RHS.physician AS physician, RHS.start AS START, RHS.end AS END, RHS.examinationroom AS examinationroom FROM patient AS LHS CROSS JOIN appointment AS RHS) ORDER BY phone DESC) LIMIT 1);

/*
Gold Result:
('t1__c42ec2',)
*/

-- Prediction Query
SELECT T1.name FROM patient AS T1 JOIN appointment AS T2 ON T1.ssn = T2.patient ORDER BY T2.start DESC, T1.ssn NULLS LAST, T2.appointmentid NULLS LAST LIMIT 1;

/*
Prediction Result:
('t1__758e68',)
*/