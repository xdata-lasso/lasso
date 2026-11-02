-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, date_of_birth DATE, gender TEXT);

CREATE TABLE Doctors (doctor_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, specialty TEXT, years_experience INTEGER);

CREATE TABLE Appointments (appointment_id INTEGER PRIMARY KEY, patient_id INTEGER, doctor_id INTEGER, appointment_date DATETIME, status TEXT, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id), FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id));

CREATE TABLE Prescriptions (prescription_id INTEGER PRIMARY KEY, appointment_id INTEGER, medication_name TEXT, dosage TEXT, duration_days INTEGER, FOREIGN KEY (appointment_id) REFERENCES Appointments (appointment_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patients --
INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (1, 'p_s_0e1f20', '5k5swwqcgs', '2021-12-04', '9n8c4pgu7v');

INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (2, 'p_s_0e1f20', 'p6luhvdlttil', '2020-04-02', 'nprmdposii');

INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (-2147483647, 'p_s_0e1f20', '5u', '2022-06-13', '6klfa9');

INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (3, 'qyp5s5bbp0', '2eutliqa11r', '2024-03-30', 'ytoo3o9hl7');

INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (4, '5k5swwqcgs', '9n8', '2020-06-08', 'pgu7vfe4');

INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (-2147483643, NULL, 'hria2ypuzhs', '2023-01-03', 'wbbp6luhvdlt');

INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (5, '9000t5c4ec', 'gce', '2025-03-28', '6nium52zb');

INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (-2147483641, NULL, 'uo4nrqrofqy', '2022-09-19', 's5bbp02e');

INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (6, 'ji7zwau2', 'dwyrq13pyu78', '2020-07-21', '9rljsl0b4');

INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (-2147483639, NULL, 'p5qi2rk', '2021-01-15', 'vqx58pz0f');

-- Inserting into table: doctors --
INSERT INTO "doctors" ("doctor_id", "first_name", "last_name", "specialty", "years_experience") VALUES (1, 'd_s_b5e7a3', 'e4', 'hria2ypuzhs', 700293388);

INSERT INTO "doctors" ("doctor_id", "first_name", "last_name", "specialty", "years_experience") VALUES (-2147483647, 'd_s_b5e7a3', '00t5c4e', 'cigce376nium', 283598170);

INSERT INTO "doctors" ("doctor_id", "first_name", "last_name", "specialty", "years_experience") VALUES (3, 'd_s_b5e7a3', 'dwyrq13pyu78', '9', 244829661);

INSERT INTO "doctors" ("doctor_id", "first_name", "last_name", "specialty", "years_experience") VALUES (2, 'jsl', 'b4yp5qi', 'rkf9vqx5', 1836127587);

INSERT INTO "doctors" ("doctor_id", "first_name", "last_name", "specialty", "years_experience") VALUES (4, 'ilbnp', 'mdpos', 'ie5', -1209887326);

INSERT INTO "doctors" ("doctor_id", "first_name", "last_name", "specialty", "years_experience") VALUES (5, 'tliqa1', 'ryytoo3', '9hl7', 1178636309);

INSERT INTO "doctors" ("doctor_id", "first_name", "last_name", "specialty", "years_experience") VALUES (6, '8jegd21vy9ux', 'j4hwbdvlph', 'gndqwnqc', 555413010);

-- Inserting into table: appointments --
INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (-2147483648, 1, 1, '2022-12-20 09:53:17+00:00', 'b');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (-2147483647, 2, 1, '2023-11-07 12:14:47+00:00', 'zbuo4nrqrof');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (-2147483646, 3, 1, '2023-10-09 18:36:37+00:00', 'lex');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (-2147483645, 3, 1, '2023-08-25 07:55:29+00:00', 'ji7zwau2');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (-2147483644, 1, 2, '2023-06-28 05:47:44+00:00', 'f8jegd21vy9u');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (-2147483643, 3, 1, '2023-02-15 11:45:56+00:00', 'j4hwbdvlph');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (-2147483642, 1, 2, '2023-09-26 13:08:37+00:00', 'nd');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (2, 1, 1, '2022-03-02 18:03:57+00:00', 'nqcx5h');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (3, 1, 1, '2021-10-14 14:41:11+00:00', 'p');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (-2147483639, 1, 1, '2022-04-18 00:53:20+00:00', 'tu0');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (-2147483638, 1, 1, '2020-06-29 02:04:50+00:00', '79fjgq8');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (4, 4, 4, '2024-05-04 23:07:19+00:00', 'lfa');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (5, 5, 5, '2021-07-01 18:29:24+00:00', 'x1');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (6, 6, 6, '2025-09-07 08:46:54+00:00', 'hncprjtu');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT p.first_name, d.first_name FROM Appointments AS a JOIN Patients AS p ON a.patient_id = p.patient_id JOIN Doctors AS d ON a.doctor_id = d.doctor_id;

/*
Gold Result:
('p_s_0e1f20', 'd_s_b5e7a3')
('p_s_0e1f20', 'd_s_b5e7a3')
('qyp5s5bbp0', 'd_s_b5e7a3')
('qyp5s5bbp0', 'd_s_b5e7a3')
('p_s_0e1f20', 'jsl')
('qyp5s5bbp0', 'd_s_b5e7a3')
('p_s_0e1f20', 'jsl')
('p_s_0e1f20', 'd_s_b5e7a3')
('p_s_0e1f20', 'd_s_b5e7a3')
('p_s_0e1f20', 'd_s_b5e7a3')
('p_s_0e1f20', 'd_s_b5e7a3')
('5k5swwqcgs', 'ilbnp')
('9000t5c4ec', 'tliqa1')
('ji7zwau2', '8jegd21vy9ux')
*/

-- Prediction Query
SELECT p.first_name, d.first_name FROM Appointments AS a JOIN Patients AS p ON a.doctor_id = p.patient_id JOIN Doctors AS d ON a.patient_id = d.doctor_id;

/*
Prediction Result:
('p_s_0e1f20', 'd_s_b5e7a3')
('p_s_0e1f20', 'jsl')
('p_s_0e1f20', 'd_s_b5e7a3')
('p_s_0e1f20', 'd_s_b5e7a3')
('p_s_0e1f20', 'd_s_b5e7a3')
('p_s_0e1f20', 'd_s_b5e7a3')
('p_s_0e1f20', 'd_s_b5e7a3')
('p_s_0e1f20', 'd_s_b5e7a3')
('p_s_0e1f20', 'd_s_b5e7a3')
('p_s_0e1f20', 'd_s_b5e7a3')
('p_s_0e1f20', 'd_s_b5e7a3')
('5k5swwqcgs', 'ilbnp')
('9000t5c4ec', 'tliqa1')
('ji7zwau2', '8jegd21vy9ux')
*/