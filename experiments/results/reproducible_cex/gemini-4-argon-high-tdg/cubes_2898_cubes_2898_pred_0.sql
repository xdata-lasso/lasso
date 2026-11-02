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
-- DATASET 3
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1, NULL, 'Astrid', 'Gruber', 'Company Z', 'Addr 1', 'Vienna', 'Wien', 'Austria', '1010', '+43 01 1000', '+43 01 9000', 'z_astrid@example.com');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (2, NULL, 'Astrid', 'Gruber', 'Company A', 'Addr 2', 'Vienna', 'Wien', 'Austria', '1020', '+43 01 9000', '+43 01 1000', 'a_astrid@example.com');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (3, NULL, 'Astrid', 'Gruber', 'Company M1', 'Addr 3', 'Vienna', 'Wien', 'Austria', '1030', '+43 01 5000', '+43 01 5001', 'm_astrid@example.com');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (4, NULL, 'Astrid', 'Gruber', 'Company M2', 'Addr 4', 'Vienna', 'Wien', 'Austria', '1040', '+43 01 2000', '+43 01 2001', 'm_astrid@example.com');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "email", "phone" FROM "customers" WHERE ("first_name" = 'Astrid' AND "last_name" = 'Gruber') ORDER BY email, customers.id NULLS LAST;

/*
Gold Result:
('a_astrid@example.com', '+43 01 9000')
('m_astrid@example.com', '+43 01 5000')
('m_astrid@example.com', '+43 01 2000')
('z_astrid@example.com', '+43 01 1000')
*/

-- Prediction Query
SELECT email, phone FROM customers WHERE first_name = 'Astrid' AND last_name = 'Gruber';

/*
Prediction Result:
('z_astrid@example.com', '+43 01 1000')
('a_astrid@example.com', '+43 01 9000')
('m_astrid@example.com', '+43 01 5000')
('m_astrid@example.com', '+43 01 2000')
*/