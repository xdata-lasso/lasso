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
-- Exact match: Multiple rows with different milliseconds (inserted out of order) and duplicate milliseconds to test DISTINCT, LIMIT 1, and ORDER BY ASC vs DESC
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (1, 1, 1, 1, 'Fast As a Shark', 'Accept', 250000, 4000000, 0.99);
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (2, 1, 1, 1, 'Fast As a Shark', 'Accept', 230000, 3500000, 0.99);
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (3, 1, 1, 1, 'Fast As a Shark', 'Accept', 230000, 3600000, 0.99);
-- Non-matching names to test case sensitivity, LIKE, prefix/suffix, and NULL handling
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (4, 1, 1, 1, 'fast as a shark', 'Accept', 210000, 3000000, 0.99);
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (5, 1, 1, 1, 'Fast As A Shark', 'Accept', 215000, 3100000, 0.99);
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (6, 1, 1, 1, 'Fast As a Shark (Live)', 'Accept', 260000, 4200000, 0.99);
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (7, 1, 1, 1, 'Balls to the Wall', 'Accept', 340000, 5500000, 0.99);
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (8, 1, 1, 1, NULL, 'Accept', 190000, 2900000, 0.99);
-- Confounding columns (where another column has the target string)
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (9, 1, 1, 1, 'Other Track', 'Fast As a Shark', 180000, 2800000, 0.99);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "milliseconds" FROM "tracks" WHERE ("name" = 'Fast As a Shark') ORDER BY milliseconds, tracks.id NULLS LAST;

/*
Gold Result:
(230000,)
(230000,)
(250000,)
*/

-- Prediction Query
SELECT milliseconds FROM tracks WHERE name = 'Fast As a Shark';

/*
Prediction Result:
(250000,)
(230000,)
(230000,)
*/