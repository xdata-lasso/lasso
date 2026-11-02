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
INSERT INTO "medication" ("code", "name", "brand", "description") VALUES (1001, 'Allison Hill', 'agreement', 'Information last everything thank serve civil institution.');
INSERT INTO "medication" ("code", "name", "brand", "description") VALUES (1002, 'Noah Rhodes', 'option', 'Choice whatever from behavior benefit.');
INSERT INTO "medication" ("code", "name", "brand", "description") VALUES (1003, 'Angie Henderson', 'decide', 'Page southern role movie win her.');
INSERT INTO "medication" ("code", "name", "brand", "description") VALUES (1004, 'Daniel Wagner', 'sense', 'Fall pick those gun court attorney product.');
INSERT INTO "nurse" ("employeeid", "name", "position", "registered", "ssn") VALUES (1005, 'Victoria Wyatt', 'away', 1009, 1013);
INSERT INTO "nurse" ("employeeid", "name", "position", "registered", "ssn") VALUES (1006, 'Jamie Chavez', 'politics', 1018.0, 1024.0);
INSERT INTO "nurse" ("employeeid", "name", "position", "registered", "ssn") VALUES (1007, 'Carla Kelly', 'prove', 1027.0, 1035.0);
INSERT INTO "nurse" ("employeeid", "name", "position", "registered", "ssn") VALUES (1008, 'Mia Sutton', 'Congress', 1036.0, 1046.0);
INSERT INTO "physician" ("employeeid", "name", "position", "ssn") VALUES (1001, 'Danielle Ford', 'institution', 1017);
INSERT INTO "physician" ("employeeid", "name", "position", "ssn") VALUES (1002, 'Timothy Watts', 'executive', 1026.0);
INSERT INTO "physician" ("employeeid", "name", "position", "ssn") VALUES (1003, 'Frederick Tate', 'attorney', 1035.0);
INSERT INTO "physician" ("employeeid", "name", "position", "ssn") VALUES (1004, 'Rodney Trujillo', 'development', 1044.0);
INSERT INTO "physician" ("employeeid", "name", "position", "ssn") VALUES (1033, NULL, NULL, NULL);
INSERT INTO "patient" ("ssn", "pcp", "name", "address", "phone", "insuranceid") VALUES (1021, 1001, 'Latoya Robbins', '3287 Katelyn Wall Apt. 226
South Patrickmouth, NC 33454', '383.546.5787', 1025);
INSERT INTO "patient" ("ssn", "pcp", "name", "address", "phone", "insuranceid") VALUES (1022, 1001, 'Jonathan Wilkerson', 'Unit 0184 Box 5146
DPO AE 59971', '215.309.8393', 1038.0);
INSERT INTO "patient" ("ssn", "pcp", "name", "address", "phone", "insuranceid") VALUES (1023, 1001, 'Brenda Taylor', '281 Skinner Parkways Apt. 252
New Mariotown, DE 48077', '001-403-910-5183x473', 1051.0);
INSERT INTO "patient" ("ssn", "pcp", "name", "address", "phone", "insuranceid") VALUES (1024, 1001, 'Kimberly Burgess', '03911 Cabrera Trace Apt. 278
West Allison, PA 55962', '876.931.1656', 1064.0);
INSERT INTO "appointment" ("appointmentid", "physician", "prepnurse", "patient", "start", "end", "examinationroom") VALUES (1029, 1001, 1005, 1021, '1970-01-01', '1974-05-05', 'Tonga');
INSERT INTO "appointment" ("appointmentid", "physician", "prepnurse", "patient", "start", "end", "examinationroom") VALUES (1030, 1001, 1005, 1021, '1970-01-02', '1974-05-06', 'Saint Lucia');
INSERT INTO "appointment" ("appointmentid", "physician", "prepnurse", "patient", "start", "end", "examinationroom") VALUES (1031, 1001, 1005, 1021, '1970-01-03', '1974-05-07', 'Austria');
INSERT INTO "appointment" ("appointmentid", "physician", "prepnurse", "patient", "start", "end", "examinationroom") VALUES (1032, 1001, 1005, 1021, '1970-01-04', '1974-05-08', 'Peru');
INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (1033, 1021, 1001, '1978-09-09', 1029, 'ready');
INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (1033, 1022, 1002, '1978-09-10', 1030, 'race');
INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (1033, 1023, 1003, '1978-09-11', 1031, 'billion');
INSERT INTO "prescribes" ("physician", "patient", "medication", "date", "appointment", "dose") VALUES (1033, 1024, 1004, '1978-09-12', 1032, 'ask');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM (SELECT employeeid, name, POSITION, ssn, physician, patient, date, appointment, dose, employeeid AS medication FROM (SELECT LHS.employeeid AS employeeid, LHS.name AS name, LHS.position AS POSITION, LHS.ssn AS ssn, RHS.physician AS physician, RHS.patient AS patient, RHS.date AS date, RHS.appointment AS appointment, RHS.dose AS dose FROM physician AS LHS INNER JOIN prescribes AS RHS ON (LHS.employeeid = RHS.medication))) ORDER BY physician) LIMIT 1);

/*
Gold Result:
('Danielle Ford',)
*/

-- Prediction Query
SELECT T1.name FROM physician AS T1 JOIN prescribes AS T2 ON T1.employeeid = T2.physician ORDER BY T2.dose DESC, T1.employeeid NULLS LAST, T2.physician NULLS LAST, T2.patient NULLS LAST, T2.medication NULLS LAST, T2.date NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/