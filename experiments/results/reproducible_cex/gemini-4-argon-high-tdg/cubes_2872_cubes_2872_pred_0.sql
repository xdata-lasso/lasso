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
INSERT INTO employees (id, reports_to, last_name, first_name, title, country) VALUES (50, NULL, 'Smith', 'Alice', 'General Manager', 'Canada');
INSERT INTO employees (id, reports_to, last_name, first_name, title, country) VALUES (10, NULL, 'Zimmer', 'Grace', 'IT Manager', 'USA');
INSERT INTO employees (id, reports_to, last_name, first_name, title, country) VALUES (5, 50, 'Zane', 'Bob', 'Sales Manager', 'Canada');
INSERT INTO employees (id, reports_to, last_name, first_name, title, country) VALUES (20, 50, 'Adams', 'Bob', 'Sales Support Agent', 'Canada');
INSERT INTO employees (id, reports_to, last_name, first_name, title, country) VALUES (40, 5, 'Brown', 'Charlie', 'Sales Support Agent', 'USA');
INSERT INTO employees (id, reports_to, last_name, first_name, title, country) VALUES (15, 5, 'Prince', 'Diana', 'IT Staff', 'Canada');
INSERT INTO employees (id, reports_to, last_name, first_name, title, country) VALUES (35, 20, 'Wright', 'Evan', 'IT Staff', 'UK');
INSERT INTO employees (id, reports_to, last_name, first_name, title, country) VALUES (25, 20, 'Gallagher', 'Fiona', 'Sales Support Agent', 'Canada');
INSERT INTO employees (id, reports_to, last_name, first_name, title, country) VALUES (30, 10, 'Abbott', 'Grace', 'IT Staff', 'USA');
INSERT INTO employees (id, reports_to, last_name, first_name, title, country) VALUES (1, 10, 'Ford', 'Henry', 'Sales Support Agent', 'Canada');
INSERT INTO customers (id, support_rep_id, first_name, last_name, country) VALUES (1, 1, 'Aaron', 'CustomerOne', 'Canada');
INSERT INTO customers (id, support_rep_id, first_name, last_name, country) VALUES (2, 1, 'abigail', 'CustomerTwo', 'USA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name, last_name FROM (SELECT * FROM (SELECT * FROM employees ORDER BY first_name, employees.id NULLS LAST) LIMIT 8);

/*
Gold Result:
('Alice', 'Smith')
('Bob', 'Zane')
('Bob', 'Adams')
('Charlie', 'Brown')
('Diana', 'Prince')
('Evan', 'Wright')
('Fiona', 'Gallagher')
('Grace', 'Zimmer')
*/

-- Prediction Query
SELECT first_name, last_name FROM employees ORDER BY hire_date ASC, employees.id NULLS LAST LIMIT 10;

/*
Prediction Result:
('Henry', 'Ford')
('Bob', 'Zane')
('Grace', 'Zimmer')
('Diana', 'Prince')
('Bob', 'Adams')
('Fiona', 'Gallagher')
('Grace', 'Abbott')
('Evan', 'Wright')
('Charlie', 'Brown')
('Alice', 'Smith')
*/