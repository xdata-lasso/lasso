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
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1, 1, 'lhs_447da6', 'lhs_e43221', 'lhs_bb270a', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'lhs_1c1451', 'lhs_3b59aa', 'lhs_feef91', 'lhs_806bdd', 'lhs_5a937e', 'lhs_68ed87', 'lhs_7228f0', 'lhs_196318');

INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (2, NULL, 'value', 'value', 'value', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'value');

INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (3, NULL, 'value', 'value', 'value', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'value');

INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (4, NULL, 'value', 'value', 'value', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'value');

INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (5, NULL, 'value', 'value', 'value', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'value');

INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (6, NULL, 'value', 'value', 'value', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'value');

INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (7, NULL, 'value', 'value', 'value', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'value');

INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (8, NULL, 'value', 'value', 'value', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'value');

INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (9, NULL, 'value', 'value', 'value', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'value');

INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (10, NULL, 'value', 'value', 'value', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'value');

INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (11, NULL, 'value', 'value', 'value', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'value');

-- Inserting into table: customers --
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1, 1, 'cus_07f476', 'cus_db7f25', 'cus_20b3c3', 'cus_2a6034', 'cus_e18ef9', 'cus_8126f7', 'cus_5ba0cf', 'cus_0ed5f7', 'cus_986f40', 'cus_ab9c96', 'cus_b3f7b1');

INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (2, 1, 'cus_07f476', 'cus_db7f25', 'cus_20b3c3', 'cus_2a6034', 'cus_e18ef9', 'cus_8126f7', 'cus_e91d2f', 'cus_0ed5f7', 'cus_986f40', 'cus_ab9c96', 'cus_b3f7b1');

INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (3, 3, 'cus_07f476', 'cus_db7f25', 'cus_20b3c3', 'cus_2a6034', 'cus_e18ef9', 'cus_8126f7', 'cus_e91d2f', 'cus_0ed5f7', 'cus_986f40', 'cus_ab9c96', 'cus_b3f7b1');

INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (4, 1, 'cus_07f476', 'cus_db7f25', 'cus_20b3c3', 'cus_2a6034', 'cus_e18ef9', 'cus_8126f7', 'cus_e91d2f', 'cus_0ed5f7', 'cus_986f40', 'cus_ab9c96', 'cus_b3f7b1');

INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (5, 2, 'cus_07f476', 'cus_db7f25', 'cus_20b3c3', 'cus_2a6034', 'cus_e18ef9', 'cus_8126f7', 'cus_e91d2f', 'cus_0ed5f7', 'cus_986f40', 'cus_ab9c96', 'cus_b3f7b1');

INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (6, 2, 'cus_07f476', 'cus_db7f25', 'cus_20b3c3', 'cus_2a6034', 'cus_e18ef9', 'cus_8126f7', 'cus_e91d2f', 'cus_0ed5f7', 'cus_986f40', 'cus_ab9c96', 'cus_b3f7b1');

INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (7, 5, 'cus_07f476', 'cus_db7f25', 'cus_20b3c3', 'cus_2a6034', 'cus_e18ef9', 'cus_8126f7', 'cus_e91d2f', 'cus_0ed5f7', 'cus_986f40', 'cus_ab9c96', 'cus_b3f7b1');

INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (8, 5, 'cus_07f476', 'cus_db7f25', 'cus_20b3c3', 'cus_2a6034', 'cus_e18ef9', 'cus_8126f7', 'cus_e91d2f', 'cus_0ed5f7', 'cus_986f40', 'cus_ab9c96', 'cus_b3f7b1');

INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (9, 3, 'cus_07f476', 'cus_db7f25', 'cus_20b3c3', 'cus_2a6034', 'cus_e18ef9', 'cus_8126f7', 'cus_e91d2f', 'cus_0ed5f7', 'cus_986f40', 'cus_ab9c96', 'cus_b3f7b1');

INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (10, 3, 'cus_07f476', 'cus_db7f25', 'cus_20b3c3', 'cus_2a6034', 'cus_e18ef9', 'cus_8126f7', 'cus_e91d2f', 'cus_0ed5f7', 'cus_986f40', 'cus_ab9c96', 'cus_b3f7b1');

INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (11, 2, 'cus_07f476', 'cus_db7f25', 'cus_20b3c3', 'cus_2a6034', 'cus_e18ef9', 'cus_8126f7', 'cus_e91d2f', 'cus_0ed5f7', 'cus_986f40', 'cus_ab9c96', 'cus_b3f7b1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name, last_name FROM (SELECT LHS.id AS id, LHS.last_name AS last_name, LHS.first_name AS first_name, LHS.title AS title, LHS.reports_to AS reports_to, LHS.birth_date AS birth_date, LHS.hire_date AS hire_date, LHS.address AS address, LHS.city AS city, LHS.state AS state, LHS.country AS country, LHS.postal_code AS postal_code, LHS.phone AS phone, LHS.fax AS fax, LHS.email AS email, RHS.n AS n FROM employees AS LHS INNER JOIN (SELECT country, id, COUNT(*) AS n FROM customers GROUP BY country, id) AS RHS ON (LHS.id = RHS.id AND LHS.country = RHS.country)) ORDER BY first_name, last_name NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.first_name, T1.last_name FROM employees AS T1 JOIN customers AS T2 ON T1.id = T2.support_rep_id GROUP BY T1.id ORDER BY COUNT(*) DESC, T1.first_name NULLS LAST, T1.last_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('lhs_e43221', 'lhs_447da6')
*/