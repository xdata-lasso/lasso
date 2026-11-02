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
INSERT INTO "artists" ("id", "name") VALUES (1, 'Artist A');
INSERT INTO "albums" ("id", "artist_id", "title") VALUES (1, 1, 'Album A');
INSERT INTO "media_types" ("id", "name") VALUES (1, 'MPEG audio file');
INSERT INTO "genres" ("id", "name") VALUES (1, 'Rock');
INSERT INTO "genres" ("id", "name") VALUES (2, 'Jazz');
INSERT INTO "genres" ("id", "name") VALUES (3, 'Pop');
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (1, 1, 1, 1, 'Zebra', 'Composer Z', 300000, 5000000, 0.99);
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (2, 1, 1, 1, 'Alpha', 'Composer A', 100000, 1000000, 0.99);
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (3, 1, 1, 1, 'Alpha', 'Composer B', 200000, 2000000, 1.99);
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (4, 1, 2, 1, 'Rock', 'Composer C', 150000, 1500000, 0.99);
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (5, 1, NULL, 1, 'No Genre Track', 'Composer D', 120000, 1200000, 0.99);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name_other" AS "name" FROM (SELECT "id", "name", "id_other", "name_other", "album_id", "media_type_id", "composer", "milliseconds", "bytes", "unit_price", "id" AS "genre_id" FROM (SELECT "LHS"."id" AS "id", "LHS"."name" AS "name", "RHS"."id" AS "id_other", "RHS"."name" AS "name_other", "RHS"."album_id" AS "album_id", "RHS"."media_type_id" AS "media_type_id", "RHS"."composer" AS "composer", "RHS"."milliseconds" AS "milliseconds", "RHS"."bytes" AS "bytes", "RHS"."unit_price" AS "unit_price" FROM "genres" AS "LHS" INNER JOIN "tracks" AS "RHS" ON ("LHS"."id" = "RHS"."genre_id"))) WHERE ("name" = 'Rock') ORDER BY name;

/*
Gold Result:
('Alpha',)
('Alpha',)
('Zebra',)
*/

-- Prediction Query
SELECT T2.name FROM genres AS T1 JOIN tracks AS T2 ON T1.id = T2.genre_id WHERE T1.name = 'Rock';

/*
Prediction Result:
('Zebra',)
('Alpha',)
('Alpha',)
*/