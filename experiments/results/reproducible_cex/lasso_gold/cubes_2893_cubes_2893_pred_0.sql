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
INSERT INTO "artists" ("id", "name") VALUES (1009, 'Matthew Gardner');
INSERT INTO "artists" ("id", "name") VALUES (1017, 'Brent Abbott');
INSERT INTO "genres" ("id", "name") VALUES (1010, 'Kevin Pacheco');
INSERT INTO "genres" ("id", "name") VALUES (1018, NULL);
INSERT INTO "media_types" ("id", "name") VALUES (1011, 'Robert Wolfe');
INSERT INTO "media_types" ("id", "name") VALUES (1019, 'Valerie Gray');
INSERT INTO "albums" ("id", "artist_id", "title") VALUES (1012, 1009, 'Librarian, public');
INSERT INTO "albums" ("id", "artist_id", "title") VALUES (1020, 1017, 'Sub');
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (1013, 1011, 1010, 1012, 'Daniel Gallagher', 'blue', 1014, 1015, 1016.5);
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (1021, 1019, 1018, 1020, 'Mark Mcclure', 'high', 1022, 1023, 1024.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, name FROM (SELECT LHS.id AS id, LHS.name AS name, RHS.unit_price AS unit_price, RHS.n AS n FROM genres AS LHS INNER JOIN (SELECT genre_id, unit_price, COUNT(*) AS n FROM tracks GROUP BY genre_id, unit_price) AS RHS ON (LHS.id = RHS.genre_id)) ORDER BY count___, name NULLS LAST;

/*
Gold Result:
(1, 'Kevin Pacheco')
(1, None)
*/

-- Prediction Query
SELECT COUNT(*), T1.name FROM genres AS T1 JOIN tracks AS T2 ON T1.id = T2.genre_id GROUP BY T1.name;

/*
Prediction Result:
(1, None)
(1, 'Kevin Pacheco')
*/