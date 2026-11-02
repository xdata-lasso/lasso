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
INSERT INTO "physician" ("employeeid", "name", "position", "ssn") VALUES (-2147483648, 'phy_ca3025', 'phy_84ffea', -921145356);

-- Inserting into table: patient --
INSERT INTO "patient" ("ssn", "pcp", "name", "address", "phone", "insuranceid") VALUES (1, -2147483648, 'pat_bb38a7', 'pat_5bfaed', 'pat_433878', 1258409369);

-- Inserting into table: block --
INSERT INTO "block" ("blockfloor", "blockcode") VALUES (-2147483648, -2147483648);

-- Inserting into table: room --
INSERT INTO "room" ("roomnumber", "blockfloor", "blockcode", "roomtype", "unavailable") VALUES (1, -2147483648, -2147483648, 'roo_94bb39', -1437333179);

-- Inserting into table: stay --
INSERT INTO "stay" ("stayid", "room", "patient", "staystart", "stayend") VALUES (-2147483648, 1, 1, '2020-04-30 03:21:27+00:00', '2020-10-31 07:51:16+00:00');

INSERT INTO "stay" ("stayid", "room", "patient", "staystart", "stayend") VALUES (-2147483647, 1, 1, '2022-06-28 11:34:24+00:00', '2021-06-17 14:22:38+00:00');

INSERT INTO "stay" ("stayid", "room", "patient", "staystart", "stayend") VALUES (-2147483646, 1, 1, '2024-11-14 12:35:58+00:00', '2024-09-28 03:06:45+00:00');

INSERT INTO "stay" ("stayid", "room", "patient", "staystart", "stayend") VALUES (-2147483645, 1, 1, '2021-10-04 22:30:57+00:00', '2025-02-21 23:30:13+00:00');

INSERT INTO "stay" ("stayid", "room", "patient", "staystart", "stayend") VALUES (-2147483644, 1, 1, '2024-07-26 19:47:18+00:00', '2020-04-30 23:22:06+00:00');

INSERT INTO "stay" ("stayid", "room", "patient", "staystart", "stayend") VALUES (-2147483643, 1, 1, '2024-01-16 07:29:50+00:00', '2022-02-14 19:27:39+00:00');

INSERT INTO "stay" ("stayid", "room", "patient", "staystart", "stayend") VALUES (-2147483642, 1, 1, '2025-11-08 19:01:33+00:00', '2022-09-05 02:10:50+00:00');

INSERT INTO "stay" ("stayid", "room", "patient", "staystart", "stayend") VALUES (-2147483641, 1, 1, '2020-09-25 19:25:33+00:00', '2020-07-23 07:32:15+00:00');

INSERT INTO "stay" ("stayid", "room", "patient", "staystart", "stayend") VALUES (-2147483640, 1, 1, '2025-06-13 15:31:02+00:00', '2021-01-07 01:22:28+00:00');

INSERT INTO "stay" ("stayid", "room", "patient", "staystart", "stayend") VALUES (-2147483639, 1, 1, '2021-02-21 20:09:01+00:00', '2020-01-15 18:18:33+00:00');

INSERT INTO "stay" ("stayid", "room", "patient", "staystart", "stayend") VALUES (-2147483638, 1, 1, '2023-03-21 21:13:18+00:00', '2022-01-21 14:23:36+00:00');

INSERT INTO "stay" ("stayid", "room", "patient", "staystart", "stayend") VALUES (-2147483637, 1, 1, '2023-05-25 17:04:36+00:00', '2020-12-10 17:36:20+00:00');

INSERT INTO "stay" ("stayid", "room", "patient", "staystart", "stayend") VALUES (-2147483636, 1, 1, '2022-07-05 02:28:20+00:00', '2025-08-22 00:34:24+00:00');

INSERT INTO "stay" ("stayid", "room", "patient", "staystart", "stayend") VALUES (-2147483635, 1, 1, '2022-04-13 09:01:25+00:00', '2022-12-20 09:53:17+00:00');

INSERT INTO "stay" ("stayid", "room", "patient", "staystart", "stayend") VALUES (-2147483634, 1, 1, '2020-04-05 14:43:51+00:00', '2020-03-08 22:40:47+00:00');

INSERT INTO "stay" ("stayid", "room", "patient", "staystart", "stayend") VALUES (-2147483633, 1, 1, '2022-01-03 02:42:55+00:00', '2024-04-12 00:38:47+00:00');

INSERT INTO "stay" ("stayid", "room", "patient", "staystart", "stayend") VALUES (-2147483632, 1, 1, '2021-07-31 11:04:01+00:00', '2022-09-23 20:24:07+00:00');

INSERT INTO "stay" ("stayid", "room", "patient", "staystart", "stayend") VALUES (-2147483631, 1, 1, '2020-12-19 01:52:21+00:00', '2022-11-06 10:19:41+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n AS count_patient_ FROM (SELECT patient, room, COUNT(*) AS n FROM stay GROUP BY patient, room) WHERE (room > 112 OR room <= patient) ORDER BY count_patient_;

/*
Gold Result:
(18,)
*/

-- Prediction Query
SELECT COUNT(patient) FROM stay WHERE room = 112;

/*
Prediction Result:
(0,)
*/