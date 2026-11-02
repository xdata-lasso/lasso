-- Schema DDL
CREATE TABLE "DOCTORS" (
    "ID" INT,
    "NAME" TEXT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "APPOINTMENTS" (
    "ID" INT,
    "DOCTOR_ID" INT,
    "PATIENT_ID" INT,
    PRIMARY KEY ("ID"),
    FOREIGN KEY ("PATIENT_ID") REFERENCES "PATIENTS"("ID"),
    FOREIGN KEY ("DOCTOR_ID") REFERENCES "DOCTORS"("ID")
);
CREATE TABLE "PATIENTS" (
    "ID" INT,
    "NAME" TEXT,
    PRIMARY KEY ("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO DOCTORS VALUES (0, 16);
INSERT INTO DOCTORS VALUES (-1, 20);
INSERT INTO APPOINTMENTS VALUES (-1, 0, 0);
INSERT INTO APPOINTMENTS VALUES (0, 0, 0);
INSERT INTO PATIENTS VALUES (1, 9);
INSERT INTO PATIENTS VALUES (0, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT d.name, p.name FROM doctors AS d LEFT JOIN appointments AS a ON d.id = a.doctor_id LEFT JOIN patients AS p ON a.patient_id = p.id;

/*
Gold Result:
('16', '10')
('16', '10')
('20', None)
*/

-- Prediction Query
SELECT d.name, p.name FROM doctors AS d LEFT JOIN appointments AS a ON d.id = a.doctor_id INNER JOIN patients AS p ON a.patient_id = p.id;

/*
Prediction Result:
('16', '10')
('16', '10')
*/