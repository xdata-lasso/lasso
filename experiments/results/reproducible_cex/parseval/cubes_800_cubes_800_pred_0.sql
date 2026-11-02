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
INSERT INTO "patient" ("ssn", "pcp", "name", "address", "phone", "insuranceid") VALUES (-2147483648, -2147483648, 'pat_bb38a7', 'pat_5bfaed', 'pat_433878', -1981402255);

-- Inserting into table: nurse --
INSERT INTO "nurse" ("employeeid", "name", "position", "registered", "ssn") VALUES (-2147483648, 'nur_c69651', 'nur_b1bacd', -59984348, -664303813);

-- Inserting into table: appointment --
INSERT INTO "appointment" ("appointmentid", "physician", "prepnurse", "patient", "start", "end", "examinationroom") VALUES (1, -2147483648, -2147483648, -2147483648, '2022-06-28 11:34:24+00:00', '2021-06-17 14:22:38+00:00', '9n8c4pgu7v');

-- Inserting into table: medication --
INSERT INTO "medication" ("code", "name", "brand", "description") VALUES (1, 'lhs_a35580', 'lhs_0daefb', 'lhs_13e421');

-- Inserting into table: prescribes --
INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (-2147483648, -2147483648, 1, '2024-02-11 16:43:27+00:00', 1, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (-2147483648, -2147483648, 1, '2021-02-21 20:09:01+00:00', 1, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (-2147483648, -2147483648, 1, '2023-03-21 21:13:18+00:00', 1, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (-2147483648, -2147483648, 1, '2020-12-10 17:36:20+00:00', 1, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (-2147483648, -2147483648, 1, '2020-04-05 14:43:51+00:00', 1, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (-2147483648, -2147483648, 1, '2022-09-23 20:24:07+00:00', 1, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (-2147483648, -2147483648, 1, '2020-06-20 11:35:06+00:00', 1, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (-2147483648, -2147483648, 1, '2022-08-02 13:58:36+00:00', 1, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (-2147483648, -2147483648, 1, '2020-03-11 00:23:16+00:00', 1, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (-2147483648, -2147483648, 1, '2022-04-12 01:47:28+00:00', 1, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (-2147483648, -2147483648, 1, '2021-12-31 07:20:26+00:00', 1, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (-2147483648, -2147483648, 1, '2021-02-17 05:47:13+00:00', 1, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (-2147483648, -2147483648, 1, '2024-02-29 12:08:41+00:00', 1, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (-2147483648, -2147483648, 1, '2022-12-10 02:38:39+00:00', 1, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (-2147483648, -2147483648, 1, '2020-09-15 12:11:12+00:00', 1, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (-2147483648, -2147483648, 1, '2025-05-02 19:47:39+00:00', 1, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (-2147483648, -2147483648, 1, '2022-07-16 22:41:51+00:00', 1, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (-2147483648, -2147483648, 1, '2025-08-21 21:00:40+00:00', 1, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (-2147483648, -2147483648, 1, '2020-05-12 00:10:04+00:00', 1, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (-2147483648, -2147483648, 1, '2020-05-18 19:45:10+00:00', 1, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (-2147483648, -2147483648, 1, '2024-05-26 02:52:16+00:00', 1, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (-2147483648, -2147483648, 1, '2022-09-29 20:25:58+00:00', 1, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (-2147483648, -2147483648, 1, '2023-11-07 12:14:47+00:00', 1, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (-2147483648, -2147483648, 1, '2025-10-02 08:51:14+00:00', 1, 'pre_12f969');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT code AS count___, name FROM (SELECT LHS.code AS code, LHS.name AS name, LHS.brand AS brand, LHS.description AS description, RHS.appointment AS appointment, RHS.n AS n FROM medication AS LHS INNER JOIN (SELECT appointment, medication, COUNT(*) AS n FROM prescribes GROUP BY appointment, medication) AS RHS ON (LHS.code = RHS.medication)) ORDER BY count___, name NULLS LAST;

/*
Gold Result:
(1, 'lhs_a35580')
*/

-- Prediction Query
SELECT COUNT(*), T1.name FROM medication AS T1 JOIN prescribes AS T2 ON T1.code = T2.medication GROUP BY T1.brand;

/*
Prediction Result:
(24, 'lhs_a35580')
*/