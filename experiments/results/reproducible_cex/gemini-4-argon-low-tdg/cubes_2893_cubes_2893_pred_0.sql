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
-- Tests:
-- 1. Grouping by both genre_id and unit_price (same genre with multiple unit_prices).
-- 2. Duplicate output rows (n=1, name='Rock' appears twice because of different unit_prices), killing SELECT DISTINCT mutants.
-- 3. Genre with no tracks (Blues), killing LEFT JOIN mutants.
-- 4. Track with NULL genre_id, killing RIGHT/FULL JOIN or IS NOT DISTINCT FROM join mutants.
-- 5. Track with NULL unit_price (grouped separately in SQL), killing COUNT(unit_price) vs COUNT(*) mutants.
-- 6.Genre with NULL name and tie-breaking on count___ (n=2), killing ORDER BY NULLS FIRST or missing NULLS LAST mutants.
INSERT INTO genres (id, name) VALUES (1, 'Rock');
INSERT INTO genres (id, name) VALUES (2, 'Jazz');
INSERT INTO genres (id, name) VALUES (3, NULL);
INSERT INTO genres (id, name) VALUES (4, 'Blues');
INSERT INTO tracks (id, genre_id, name, unit_price) VALUES (1, 1, 'Track A', 0.99);
INSERT INTO tracks (id, genre_id, name, unit_price) VALUES (2, 1, 'Track B', 1.99);
INSERT INTO tracks (id, genre_id, name, unit_price) VALUES (3, 1, 'Track C', NULL);
INSERT INTO tracks (id, genre_id, name, unit_price) VALUES (4, 2, 'Track D', 0.99);
INSERT INTO tracks (id, genre_id, name, unit_price) VALUES (5, 2, 'Track E', 0.99);
INSERT INTO tracks (id, genre_id, name, unit_price) VALUES (6, 3, 'Track F', 0.99);
INSERT INTO tracks (id, genre_id, name, unit_price) VALUES (7, 3, 'Track G', 0.99);
INSERT INTO tracks (id, genre_id, name, unit_price) VALUES (8, NULL, 'Track H', 0.99);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, name FROM (SELECT LHS.id AS id, LHS.name AS name, RHS.unit_price AS unit_price, RHS.n AS n FROM genres AS LHS INNER JOIN (SELECT genre_id, unit_price, COUNT(*) AS n FROM tracks GROUP BY genre_id, unit_price) AS RHS ON (LHS.id = RHS.genre_id)) ORDER BY count___, name NULLS LAST;

/*
Gold Result:
(1, 'Rock')
(1, 'Rock')
(1, 'Rock')
(2, 'Jazz')
(2, None)
*/

-- Prediction Query
SELECT COUNT(*), T1.name FROM genres AS T1 JOIN tracks AS T2 ON T1.id = T2.genre_id GROUP BY T1.name;

/*
Prediction Result:
(2, None)
(2, 'Jazz')
(3, 'Rock')
*/