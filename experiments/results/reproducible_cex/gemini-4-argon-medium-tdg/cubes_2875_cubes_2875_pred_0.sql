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
-- DATASET 2
-- Tests ORDER BY first_name, last_name NULLS LAST, including duplicate names (testing DISTINCT vs ALL) and NULL handling in sorting and joining.
INSERT INTO employees (id, first_name, last_name, country) VALUES (1, 'Alice', 'Zebra', 'USA');
INSERT INTO employees (id, first_name, last_name, country) VALUES (2, 'Alice', 'Apple', 'USA');
INSERT INTO employees (id, first_name, last_name, country) VALUES (3, 'Alice', NULL, 'USA');
INSERT INTO employees (id, first_name, last_name, country) VALUES (4, 'Bob', 'Builder', 'UK');
INSERT INTO employees (id, first_name, last_name, country) VALUES (5, 'Bob', 'Builder', 'Canada');
INSERT INTO employees (id, first_name, last_name, country) VALUES (6, NULL, 'NoFirst', 'USA');
INSERT INTO employees (id, first_name, last_name, country) VALUES (7, 'NullCountry', 'Test', NULL);
INSERT INTO customers (id, support_rep_id, first_name, last_name, country) VALUES (1, 1, 'C1', 'L1', 'USA');
INSERT INTO customers (id, support_rep_id, first_name, last_name, country) VALUES (2, 1, 'C2', 'L2', 'USA');
INSERT INTO customers (id, support_rep_id, first_name, last_name, country) VALUES (3, 1, 'C3', 'L3', 'USA');
INSERT INTO customers (id, support_rep_id, first_name, last_name, country) VALUES (4, 1, 'C4', 'L4', 'UK');
INSERT INTO customers (id, support_rep_id, first_name, last_name, country) VALUES (5, 1, 'C5', 'L5', 'Canada');
INSERT INTO customers (id, support_rep_id, first_name, last_name, country) VALUES (6, 1, 'C6', 'L6', 'USA');
-- Both employee 7 and customer 7 have NULL country; standard SQL '=' must NOT match NULL with NULL
INSERT INTO customers (id, support_rep_id, first_name, last_name, country) VALUES (7, 1, 'C7', 'L7', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name, last_name FROM (SELECT LHS.id AS id, LHS.last_name AS last_name, LHS.first_name AS first_name, LHS.title AS title, LHS.reports_to AS reports_to, LHS.birth_date AS birth_date, LHS.hire_date AS hire_date, LHS.address AS address, LHS.city AS city, LHS.state AS state, LHS.country AS country, LHS.postal_code AS postal_code, LHS.phone AS phone, LHS.fax AS fax, LHS.email AS email, RHS.n AS n FROM employees AS LHS INNER JOIN (SELECT country, id, COUNT(*) AS n FROM customers GROUP BY country, id) AS RHS ON (LHS.id = RHS.id AND LHS.country = RHS.country)) ORDER BY first_name, last_name NULLS LAST;

/*
Gold Result:
(None, 'NoFirst')
('Alice', 'Apple')
('Alice', 'Zebra')
('Alice', None)
('Bob', 'Builder')
('Bob', 'Builder')
*/

-- Prediction Query
SELECT T1.first_name, T1.last_name FROM employees AS T1 JOIN customers AS T2 ON T1.id = T2.support_rep_id GROUP BY T1.id ORDER BY COUNT(*) DESC, T1.first_name NULLS LAST, T1.last_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alice', 'Zebra')
*/