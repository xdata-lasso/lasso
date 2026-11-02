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
-- DATASET 1
INSERT INTO employees (id, reports_to, last_name, first_name, title, birth_date, hire_date, address, city, state, country, postal_code, phone, fax, email) VALUES (1, NULL, 'Anderson', 'Charlie', 'General Manager', '1965-02-18 00:00:00', '2002-08-14 00:00:00', '100 Main St', 'Edmonton', 'AB', 'Canada', 'T5K 2N1', '+1 (780) 428-9482', '+1 (780) 428-3457', 'charlie@chinookcorp.com');
INSERT INTO employees (id, reports_to, last_name, first_name, title, birth_date, hire_date, address, city, state, country, postal_code, phone, fax, email) VALUES (2, 1, 'Zebra', 'Alice', 'Sales Manager', '1970-12-08 00:00:00', '2002-05-01 00:00:00', '200 Oak Ave', 'Calgary', 'AB', 'Canada', 'T2P 2T3', '+1 (403) 262-3443', '+1 (403) 262-3322', 'alice.z@chinookcorp.com');
INSERT INTO employees (id, reports_to, last_name, first_name, title, birth_date, hire_date, address, city, state, country, postal_code, phone, fax, email) VALUES (3, 1, 'Baker', 'Bob', 'IT Manager', '1973-08-29 00:00:00', '2003-10-17 00:00:00', '300 Pine Rd', 'Calgary', 'AB', 'Canada', 'T2P 5M5', '+1 (403) 263-4423', '+1 (403) 263-4289', 'bob@chinookcorp.com');
INSERT INTO employees (id, reports_to, last_name, first_name, title, birth_date, hire_date, address, city, state, country, postal_code, phone, fax, email) VALUES (10, 2, 'Adams', 'Alice', 'Sales Support Agent', '1978-09-19 00:00:00', '2003-05-03 00:00:00', '400 Elm St', 'Calgary', 'AB', 'Canada', 'T2P 5G3', '+1 (403) 263-4400', '+1 (403) 263-4401', 'alice.a@chinookcorp.com');
INSERT INTO employees (id, reports_to, last_name, first_name, title, birth_date, hire_date, address, city, state, country, postal_code, phone, fax, email) VALUES (15, 2, 'Zebra', 'Alice', 'Sales Support Agent', '1982-03-03 00:00:00', '2004-01-02 00:00:00', '500 Maple Dr', 'Lethbridge', 'AB', 'Canada', 'T1H 1Y8', '+1 (403) 456-9986', '+1 (403) 456-8485', 'alice.z2@chinookcorp.com');
INSERT INTO employees (id, reports_to, last_name, first_name, title, birth_date, hire_date, address, city, state, country, postal_code, phone, fax, email) VALUES (20, 3, 'Miller', 'Alice', 'IT Staff', '1985-07-01 00:00:00', '2004-03-04 00:00:00', '600 Cedar Ln', 'Lethbridge', 'AB', 'Canada', 'T1K 5N8', '+1 (403) 467-3351', '+1 (403) 467-8772', 'alice.m@chinookcorp.com');
INSERT INTO customers (id, support_rep_id, first_name, last_name, company, address, city, state, country, postal_code, phone, fax, email) VALUES (1, 10, 'Xavier', 'CustomerOne', 'Acme Corp', '10 First St', 'New York', 'NY', 'USA', '10001', '+1 (212) 555-0101', NULL, 'xavier@example.com');
INSERT INTO customers (id, support_rep_id, first_name, last_name, company, address, city, state, country, postal_code, phone, fax, email) VALUES (2, 10, 'Yvonne', 'CustomerTwo', NULL, '20 Second St', 'Boston', 'MA', 'USA', '02108', '+1 (617) 555-0102', NULL, 'yvonne@example.com');
INSERT INTO customers (id, support_rep_id, first_name, last_name, company, address, city, state, country, postal_code, phone, fax, email) VALUES (3, 15, 'Zach', 'CustomerThree', 'Beta LLC', '30 Third St', 'Chicago', 'IL', 'USA', '60601', '+1 (312) 555-0103', NULL, 'zach@example.com');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name, last_name FROM employees ORDER BY first_name, employees.id NULLS LAST;

/*
Gold Result:
('Alice', 'Zebra')
('Alice', 'Adams')
('Alice', 'Zebra')
('Alice', 'Miller')
('Bob', 'Baker')
('Charlie', 'Anderson')
*/

-- Prediction Query
SELECT first_name, last_name FROM employees ORDER BY hire_date ASC, employees.id NULLS LAST LIMIT 10;

/*
Prediction Result:
('Alice', 'Zebra')
('Charlie', 'Anderson')
('Alice', 'Adams')
('Bob', 'Baker')
('Alice', 'Zebra')
('Alice', 'Miller')
*/