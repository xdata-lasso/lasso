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
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1, NULL, 'Adams', 'Andrew', 'General Manager', '1962-02-18 00:00:00', '2002-08-14 00:00:00', '11120 Jasper Ave NW', 'Prague', 'S1', 'Czech Republic', '11000', '+420 2 111 222', '+420 2 111 223', 'andrew@chinookcorp.com');
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (2, 1, 'Edwards', 'Nancy', 'Sales Manager', '1958-12-08 00:00:00', '2002-05-01 00:00:00', '825 8 Ave SW', 'Berlin', 'BE', 'Germany', '10115', '+49 30 111 222', '+49 30 111 223', 'nancy@chinookcorp.com');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1, 1, 'Frantisek', 'Wichterlová', 'JetBrains s.r.o.', 'Klanova 9/506', 'Prague', 'S1', 'Czech Republic', '14700', '+420 2 4172 5555', '+420 2 4172 5555', 'frantisekw@jetbrains.com');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (2, NULL, 'Helena', 'Holý', NULL, 'Rilská 3174/6', 'Prague', 'S1', 'Czech Republic', '14300', NULL, NULL, 'hholy@gmail.com');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (3, 2, 'Jan', 'Novák', 'Avast', 'Vodičkova 10', 'Prague', 'S1', 'Czech Republic', '11000', '+420 2 3333 4444', NULL, 'jnovak@avast.com');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (4, 1, 'Karel', 'Dvořák', NULL, 'Dlouhá 5', 'Prague', 'S2', 'Czech Republic', '11000', '+420 2 5555 6666', NULL, 'kdvorak@seznam.cz');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (5, 2, 'Petra', 'Černá', 'Škoda', 'Národní 1', 'Prague', 'S3', 'Czech Republic', '11000', '+420 2 7777 8888', NULL, 'pcerna@skoda.cz');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (6, NULL, 'Lukáš', 'Svoboda', NULL, 'Ječná 12', 'Prague', 'S3', 'Czech Republic', '12000', '+420 2 9999 0000', NULL, 'lsvoboda@centrum.cz');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (7, 1, 'Eva', 'Kučerová', NULL, 'Masarykova 2', 'Brno', 'S2', 'Czech Republic', '60200', '+420 5 1111 2222', NULL, 'ekucerova@gmail.com');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (8, 1, 'Tomáš', 'Veselý', NULL, 'Česká 8', 'Brno', 'S2', 'Czech Republic', '60200', '+420 5 3333 4444', NULL, 'tvesely@gmail.com');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (9, 2, 'Astrid', 'Gruber', NULL, 'Rotenturmstraße 4', 'Vienna', 'Prague', 'Prague', '1010', '+43 01 5134505', NULL, 'astrid.gruber@apple.at');
INSERT INTO "invoices" ("id", "customer_id", "invoice_date", "billing_address", "billing_city", "billing_state", "billing_country", "billing_postal_code", "total") VALUES (1, 4, '2021-01-01 00:00:00', 'Dlouhá 5', 'Prague', 'S2', 'Czech Republic', '11000', 5.94);
INSERT INTO "invoices" ("id", "customer_id", "invoice_date", "billing_address", "billing_city", "billing_state", "billing_country", "billing_postal_code", "total") VALUES (2, 4, '2021-02-01 00:00:00', 'Dlouhá 5', 'Prague', 'S2', 'Czech Republic', '11000', 3.96);
INSERT INTO "invoices" ("id", "customer_id", "invoice_date", "billing_address", "billing_city", "billing_state", "billing_country", "billing_postal_code", "total") VALUES (3, 4, '2021-03-01 00:00:00', 'Dlouhá 5', 'Prague', 'S2', 'Czech Republic', '11000', 1.98);
INSERT INTO "invoices" ("id", "customer_id", "invoice_date", "billing_address", "billing_city", "billing_state", "billing_country", "billing_postal_code", "total") VALUES (4, 7, '2021-04-01 00:00:00', 'Klanova 9/506', 'Prague', 'S4', 'Czech Republic', '14700', 8.91);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "state", COUNT(*) AS "n" FROM (SELECT * FROM "customers" WHERE ("city" = 'Prague')) GROUP BY state) ORDER BY count___;

/*
Gold Result:
(1,)
(2,)
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM customers WHERE city = 'Prague';

/*
Prediction Result:
(6,)
*/