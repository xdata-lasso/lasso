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
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1062, 1063, 'Allen', 'Robert', 'Chartered certified accountant', '1981-08-18', '1982-09-19', '88888 Peter Mountains Apt. 654
West Kristinastad, IA 96569', 'Port Bonniemouth', 'Florida', 'Aruba', '46677', '+1-252-677-2217', 'defense', 'moodynina@example.com');
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1065, 1066, 'West', 'Jessica', 'Manufacturing engineer', '1983-10-20', '1984-11-21', '0165 Stephanie Divide Suite 021
Port Deanna, MN 50682', 'New Ericmouth', 'Mississippi', 'Holy See (Vatican City State)', '58689', '001-819-328-5654x31027', 'everybody', 'jane39@example.com');
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1063, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1066, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1064, 1062, 'Roberto', 'Almeida', 'Hendricks, Henry and Martinez', '34505 Martinez Land Suite 676
Terrifort, UT 65712', 'Port Troy', 'Louisiana', 'Spain', '11329', '001-661-969-2845x1154', 'free', 'cjackson@example.com');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "company", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1067, 1065, 'Roberto', 'Almeida', 'Robertson-Hays', '71551 Vance Vista Apt. 258
North Tracie, WY 18703', 'Sandrahaven', 'Oklahoma', 'Brunei Darussalam', '48854', '382.491.1467x866', 'player', 'coleerin@example.com');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "country" FROM "customers" WHERE ("first_name" = 'Roberto' AND "last_name" = 'Almeida') ORDER BY country, customers.id NULLS LAST;

/*
Gold Result:
('Brunei Darussalam',)
('Spain',)
*/

-- Prediction Query
SELECT country FROM customers WHERE first_name = 'Roberto' AND last_name = 'Almeida';

/*
Prediction Result:
('Spain',)
('Brunei Darussalam',)
*/