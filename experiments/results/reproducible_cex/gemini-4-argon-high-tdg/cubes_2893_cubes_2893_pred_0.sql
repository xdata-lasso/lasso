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
INSERT INTO artists (id, name) VALUES (1, 'Artist One');
INSERT INTO albums (id, artist_id, title) VALUES (1, 1, 'Album One');
INSERT INTO media_types (id, name) VALUES (1, 'MPEG audio file');
INSERT INTO genres (id, name) VALUES (10, 'Rock');
INSERT INTO genres (id, name) VALUES (20, 'Jazz');
INSERT INTO genres (id, name) VALUES (30, 'Blues');
INSERT INTO genres (id, name) VALUES (40, 'Unmatched Genre');
INSERT INTO tracks (id, media_type_id, genre_id, album_id, name, composer, milliseconds, bytes, unit_price) VALUES (1, 1, 10, 1, 'Rock Track 1', 'Comp A', 200000, 5000000, 0.99);
INSERT INTO tracks (id, media_type_id, genre_id, album_id, name, composer, milliseconds, bytes, unit_price) VALUES (2, 1, 10, 1, 'Rock Track 2', 'Comp B', 210000, 5100000, 0.99);
INSERT INTO tracks (id, media_type_id, genre_id, album_id, name, composer, milliseconds, bytes, unit_price) VALUES (3, 1, 10, 1, 'Rock Track 3', 'Comp C', 220000, 5200000, 0.99);
INSERT INTO tracks (id, media_type_id, genre_id, album_id, name, composer, milliseconds, bytes, unit_price) VALUES (4, 1, 10, 1, 'Rock Track HD', 'Comp D', 230000, 5300000, 1.99);
INSERT INTO tracks (id, media_type_id, genre_id, album_id, name, composer, milliseconds, bytes, unit_price) VALUES (5, 1, 20, 1, 'Jazz Track 1', 'Comp E', 180000, 4000000, 0.99);
INSERT INTO tracks (id, media_type_id, genre_id, album_id, name, composer, milliseconds, bytes, unit_price) VALUES (6, 1, 20, 1, 'Jazz Track 2', 'Comp F', 190000, 4100000, 0.99);
INSERT INTO tracks (id, media_type_id, genre_id, album_id, name, composer, milliseconds, bytes, unit_price) VALUES (7, 1, 30, 1, 'Blues Track 1', 'Comp G', 250000, 6000000, 1.99);
INSERT INTO tracks (id, media_type_id, genre_id, album_id, name, composer, milliseconds, bytes, unit_price) VALUES (8, 1, 30, 1, 'Blues Track 2', 'Comp H', 260000, 6100000, 1.99);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, name FROM (SELECT LHS.id AS id, LHS.name AS name, RHS.unit_price AS unit_price, RHS.n AS n FROM genres AS LHS INNER JOIN (SELECT genre_id, unit_price, COUNT(*) AS n FROM tracks GROUP BY genre_id, unit_price) AS RHS ON (LHS.id = RHS.genre_id)) ORDER BY count___, name NULLS LAST;

/*
Gold Result:
(1, 'Rock')
(2, 'Blues')
(2, 'Jazz')
(3, 'Rock')
*/

-- Prediction Query
SELECT COUNT(*), T1.name FROM genres AS T1 JOIN tracks AS T2 ON T1.id = T2.genre_id GROUP BY T1.name;

/*
Prediction Result:
(2, 'Blues')
(2, 'Jazz')
(4, 'Rock')
*/