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
INSERT INTO "nurse" ("employeeid", "name", "position", "registered", "ssn") VALUES (1051, 'Jordan Henderson', 'article', 1054, 1057);
INSERT INTO "nurse" ("employeeid", "name", "position", "registered", "ssn") VALUES (1052, 'Whitney Peters', 'particularly', 1063.0, 1068.0);
INSERT INTO "nurse" ("employeeid", "name", "position", "registered", "ssn") VALUES (1053, 'Brittney Phillips', 'simply', 1072.0, 1079.0);
INSERT INTO "nurse" ("employeeid", "name", "position", "registered", "ssn") VALUES (1075, 'Vanessa Cochran', 'treat', 1078, 1081);
INSERT INTO "nurse" ("employeeid", "name", "position", "registered", "ssn") VALUES (1076, 'Allison Doyle', 'simple', 1087.0, 1092.0);
INSERT INTO "nurse" ("employeeid", "name", "position", "registered", "ssn") VALUES (1077, 'Timothy Pham', 'talk', 1096.0, 1103.0);
INSERT INTO "physician" ("employeeid", "name", "position", "ssn") VALUES (1060, 'Nicole Brown', 'cultural', 1063);
INSERT INTO "physician" ("employeeid", "name", "position", "ssn") VALUES (1061, 'Kathryn Farrell', 'authority', 1072.0);
INSERT INTO "physician" ("employeeid", "name", "position", "ssn") VALUES (1062, 'Tyler Miller', 'physical', 1081.0);
INSERT INTO "patient" ("ssn", "pcp", "name", "address", "phone", "insuranceid") VALUES (1066, 1060, 'Scott Powell', '3534 Anderson Rue Suite 751
South Christineshire, CT 10103', '801-264-0052x427', 1069);
INSERT INTO "patient" ("ssn", "pcp", "name", "address", "phone", "insuranceid") VALUES (1067, 1060, 'Laura Riley', '51354 Samuel Plains Suite 980
Sarahville, FM 18102', '812-480-5982', 1082.0);
INSERT INTO "patient" ("ssn", "pcp", "name", "address", "phone", "insuranceid") VALUES (1068, 1060, 'Bradley Sandoval', '824 Jacobs Stravenue
Jamesview, NY 64533', '8454053315', 1095.0);
INSERT INTO "appointment" ("appointmentid", "physician", "prepnurse", "patient", "start", "end", "examinationroom") VALUES (1072, 1060, 1051, 1066, '1982-02-13', '1985-05-16', 'Uzbekistan');
INSERT INTO "appointment" ("appointmentid", "physician", "prepnurse", "patient", "start", "end", "examinationroom") VALUES (1073, 1060, 1051, 1066, '1982-02-14', '1985-05-17', 'Venezuela');
INSERT INTO "appointment" ("appointmentid", "physician", "prepnurse", "patient", "start", "end", "examinationroom") VALUES (1074, 1060, 1051, 1066, '1982-02-15', '1985-05-18', 'Dominica');
INSERT INTO "appointment" ("appointmentid", "physician", "prepnurse", "patient", "start", "end", "examinationroom") VALUES (1094, 1061, 1075, 1067, '1988-08-19', '1991-11-22', 'Wallis and Futuna');
INSERT INTO "appointment" ("appointmentid", "physician", "prepnurse", "patient", "start", "end", "examinationroom") VALUES (1095, 1061, 1075, 1067, '1988-08-20', '1991-11-23', 'Saint Vincent and the Grenadines');
INSERT INTO "appointment" ("appointmentid", "physician", "prepnurse", "patient", "start", "end", "examinationroom") VALUES (1096, 1061, 1075, 1067, '1988-08-21', '1991-11-24', 'Saint Pierre and Miquelon');
INSERT INTO "appointment" ("appointmentid", "physician", "prepnurse", "patient", "start", "end", "examinationroom") VALUES (1097, 1061, 1075, 1067, '1988-08-21', '1991-11-24', 'Saint Pierre and Miquelon');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, phone FROM (SELECT LHS.ssn AS ssn, LHS.name AS name, LHS.address AS address, LHS.phone AS phone, LHS.insuranceid AS insuranceid, LHS.pcp AS pcp, RHS.physician AS physician, RHS.n AS n FROM patient AS LHS INNER JOIN (SELECT * FROM (SELECT patient, physician, COUNT(*) AS n FROM appointment GROUP BY patient, physician) WHERE (n <> 1)) AS RHS ON (LHS.ssn = RHS.patient)) ORDER BY name, phone NULLS LAST;

/*
Gold Result:
('Laura Riley', '812-480-5982')
('Scott Powell', '801-264-0052x427')
*/

-- Prediction Query
SELECT name, phone FROM appointment AS T1 JOIN patient AS T2 ON T1.patient = T2.ssn GROUP BY T1.patient HAVING COUNT(*) > 1;

/*
Prediction Result:
('Scott Powell', '801-264-0052x427')
('Laura Riley', '812-480-5982')
*/