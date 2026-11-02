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
INSERT INTO "artists" ("id", "name") VALUES (1, 'Artist 1');
INSERT INTO "artists" ("id", "name") VALUES (2, 'Artist 2');
INSERT INTO "media_types" ("id", "name") VALUES (1, 'MPEG audio file');
INSERT INTO "media_types" ("id", "name") VALUES (2, 'Protected AAC audio file');
INSERT INTO "genres" ("id", "name") VALUES (1, 'Rock');
INSERT INTO "genres" ("id", "name") VALUES (2, 'Jazz');
INSERT INTO "albums" ("id", "artist_id", "title") VALUES (1, 1, 'Zebra Album');
INSERT INTO "albums" ("id", "artist_id", "title") VALUES (2, 1, 'Alpha Album');
INSERT INTO "albums" ("id", "artist_id", "title") VALUES (3, 2, 'Unmatched Album');
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (10, 1, 1, 3, 'Valid Track A', 'Comp 1', 1000, 5000, 0.99);
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (11, 1, 1, 3, 'Valid Track B', 'Comp 1', 1000, 5000, 0.99);
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (12, 2, 1, 3, 'Valid Track C', 'Comp 2', 2000, 6000, 0.99);
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (13, 2, 1, 3, 'Balls to the Wall', 'Comp 3', 3000, 7000, 0.99);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "title" FROM (SELECT "id", "name", "album_id", "media_type_id", "genre_id", "composer", "milliseconds", "bytes", "unit_price", "title", "genre_id" AS "artist_id" FROM (SELECT "media_type_id" AS "id", "name", "album_id", "media_type_id", "genre_id", "composer", "milliseconds", "bytes", "unit_price", "title" FROM (SELECT "LHS"."id" AS "id", "LHS"."name" AS "name", "LHS"."album_id" AS "album_id", "LHS"."media_type_id" AS "media_type_id", "LHS"."genre_id" AS "genre_id", "LHS"."composer" AS "composer", "LHS"."milliseconds" AS "milliseconds", "LHS"."bytes" AS "bytes", "LHS"."unit_price" AS "unit_price", "RHS"."title" AS "title" FROM "tracks" AS "LHS" INNER JOIN "albums" AS "RHS" ON ("LHS"."media_type_id" = "RHS"."id" AND "LHS"."genre_id" = "RHS"."artist_id")))) WHERE ("name" <> 'Balls to the Wall') ORDER BY title, "title" NULLS LAST;

/*
Gold Result:
('Alpha Album',)
('Zebra Album',)
*/

-- Prediction Query
SELECT T1.title FROM albums AS T1 JOIN tracks AS T2 ON T1.id = T2.genre_id WHERE T2.name = 'Balls to the Wall';

/*
Prediction Result:
('Zebra Album',)
*/