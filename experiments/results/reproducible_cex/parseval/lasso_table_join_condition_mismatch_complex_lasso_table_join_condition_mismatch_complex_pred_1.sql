-- Schema DDL
CREATE TABLE Patients (patient_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, date_of_birth DATE, gender TEXT);

CREATE TABLE Doctors (doctor_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, specialty TEXT, years_experience INTEGER);

CREATE TABLE Appointments (appointment_id INTEGER PRIMARY KEY, patient_id INTEGER, doctor_id INTEGER, appointment_date DATETIME, status TEXT, FOREIGN KEY (patient_id) REFERENCES Patients (patient_id), FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id));

CREATE TABLE Prescriptions (prescription_id INTEGER PRIMARY KEY, appointment_id INTEGER, medication_name TEXT, dosage TEXT, duration_days INTEGER, FOREIGN KEY (appointment_id) REFERENCES Appointments (appointment_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: patients --
INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (1, 'p_s_31e132', '5k5swwqcgs', '2021-12-04', '9n8c4pgu7v');

INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (-2147483647, 'p_s_31e132', 'p6luhvdlttil', '2020-04-02', 'nprmdposii');

INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (3, 'gce', '76nium52', '2024-06-13', 'u');

INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (2, 'p_s_31e132', '5s5b', '2020-04-03', '02eu');

INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (4, '5k5swwqcgs', '9n8', '2020-06-08', 'pgu7vfe4');

INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (-2147483643, NULL, 'hria2ypuzhs', '2023-01-03', 'wbbp6luhvdlt');

INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (5, '9000t5c4ec', 'gce', '2025-03-28', '6nium52zb');

INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (-2147483641, NULL, 'uo4nrqrofqy', '2022-09-19', 's5bbp02e');

INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (6, 'ji7zwau2', 'dwyrq13pyu78', '2020-07-21', '9rljsl0b4');

INSERT INTO "patients" ("patient_id", "first_name", "last_name", "date_of_birth", "gender") VALUES (-2147483639, NULL, 'p5qi2rk', '2021-01-15', 'vqx58pz0f');

-- Inserting into table: doctors --
INSERT INTO "doctors" ("doctor_id", "first_name", "last_name", "specialty", "years_experience") VALUES (1, 'd_s_c52461', 'e4', 'hria2ypuzhs', 700293388);

INSERT INTO "doctors" ("doctor_id", "first_name", "last_name", "specialty", "years_experience") VALUES (-2147483647, 'd_s_c52461', '5u', 'w6kl', 1620389964);

INSERT INTO "doctors" ("doctor_id", "first_name", "last_name", "specialty", "years_experience") VALUES (2, 'd_s_c52461', '1ryytoo', 'o9hl72kl', -305670381);

INSERT INTO "doctors" ("doctor_id", "first_name", "last_name", "specialty", "years_experience") VALUES (3, 'i7z', 'au2dwy', 'q13py', 244829661);

INSERT INTO "doctors" ("doctor_id", "first_name", "last_name", "specialty", "years_experience") VALUES (4, 'ilbnp', 'mdpos', 'ie5', -1209887326);

INSERT INTO "doctors" ("doctor_id", "first_name", "last_name", "specialty", "years_experience") VALUES (5, 'tliqa1', 'ryytoo3', '9hl7', 1178636309);

INSERT INTO "doctors" ("doctor_id", "first_name", "last_name", "specialty", "years_experience") VALUES (6, '8jegd21vy9ux', 'j4hwbdvlph', 'gndqwnqc', 555413010);

-- Inserting into table: appointments --
INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (-2147483648, 1, 1, '2022-12-20 09:53:17+00:00', 'b');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (-2147483647, 1, 1, '2025-05-02 19:47:39+00:00', '0t5c4ec');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (-2147483646, 3, 1, '2021-11-30 23:39:10+00:00', 'nrqrofqy');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (-2147483645, 3, 1, '2022-07-13 23:48:43+00:00', 'iqa');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (-2147483644, 1, 3, '2021-07-21 20:51:39+00:00', 'sl0');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (-2147483643, 3, 1, '2020-03-25 00:00:06+00:00', 'yp5qi2rk');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (-2147483642, 1, 3, '2020-10-15 10:13:01+00:00', 'vqx58pz0f');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (2, 1, 1, '2025-12-29 07:05:42+00:00', 'jegd21vy9');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (3, 1, 1, '2022-09-07 11:05:39+00:00', 'j4hwbd');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (-2147483639, 1, 1, '2022-10-17 07:55:28+00:00', 'ph2');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (-2147483638, 1, 1, '2020-12-04 21:49:29+00:00', 'dqwn');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (4, 4, 4, '2024-05-04 23:07:19+00:00', 'lfa');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (5, 5, 5, '2021-07-01 18:29:24+00:00', 'x1');

INSERT INTO "appointments" ("appointment_id", "patient_id", "doctor_id", "appointment_date", "status") VALUES (6, 6, 6, '2025-09-07 08:46:54+00:00', 'hncprjtu');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT p.first_name, d.first_name FROM Appointments AS a JOIN Patients AS p ON a.patient_id = p.patient_id JOIN Doctors AS d ON a.doctor_id = d.doctor_id;

/*
Gold Result:
('p_s_31e132', 'd_s_c52461')
('p_s_31e132', 'd_s_c52461')
('gce', 'd_s_c52461')
('gce', 'd_s_c52461')
('p_s_31e132', 'i7z')
('gce', 'd_s_c52461')
('p_s_31e132', 'i7z')
('p_s_31e132', 'd_s_c52461')
('p_s_31e132', 'd_s_c52461')
('p_s_31e132', 'd_s_c52461')
('p_s_31e132', 'd_s_c52461')
('5k5swwqcgs', 'ilbnp')
('9000t5c4ec', 'tliqa1')
('ji7zwau2', '8jegd21vy9ux')
*/

-- Prediction Query
SELECT p.first_name, d.first_name FROM Appointments AS a JOIN Patients AS p ON a.patient_id = a.patient_id JOIN Doctors AS d ON a.doctor_id = d.doctor_id;

/*
Prediction Result:
('p_s_31e132', 'd_s_c52461')
(None, 'd_s_c52461')
(None, 'd_s_c52461')
(None, 'd_s_c52461')
('p_s_31e132', 'd_s_c52461')
('p_s_31e132', 'd_s_c52461')
('gce', 'd_s_c52461')
('5k5swwqcgs', 'd_s_c52461')
('9000t5c4ec', 'd_s_c52461')
('ji7zwau2', 'd_s_c52461')
('p_s_31e132', 'd_s_c52461')
(None, 'd_s_c52461')
(None, 'd_s_c52461')
(None, 'd_s_c52461')
('p_s_31e132', 'd_s_c52461')
('p_s_31e132', 'd_s_c52461')
('gce', 'd_s_c52461')
('5k5swwqcgs', 'd_s_c52461')
('9000t5c4ec', 'd_s_c52461')
('ji7zwau2', 'd_s_c52461')
('p_s_31e132', 'd_s_c52461')
(None, 'd_s_c52461')
(None, 'd_s_c52461')
(None, 'd_s_c52461')
('p_s_31e132', 'd_s_c52461')
('p_s_31e132', 'd_s_c52461')
('gce', 'd_s_c52461')
('5k5swwqcgs', 'd_s_c52461')
('9000t5c4ec', 'd_s_c52461')
('ji7zwau2', 'd_s_c52461')
('p_s_31e132', 'd_s_c52461')
(None, 'd_s_c52461')
(None, 'd_s_c52461')
(None, 'd_s_c52461')
('p_s_31e132', 'd_s_c52461')
('p_s_31e132', 'd_s_c52461')
('gce', 'd_s_c52461')
('5k5swwqcgs', 'd_s_c52461')
('9000t5c4ec', 'd_s_c52461')
('ji7zwau2', 'd_s_c52461')
('p_s_31e132', 'i7z')
(None, 'i7z')
(None, 'i7z')
(None, 'i7z')
('p_s_31e132', 'i7z')
('p_s_31e132', 'i7z')
('gce', 'i7z')
('5k5swwqcgs', 'i7z')
('9000t5c4ec', 'i7z')
('ji7zwau2', 'i7z')
('p_s_31e132', 'd_s_c52461')
(None, 'd_s_c52461')
(None, 'd_s_c52461')
(None, 'd_s_c52461')
('p_s_31e132', 'd_s_c52461')
('p_s_31e132', 'd_s_c52461')
('gce', 'd_s_c52461')
('5k5swwqcgs', 'd_s_c52461')
('9000t5c4ec', 'd_s_c52461')
('ji7zwau2', 'd_s_c52461')
('p_s_31e132', 'i7z')
(None, 'i7z')
(None, 'i7z')
(None, 'i7z')
('p_s_31e132', 'i7z')
('p_s_31e132', 'i7z')
('gce', 'i7z')
('5k5swwqcgs', 'i7z')
('9000t5c4ec', 'i7z')
('ji7zwau2', 'i7z')
('p_s_31e132', 'd_s_c52461')
(None, 'd_s_c52461')
(None, 'd_s_c52461')
(None, 'd_s_c52461')
('p_s_31e132', 'd_s_c52461')
('p_s_31e132', 'd_s_c52461')
('gce', 'd_s_c52461')
('5k5swwqcgs', 'd_s_c52461')
('9000t5c4ec', 'd_s_c52461')
('ji7zwau2', 'd_s_c52461')
('p_s_31e132', 'd_s_c52461')
(None, 'd_s_c52461')
(None, 'd_s_c52461')
(None, 'd_s_c52461')
('p_s_31e132', 'd_s_c52461')
('p_s_31e132', 'd_s_c52461')
('gce', 'd_s_c52461')
('5k5swwqcgs', 'd_s_c52461')
('9000t5c4ec', 'd_s_c52461')
('ji7zwau2', 'd_s_c52461')
('p_s_31e132', 'd_s_c52461')
(None, 'd_s_c52461')
(None, 'd_s_c52461')
(None, 'd_s_c52461')
('p_s_31e132', 'd_s_c52461')
('p_s_31e132', 'd_s_c52461')
('gce', 'd_s_c52461')
('5k5swwqcgs', 'd_s_c52461')
('9000t5c4ec', 'd_s_c52461')
('ji7zwau2', 'd_s_c52461')
('p_s_31e132', 'd_s_c52461')
(None, 'd_s_c52461')
(None, 'd_s_c52461')
(None, 'd_s_c52461')
('p_s_31e132', 'd_s_c52461')
('p_s_31e132', 'd_s_c52461')
('gce', 'd_s_c52461')
('5k5swwqcgs', 'd_s_c52461')
('9000t5c4ec', 'd_s_c52461')
('ji7zwau2', 'd_s_c52461')
('p_s_31e132', 'ilbnp')
(None, 'ilbnp')
(None, 'ilbnp')
(None, 'ilbnp')
('p_s_31e132', 'ilbnp')
('p_s_31e132', 'ilbnp')
('gce', 'ilbnp')
('5k5swwqcgs', 'ilbnp')
('9000t5c4ec', 'ilbnp')
('ji7zwau2', 'ilbnp')
('p_s_31e132', 'tliqa1')
(None, 'tliqa1')
(None, 'tliqa1')
(None, 'tliqa1')
('p_s_31e132', 'tliqa1')
('p_s_31e132', 'tliqa1')
('gce', 'tliqa1')
('5k5swwqcgs', 'tliqa1')
('9000t5c4ec', 'tliqa1')
('ji7zwau2', 'tliqa1')
('p_s_31e132', '8jegd21vy9ux')
(None, '8jegd21vy9ux')
(None, '8jegd21vy9ux')
(None, '8jegd21vy9ux')
('p_s_31e132', '8jegd21vy9ux')
('p_s_31e132', '8jegd21vy9ux')
('gce', '8jegd21vy9ux')
('5k5swwqcgs', '8jegd21vy9ux')
('9000t5c4ec', '8jegd21vy9ux')
('ji7zwau2', '8jegd21vy9ux')
*/