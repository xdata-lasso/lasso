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
INSERT INTO employees (id, reports_to, last_name, first_name, title, birth_date, hire_date, address, city, state, country, postal_code, phone, fax, email) VALUES (1, NULL, 'Anderson', 'Alice', 'Manager', '1980-01-01 00:00:00', '2010-01-01 00:00:00', '100 Main St', 'Seattle', 'WA', 'USA', '98101', '111-1111', '111-1112', 'alice@company.com');
INSERT INTO employees (id, reports_to, last_name, first_name, title, birth_date, hire_date, address, city, state, country, postal_code, phone, fax, email) VALUES (2, 1, 'Brown', 'Bob', 'Sales Rep', '1985-02-02 00:00:00', '2012-02-02 00:00:00', '200 Oak Ave', 'Toronto', 'ON', 'Canada', 'M5V', '222-2222', '222-2223', 'bob@company.com');
INSERT INTO employees (id, reports_to, last_name, first_name, title, birth_date, hire_date, address, city, state, country, postal_code, phone, fax, email) VALUES (3, 1, 'Clark', 'Charlie', 'Sales Rep', '1990-03-03 00:00:00', '2015-03-03 00:00:00', '300 High St', 'London', NULL, 'UK', 'SW1A', '333-3333', '333-3334', 'charlie@company.com');
INSERT INTO employees (id, reports_to, last_name, first_name, title, birth_date, hire_date, address, city, state, country, postal_code, phone, fax, email) VALUES (4, 1, 'Davis', 'David', 'IT Staff', '1992-04-04 00:00:00', '2018-04-04 00:00:00', '400 Rue Rivoli', 'Paris', NULL, 'France', '75001', '444-4444', '444-4445', 'david@company.com');
INSERT INTO customers (id, support_rep_id, first_name, last_name, company, address, city, state, country, postal_code, phone, fax, email) VALUES (1, 2, 'CustAlice', 'CustAnderson', 'Acme Corp', '900 Elm St', 'Boston', 'MA', 'USA', '02101', '555-1111', '555-1112', 'custalice@client.com');
INSERT INTO customers (id, support_rep_id, first_name, last_name, company, address, city, state, country, postal_code, phone, fax, email) VALUES (2, 2, 'CustBob', 'CustBrown', 'Beta Inc', '800 Reforma', 'Mexico City', 'CDMX', 'Mexico', '06600', '555-2222', '555-2223', 'custbob@client.com');
INSERT INTO customers (id, support_rep_id, first_name, last_name, company, address, city, state, country, postal_code, phone, fax, email) VALUES (10, 3, 'CustCharlie', 'CustClark', 'Gamma Ltd', '700 Fleet St', 'London', NULL, 'UK', 'EC4Y', '555-3333', '555-3334', 'custcharlie@client.com');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name, last_name FROM (SELECT LHS.id AS id, LHS.last_name AS last_name, LHS.first_name AS first_name, LHS.title AS title, LHS.reports_to AS reports_to, LHS.birth_date AS birth_date, LHS.hire_date AS hire_date, LHS.address AS address, LHS.city AS city, LHS.state AS state, LHS.country AS country, LHS.postal_code AS postal_code, LHS.phone AS phone, LHS.fax AS fax, LHS.email AS email, RHS.n AS n FROM employees AS LHS INNER JOIN (SELECT country, id, COUNT(*) AS n FROM customers GROUP BY country, id) AS RHS ON (LHS.id = RHS.id AND LHS.country = RHS.country)) ORDER BY first_name, last_name NULLS LAST;

/*
Gold Result:
('Alice', 'Anderson')
*/

-- Prediction Query
SELECT T1.first_name, T1.last_name FROM employees AS T1 JOIN customers AS T2 ON T1.id = T2.support_rep_id GROUP BY T1.id ORDER BY COUNT(*) DESC, T1.first_name NULLS LAST, T1.last_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Bob', 'Brown')
*/