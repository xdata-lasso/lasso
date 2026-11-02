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
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1, NULL, 'Martins', 'Eduardo', 'Sales Support Agent', '1970-05-10 00:00:00', '2010-03-01 00:00:00', '100 King St', 'Toronto', 'ON', 'Canada', 'M5X 1A9', '+1 (416) 555-0100', '+1 (416) 555-0101', 'eduardo.emp@chinookcorp.com');
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (2, 1, 'Peacock', 'Jane', 'Sales Support Agent', '1973-08-29 00:00:00', '2002-04-01 00:00:00', '1111 6 Ave SW', 'Calgary', 'AB', 'Canada', 'T2P 5M5', '+1 (403) 262-3443', '+1 (403) 262-6712', 'jane@chinookcorp.com');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1, NULL, 'Eduardo', 'Martins', 'NoRep NoInvoice Co', '123 Unlinked Way', 'Sao Paulo', 'SP', 'Brazil', '01000-000', '+55 (11) 9999-0001', NULL, 'eduardo1@norep.com');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (2, 1, 'John', 'Doe', 'Employee Name Trap Co', '456 Client Rd', 'Toronto', 'ON', 'Canada', 'M5V 2T6', '+1 (416) 555-0199', NULL, 'john@trap.com');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (3, 2, 'Eduardo', 'Martins', 'Multi Invoice Co', '789 Busy Ave', 'Brasilia', 'DF', 'Brazil', '70000-000', '+55 (61) 8888-0002', NULL, 'eduardo3@multi.com');
INSERT INTO "invoices" ("id", "customer_id", "invoice_date", "billing_address", "billing_city", "billing_state", "billing_country", "billing_postal_code", "total") VALUES (1, 2, '2022-02-01 00:00:00', '456 Client Rd', 'Toronto', 'ON', 'Canada', 'M5V 2T6', 10.00);
INSERT INTO "invoices" ("id", "customer_id", "invoice_date", "billing_address", "billing_city", "billing_state", "billing_country", "billing_postal_code", "total") VALUES (2, 3, '2022-02-02 00:00:00', '789 Busy Ave', 'Brasilia', 'DF', 'Brazil', '70000-000', 12.00);
INSERT INTO "invoices" ("id", "customer_id", "invoice_date", "billing_address", "billing_city", "billing_state", "billing_country", "billing_postal_code", "total") VALUES (3, 3, '2022-02-03 00:00:00', '789 Busy Ave', 'Brasilia', 'DF', 'Brazil', '70000-000', 15.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "company" FROM "customers" WHERE ("first_name" = 'Eduardo' AND "last_name" = 'Martins') ORDER BY company, customers.id NULLS LAST;

/*
Gold Result:
('Multi Invoice Co',)
('NoRep NoInvoice Co',)
*/

-- Prediction Query
SELECT company FROM customers WHERE first_name = 'Eduardo' AND last_name = 'Martins';

/*
Prediction Result:
('NoRep NoInvoice Co',)
('Multi Invoice Co',)
*/