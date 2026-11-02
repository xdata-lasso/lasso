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
INSERT INTO "artists" ("id", "name") VALUES (1, 'Accept');
INSERT INTO "albums" ("id", "artist_id", "title") VALUES (1, 1, 'Restless and Wild');
INSERT INTO "genres" ("id", "name") VALUES (1, 'Rock');
INSERT INTO "media_types" ("id", "name") VALUES (1, 'Protected AAC audio file');
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (1, 1, 1, 1, 'Fast As a Shark', 'F. Baltes, S. Kaufmann, U. Dirkscneider & W. Hoffman', 230619, 3990994, 1.99);
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (2, 1, 1, 1, 'Fast As a Shark', 'Accept', 230000, 3900000, 0.99);
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (3, 1, 1, 1, 'Fast As a Shark', 'Accept', 230000, 3900000, 0.99);
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (4, 1, 1, 1, 'fast as a shark', 'Accept', 200000, 3000000, 2.99);
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (5, 1, 1, 1, 'Fast As a Shark Live', 'Accept', 250000, 4000000, 3.99);
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (6, 1, 1, 1, 'Balls to the Wall', 'Fast As a Shark', 342562, 5510424, 4.99);
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title") VALUES (1, NULL, 'Adams', 'Andrew', 'General Manager');
INSERT INTO "customers" ("id", "support_rep_id", "first_name", "last_name", "email") VALUES (1, 1, 'Luís', 'Gonçalves', 'luisg@embraer.com.br');
INSERT INTO "invoices" ("id", "customer_id", "total") VALUES (1, 1, 10.99);
INSERT INTO "invoice_lines" ("id", "track_id", "invoice_id", "unit_price", "quantity") VALUES (1, 1, 1, 0.50, 1);
INSERT INTO "invoice_lines" ("id", "track_id", "invoice_id", "unit_price", "quantity") VALUES (2, 1, 1, 0.50, 2);
INSERT INTO "playlists" ("id", "name") VALUES (1, 'Heavy Metal Classic');
INSERT INTO "playlists" ("id", "name") VALUES (2, 'Music');
INSERT INTO "playlist_tracks" ("playlist_id", "track_id") VALUES (1, 1);
INSERT INTO "playlist_tracks" ("playlist_id", "track_id") VALUES (2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "unit_price" FROM "tracks" WHERE ("name" = 'Fast As a Shark') ORDER BY unit_price, tracks.id NULLS LAST;

/*
Gold Result:
(0.99,)
(0.99,)
(1.99,)
*/

-- Prediction Query
SELECT unit_price FROM tracks WHERE name = 'Fast As a Shark';

/*
Prediction Result:
(1.99,)
(0.99,)
(0.99,)
*/