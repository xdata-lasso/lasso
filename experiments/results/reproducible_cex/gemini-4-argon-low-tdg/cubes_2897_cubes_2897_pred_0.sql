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
-- Comprehensive dataset testing:
-- 1. COUNT(*) vs COUNT(state) via NULL states in 'Prague'
-- 2. ORDER BY ASC vs DESC via distinct count sizes (3, 1, 2)
-- 3. Duplicate counts in output (SELECT vs SELECT DISTINCT) via two states having count 2
-- 4. WHERE city = 'Prague' vs other cities, NULL city, and case sensitivity ('prague')
-- 5. Unjoined tables (customers with 0 vs multiple invoices, employees with 0 customers)
INSERT INTO "employees" ("id", "last_name", "first_name", "city", "state") VALUES (1, 'Adams', 'Andrew', 'Prague', 'S1');
INSERT INTO "employees" ("id", "last_name", "first_name", "city", "state") VALUES (2, 'Edwards', 'Nancy', 'Calgary', 'AB');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "city", "state") VALUES (1, 1, 'Jan', 'Novak', 'Prague', NULL);
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "city", "state") VALUES (2, 1, 'Petr', 'Svoboda', 'Prague', NULL);
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "city", "state") VALUES (3, NULL, 'Eva', 'Dvorakova', 'Prague', NULL);
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "city", "state") VALUES (4, 1, 'Tomas', 'Cerny', 'Prague', 'S1');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "city", "state") VALUES (5, 1, 'Lucie', 'Prochazkova', 'Prague', 'S2');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "city", "state") VALUES (6, NULL, 'Karel', 'Kucera', 'Prague', 'S2');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "city", "state") VALUES (7, 1, 'Marie', 'Vesela', 'Prague', 'S3');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "city", "state") VALUES (8, 1, 'Jiri', 'Horak', 'Prague', 'S3');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "city", "state") VALUES (9, 1, 'Hans', 'Muller', 'Berlin', 'S1');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "city", "state") VALUES (10, 1, 'Anna', 'Schmidt', 'Berlin', 'S1');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "city", "state") VALUES (11, 1, 'Paul', 'Weber', 'Berlin', 'S4');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "city", "state") VALUES (12, 1, 'John', 'Doe', NULL, 'S1');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "city", "state") VALUES (13, 1, 'Jane', 'Doe', 'prague', 'S1');
INSERT INTO "invoices" ("id", "customer_id", "billing_city", "billing_state", "total") VALUES (1, 4, 'Prague', 'S1', 10.00);
INSERT INTO "invoices" ("id", "customer_id", "billing_city", "billing_state", "total") VALUES (2, 4, 'Prague', 'S1', 20.00);
INSERT INTO "invoices" ("id", "customer_id", "billing_city", "billing_state", "total") VALUES (3, 9, 'Prague', 'S1', 15.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "state", COUNT(*) AS "n" FROM (SELECT * FROM "customers" WHERE ("city" = 'Prague')) GROUP BY state) ORDER BY count___;

/*
Gold Result:
(1,)
(2,)
(2,)
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM customers WHERE city = 'Prague';

/*
Prediction Result:
(8,)
*/