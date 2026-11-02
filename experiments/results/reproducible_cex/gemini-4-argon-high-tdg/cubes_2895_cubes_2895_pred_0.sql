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
INSERT INTO artists (id, name) VALUES (1, 'AC/DC');
INSERT INTO artists (id, name) VALUES (2, 'Aerosmith');
INSERT INTO artists (id, name) VALUES (3, 'aerosmith');
INSERT INTO artists (id, name) VALUES (4, 'Aerosmiths');
INSERT INTO albums (id, artist_id, title) VALUES (1, 2, 'Toys in the Attic');
INSERT INTO albums (id, artist_id, title) VALUES (2, 1, 'Back in Black');
INSERT INTO albums (id, artist_id, title) VALUES (3, 2, 'Get a Grip');
INSERT INTO albums (id, artist_id, title) VALUES (4, 2, 'Aerosmith');
INSERT INTO albums (id, artist_id, title) VALUES (5, 1, 'Aerosmith');
INSERT INTO albums (id, artist_id, title) VALUES (6, 3, 'Lowercase Album');
INSERT INTO albums (id, artist_id, title) VALUES (7, 4, 'Substring Album');
INSERT INTO albums (id, artist_id, title) VALUES (8, NULL, 'Orphan Album');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM (SELECT "LHS"."id" AS "id", "LHS"."name" AS "name", "RHS"."id" AS "id_other", "RHS"."title" AS "title" FROM (SELECT * FROM "artists" WHERE ("name" = 'Aerosmith')) AS LHS INNER JOIN albums AS RHS ON (LHS.id = RHS.artist_id)) ORDER BY title, "title" NULLS LAST;

/*
Gold Result:
('Aerosmith',)
('Get a Grip',)
('Toys in the Attic',)
*/

-- Prediction Query
SELECT T1.title FROM albums AS T1 JOIN artists AS T2 ON T1.artist_id = T2.id WHERE T2.name = 'Aerosmith';

/*
Prediction Result:
('Toys in the Attic',)
('Get a Grip',)
('Aerosmith',)
*/