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
INSERT INTO "physician" ("employeeid", "name", "position", "ssn") VALUES (2, 't1__0d3156', 'phy_84ffea', -55602865);

INSERT INTO "physician" ("employeeid", "name", "position", "ssn") VALUES (1, 't1__0d3156', 'phy_84ffea', -59984348);

INSERT INTO "physician" ("employeeid", "name", "position", "ssn") VALUES (3, 't1__0d3156', 'phy_84ffea', 1744686505);

INSERT INTO "physician" ("employeeid", "name", "position", "ssn") VALUES (4, 'phy_ca3025', 'phy_84ffea', -992890117);

INSERT INTO "physician" ("employeeid", "name", "position", "ssn") VALUES (5, 'phy_ca3025', 'phy_84ffea', -55602865);

INSERT INTO "physician" ("employeeid", "name", "position", "ssn") VALUES (6, NULL, 'phy_84ffea', -55602865);

INSERT INTO "physician" ("employeeid", "name", "position", "ssn") VALUES (-2147483642, 'G', 'phy_84ffea', 1258409369);

INSERT INTO "physician" ("employeeid", "name", "position", "ssn") VALUES (-2147483641, 'A', 'phy_84ffea', -1981402255);

INSERT INTO "physician" ("employeeid", "name", "position", "ssn") VALUES (-2147483640, 'O', 'phy_84ffea', -890215420);

INSERT INTO "physician" ("employeeid", "name", "position", "ssn") VALUES (-2147483639, 'A', 'phy_84ffea', 1610062532);

INSERT INTO "physician" ("employeeid", "name", "position", "ssn") VALUES (-2147483638, 'G', 'phy_84ffea', -106629402);

INSERT INTO "physician" ("employeeid", "name", "position", "ssn") VALUES (-2147483637, 'A', 'phy_84ffea', 1871297066);

INSERT INTO "physician" ("employeeid", "name", "position", "ssn") VALUES (-2147483636, 'O', 'phy_84ffea', 809183447);

INSERT INTO "physician" ("employeeid", "name", "position", "ssn") VALUES (-2147483635, 'A', 'phy_84ffea', 89267185);

INSERT INTO "physician" ("employeeid", "name", "position", "ssn") VALUES (-2147483634, 'G', 'phy_84ffea', -1865039888);

INSERT INTO "physician" ("employeeid", "name", "position", "ssn") VALUES (-2147483633, 'A', 'phy_84ffea', 1160656988);

-- Inserting into table: patient --
INSERT INTO "patient" ("ssn", "pcp", "name", "address", "phone", "insuranceid") VALUES (-2147483648, 1, 'pat_bb38a7', 'pat_5bfaed', 'pat_433878', 247012447);

-- Inserting into table: nurse --
INSERT INTO "nurse" ("employeeid", "name", "position", "registered", "ssn") VALUES (-2147483648, 'nur_c69651', 'nur_b1bacd', 1258409369, -1981402255);

-- Inserting into table: appointment --
INSERT INTO "appointment" ("appointmentid", "physician", "prepnurse", "patient", "start", "end", "examinationroom") VALUES (-2147483648, 1, -2147483648, -2147483648, '2025-02-21 23:30:13+00:00', '2024-07-26 19:47:18+00:00', '4');

-- Inserting into table: medication --
INSERT INTO "medication" ("code", "name", "brand", "description") VALUES (1, 'Thesisin', 'med_d9a45c', 'med_7d5eb1');

INSERT INTO "medication" ("code", "name", "brand", "description") VALUES (2, 'Thesisin', 'med_d9a45c', 'med_7d5eb1');

INSERT INTO "medication" ("code", "name", "brand", "description") VALUES (3, 'med_7aec16', 'med_d9a45c', 'med_7d5eb1');

INSERT INTO "medication" ("code", "name", "brand", "description") VALUES (4, NULL, 'med_d9a45c', 'med_7d5eb1');

INSERT INTO "medication" ("code", "name", "brand", "description") VALUES (5, 'Thesisin', 'med_d9a45c', 'med_7d5eb1');

-- Inserting into table: prescribes --
INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (2, -2147483648, 1, '2020-11-05 04:59:51+00:00', -2147483648, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (2, -2147483648, 1, '2020-09-25 19:25:33+00:00', -2147483648, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (4, -2147483648, 1, '2020-01-15 18:18:33+00:00', -2147483648, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (4, -2147483648, 1, '2022-01-21 14:23:36+00:00', -2147483648, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (2, -2147483648, 3, '2020-12-10 17:36:20+00:00', -2147483648, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (2, -2147483648, 3, '2022-12-20 09:53:17+00:00', -2147483648, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (4, -2147483648, 1, '2022-01-03 02:42:55+00:00', -2147483648, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (4, -2147483648, 1, '2020-12-19 01:52:21+00:00', -2147483648, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (2, -2147483648, 3, '2021-07-11 07:27:32+00:00', -2147483648, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (2, -2147483648, 3, '2021-01-23 18:11:33+00:00', -2147483648, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (4, -2147483648, 1, '2025-02-07 06:53:31+00:00', -2147483648, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (4, -2147483648, 1, '2022-04-12 01:47:28+00:00', -2147483648, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (2, -2147483648, 3, '2021-12-31 07:20:26+00:00', -2147483648, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (2, -2147483648, 3, '2021-02-17 05:47:13+00:00', -2147483648, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (2, -2147483648, 1, '2024-02-29 12:08:41+00:00', -2147483648, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (2, -2147483648, 1, '2022-12-10 02:38:39+00:00', -2147483648, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (2, -2147483648, 1, '2020-09-15 12:11:12+00:00', -2147483648, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (2, -2147483648, 1, '2025-05-02 19:47:39+00:00', -2147483648, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (2, -2147483648, 1, '2022-07-16 22:41:51+00:00', -2147483648, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (2, -2147483648, 1, '2025-08-21 21:00:40+00:00', -2147483648, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (2, -2147483648, 1, '2020-05-12 00:10:04+00:00', -2147483648, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (2, -2147483648, 1, '2020-05-18 19:45:10+00:00', -2147483648, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (2, -2147483648, 1, '2024-05-26 02:52:16+00:00', -2147483648, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (2, -2147483648, 1, '2022-09-29 20:25:58+00:00', -2147483648, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (2, -2147483648, 1, '2023-11-07 12:14:47+00:00', -2147483648, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (2, -2147483648, 1, '2025-10-02 08:51:14+00:00', -2147483648, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (2, -2147483648, 1, '2024-01-27 22:01:59+00:00', -2147483648, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (2, -2147483648, 1, '2025-10-19 18:29:54+00:00', -2147483648, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (1, -2147483648, 1, '2021-11-17 08:00:56+00:00', -2147483648, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (2, -2147483648, 1, '2023-04-26 07:28:40+00:00', -2147483648, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (2, -2147483648, 1, '2022-06-06 01:51:46+00:00', -2147483648, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (5, -2147483648, 4, '2022-12-08 21:38:59+00:00', -2147483648, 'pre_12f969');

INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (6, -2147483648, 5, '2022-12-08 21:38:59+00:00', -2147483648, 'pre_12f969');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "name_other" AS "name" FROM (SELECT "physician", "patient", "medication", "date", "appointment", "dose", "name", "brand", "description", "name_other", "position", "ssn", "physician" AS "employeeid" FROM (SELECT "LHS"."physician" AS "physician", "LHS"."patient" AS "patient", "LHS"."medication" AS "medication", "LHS"."date" AS "date", "LHS"."appointment" AS "appointment", "LHS"."dose" AS "dose", "RHS"."name" AS "name", "RHS"."brand" AS "brand", "RHS"."description" AS "description", "RHS"."name_other" AS "name_other", "RHS"."position" AS "position", "RHS"."ssn" AS "ssn" FROM "prescribes" AS "LHS" INNER JOIN (SELECT * FROM (SELECT * FROM (SELECT "LHS"."code" AS "code", "LHS"."name" AS "name", "LHS"."brand" AS "brand", "LHS"."description" AS "description", "RHS"."employeeid" AS "employeeid", "RHS"."name" AS "name_other", "RHS"."position" AS "position", "RHS"."ssn" AS "ssn" FROM "medication" AS "LHS" CROSS JOIN "physician" AS "RHS") WHERE ("name" <> "name_other")) WHERE ("name" = 'Thesisin')) AS RHS ON (LHS.physician = RHS.employeeid AND LHS.medication = RHS.code))) ORDER BY name;

/*
Gold Result:
('phy_ca3025',)
('t1__0d3156',)
*/

-- Prediction Query
SELECT DISTINCT T1.name FROM physician AS T1 JOIN prescribes AS T2 ON T1.employeeid = T2.physician JOIN medication AS T3 ON T3.code = T2.medication WHERE T3.name = 'Thesisin';

/*
Prediction Result:
('t1__0d3156',)
('phy_ca3025',)
(None,)
*/