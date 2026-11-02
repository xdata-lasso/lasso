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
-- DATASET 1
-- General comprehensive dataset:
-- Tests DISTINCT (multiple rows generated in cross join), AVG calculation over ALL procedures (including untrained ones),
-- and filtering of 'John Wen' vs other physicians.
INSERT INTO "Physician" ("EmployeeID", "Name", "Position", "SSN") VALUES (1, 'John Wen', 'Surgical Attending Physician', 111111111);
INSERT INTO "Physician" ("EmployeeID", "Name", "Position", "SSN") VALUES (2, 'Elliot Reid', 'Attending Physician', 222222222);
INSERT INTO "Physician" ("EmployeeID", "Name", "Position", "SSN") VALUES (3, 'Christopher Turk', 'Surgical Attending Physician', 333333333);
INSERT INTO "Procedures" ("Code", "Name", "Cost") VALUES (10, 'Reverse Rhinopodoplasty', 1500.0);
INSERT INTO "Procedures" ("Code", "Name", "Cost") VALUES (20, 'Obtuse Pyloric Recombobulation', 3500.0);
INSERT INTO "Procedures" ("Code", "Name", "Cost") VALUES (30, 'Folded Demiophtalmectomy', 4000.0);
INSERT INTO "Trained_In" ("Physician", "Treatment", "CertificationDate", "CertificationExpires") VALUES (1, 10, '2008-01-01 00:00:00', '2018-01-01 00:00:00');
INSERT INTO "Trained_In" ("Physician", "Treatment", "CertificationDate", "CertificationExpires") VALUES (2, 20, '2009-05-01 00:00:00', '2019-05-01 00:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "meancost" AS "avg_t3_cost_" FROM (SELECT "LHS"."physician" AS "physician", "LHS"."treatment" AS "treatment", "LHS"."certificationdate" AS "certificationdate", "LHS"."certificationexpires" AS "certificationexpires", "LHS"."meancost" AS "meancost", "RHS"."employeeid" AS "employeeid", "RHS"."name" AS "name", "RHS"."position" AS "position", "RHS"."ssn" AS "ssn" FROM (SELECT "LHS"."physician" AS "physician", "LHS"."treatment" AS "treatment", "LHS"."certificationdate" AS "certificationdate", "LHS"."certificationexpires" AS "certificationexpires", "RHS"."meancost" AS "meancost" FROM "trained_in" AS "LHS" CROSS JOIN (SELECT AVG("cost") AS "meancost" FROM "procedures") AS "RHS") AS "LHS" CROSS JOIN (SELECT * FROM "physician" WHERE ("name" <> 'John Wen')) AS RHS) ORDER BY avg_t3_cost_;

/*
Gold Result:
(3000.0,)
*/

-- Prediction Query
SELECT AVG(T3.cost) FROM physician AS T1 JOIN trained_in AS T2 ON T1.employeeid = T2.physician JOIN procedures AS T3 ON T3.code = T2.treatment WHERE T1.name = 'John Wen';

/*
Prediction Result:
(1500.0,)
*/