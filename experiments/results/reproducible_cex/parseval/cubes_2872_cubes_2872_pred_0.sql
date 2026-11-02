-- Schema DDL
CREATE TABLE "artists" ("id" INTEGER PRIMARY KEY, "name" TEXT(120));

CREATE TABLE "albums" ("id" INTEGER PRIMARY KEY, "artist_id" INTEGER, "title" TEXT(160), FOREIGN KEY ("artist_id") REFERENCES "artists" ("id"));

CREATE TABLE "employees" ("id" INTEGER PRIMARY KEY, "reports_to" INTEGER, "last_name" TEXT(20), "first_name" TEXT(20), "title" TEXT(30), "birth_date" TIMESTAMP, "hire_date" TIMESTAMP, "address" TEXT(70), "city" TEXT(40), "state" TEXT(40), "country" TEXT(40), "postal_code" TEXT(10), "phone" TEXT(24), "fax" TEXT(24), "email" TEXT(60), FOREIGN KEY ("reports_to") REFERENCES "employees" ("id"));

CREATE TABLE "customers" ("id" INTEGER PRIMARY KEY, "support_rep_id" INTEGER, "first_name" TEXT(40), "last_name" TEXT(20), "company" TEXT(80), "address" TEXT(70), "city" TEXT(40), "state" TEXT(40), "country" TEXT(40), "postal_code" TEXT(10), "phone" TEXT(24), "fax" TEXT(24), "email" TEXT(60), FOREIGN KEY ("support_rep_id") REFERENCES "employees" ("id"));

CREATE TABLE "genres" ("id" INTEGER PRIMARY KEY, "name" TEXT(120));

CREATE TABLE "invoices" ("id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "invoice_date" TIMESTAMP, "billing_address" TEXT(70), "billing_city" TEXT(40), "billing_state" TEXT(40), "billing_country" TEXT(40), "billing_postal_code" TEXT(10), "total" REAL(10, 2), FOREIGN KEY ("customer_id") REFERENCES "customers" ("id"));

CREATE TABLE "media_types" ("id" INTEGER PRIMARY KEY, "name" TEXT(120));

CREATE TABLE "tracks" ("id" INTEGER PRIMARY KEY, "media_type_id" INTEGER, "genre_id" INTEGER, "album_id" INTEGER, "name" TEXT(200), "composer" TEXT(220), "milliseconds" INTEGER, "bytes" INTEGER, "unit_price" REAL(10, 2), FOREIGN KEY ("media_type_id") REFERENCES "media_types" ("id"), FOREIGN KEY ("genre_id") REFERENCES "genres" ("id"), FOREIGN KEY ("album_id") REFERENCES "albums" ("id"));

CREATE TABLE "invoice_lines" ("id" INTEGER PRIMARY KEY, "track_id" INTEGER, "invoice_id" INTEGER, "unit_price" REAL(10, 2), "quantity" INTEGER, FOREIGN KEY ("track_id") REFERENCES "tracks" ("id"), FOREIGN KEY ("invoice_id") REFERENCES "invoices" ("id"));

CREATE TABLE "playlists" ("id" INTEGER PRIMARY KEY, "name" TEXT(120));

CREATE TABLE "playlist_tracks" ("playlist_id" INTEGER, "track_id" INTEGER, PRIMARY KEY ("playlist_id", "track_id"), FOREIGN KEY ("track_id") REFERENCES "tracks" ("id"), FOREIGN KEY ("playlist_id") REFERENCES "playlists" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: employees --
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1, NULL, 'emp_0e5b50', 'emp_70f383', 'value', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'value');

INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (2, NULL, 'emp_0e5b50', 'emp_70f383', 'value', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'value');

INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (-2147483647, NULL, 'emp_6f5b57', 'emp_178039', 'value', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'value');

INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (0, NULL, 'emp_0e5b50', 'emp_70f383', 'value', '2024-06-15 00:00:00+00:00', '1969-12-31 23:59:59+00:00', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'value');

INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (-2147483645, NULL, 'emp_6f5b57', 'emp_178039', 'value', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'value');

INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (-2147483643, NULL, 'emp_6f5b57', 'emp_178039', 'value', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'value');

INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (-1, NULL, 'emp_0e5b50', 'emp_70f383', 'value', '2024-06-15 00:00:00+00:00', '1970-01-01 00:00:00+00:00', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'value');

INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (-2147483642, NULL, 'emp_6f38b3', 'emp_a3ffe7', 'value', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'value');

INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (-2147483657, NULL, 'value', 'value', 'value', '2024-06-15 00:00:00+00:00', '1970-01-01 00:00:00+00:00', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'value');

INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (-2147483655, NULL, 'value', 'value', 'value', '2024-06-15 00:00:00+00:00', '1970-01-01 02:08:39+00:00', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'value');

INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (-2147483653, NULL, 'value', 'value', 'value', '2024-06-15 00:00:00+00:00', '1970-01-01 05:53:58+00:00', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'value');

INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (-2147483656, NULL, 'value', 'value', 'value', '2024-06-15 00:00:00+00:00', '1970-01-01 00:40:37+00:00', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'value');

INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (-2147483654, NULL, 'value', 'value', 'value', '2024-06-15 00:00:00+00:00', '1970-01-01 02:27:35+00:00', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'value');

INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (-2147483648, NULL, 'value', 'value', 'value', '2024-06-15 00:00:00+00:00', '1970-01-01 03:16:37+00:00', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'value');

INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (-2147483652, NULL, 'value', 'value', 'value', '2024-06-15 00:00:00+00:00', '1970-01-01 02:19:25+00:00', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'value');

INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (-2147483649, NULL, 'value', 'value', 'value', '2024-06-15 00:00:00+00:00', '1970-01-01 08:58:05+00:00', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'value');

INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (-2147483650, NULL, 'value', 'value', 'value', '2024-06-15 00:00:00+00:00', '1970-01-01 02:54:10+00:00', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'value');

INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (-2147483651, NULL, 'value', 'value', 'value', '2024-06-15 00:00:00+00:00', '1970-01-01 08:30:12+00:00', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'value');

INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (3, NULL, 'value', NULL, 'value', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'value');

INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (4, NULL, NULL, 'value', 'value', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'value');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name, last_name FROM (SELECT * FROM (SELECT * FROM employees ORDER BY first_name, employees.id NULLS LAST) LIMIT 8);

/*
Gold Result:
(None, 'value')
('emp_178039', 'emp_6f5b57')
('emp_178039', 'emp_6f5b57')
('emp_178039', 'emp_6f5b57')
('emp_70f383', 'emp_0e5b50')
('emp_70f383', 'emp_0e5b50')
('emp_70f383', 'emp_0e5b50')
('emp_70f383', 'emp_0e5b50')
*/

-- Prediction Query
SELECT first_name, last_name FROM employees ORDER BY hire_date ASC, employees.id NULLS LAST LIMIT 10;

/*
Prediction Result:
('emp_70f383', 'emp_0e5b50')
('value', 'value')
('emp_70f383', 'emp_0e5b50')
('value', 'value')
('value', 'value')
('value', 'value')
('value', 'value')
('value', 'value')
('value', 'value')
('value', 'value')
*/