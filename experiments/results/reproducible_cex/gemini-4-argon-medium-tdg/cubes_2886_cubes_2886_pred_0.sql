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
-- Tests DISTINCT vs ALL (duplicate countries), ORDER BY country ASC vs DESC, NULL handling in country, and 1-to-N join multiplication with invoices.
INSERT INTO "employees" ("id", "first_name", "last_name", "country") VALUES (1, 'Jane', 'Peacock', 'Canada');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "country") VALUES (10, 1, 'Roberto', 'Almeida', 'USA');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "country") VALUES (20, 1, 'Roberto', 'Almeida', 'Brazil');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "country") VALUES (30, 1, 'Roberto', 'Almeida', 'Brazil');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "country") VALUES (40, 1, 'Roberto', 'Almeida', NULL);
INSERT INTO "invoices" ("id", "customer_id", "billing_country", "total") VALUES (100, 20, 'Germany', 10.00);
INSERT INTO "invoices" ("id", "customer_id", "billing_country", "total") VALUES (101, 20, 'France', 20.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "country" FROM "customers" WHERE ("first_name" = 'Roberto' AND "last_name" = 'Almeida') ORDER BY country, customers.id NULLS LAST;

/*
Gold Result:
(None,)
('Brazil',)
('Brazil',)
('USA',)
*/

-- Prediction Query
SELECT country FROM customers WHERE first_name = 'Roberto' AND last_name = 'Almeida';

/*
Prediction Result:
('USA',)
('Brazil',)
('Brazil',)
(None,)
*/