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
INSERT INTO "artists" ("id", "name") VALUES (10, 'Artist Ten');
INSERT INTO "artists" ("id", "name") VALUES (20, 'Artist Twenty');
INSERT INTO "artists" ("id", "name") VALUES (30, 'Artist Thirty');
INSERT INTO "artists" ("id", "name") VALUES (40, 'Artist Forty');
INSERT INTO "artists" ("id", "name") VALUES (50, 'Artist Fifty');
INSERT INTO "artists" ("id", "name") VALUES (60, 'Artist Sixty');
INSERT INTO "genres" ("id", "name") VALUES (10, 'Rock');
INSERT INTO "genres" ("id", "name") VALUES (20, 'Jazz');
INSERT INTO "genres" ("id", "name") VALUES (30, 'Metal');
INSERT INTO "genres" ("id", "name") VALUES (40, 'Blues');
INSERT INTO "genres" ("id", "name") VALUES (50, 'Pop');
INSERT INTO "genres" ("id", "name") VALUES (60, 'Classical');
INSERT INTO "genres" ("id", "name") VALUES (99, 'Unmatched Genre');
INSERT INTO "media_types" ("id", "name") VALUES (1, 'MPEG audio file');
INSERT INTO "media_types" ("id", "name") VALUES (2, 'Protected AAC audio file');
INSERT INTO "media_types" ("id", "name") VALUES (3, 'Protected MPEG-4 video file');
INSERT INTO "media_types" ("id", "name") VALUES (4, 'Purchased AAC audio file');
INSERT INTO "media_types" ("id", "name") VALUES (5, 'AAC audio file');
INSERT INTO "media_types" ("id", "name") VALUES (6, 'WAV audio file');
INSERT INTO "media_types" ("id", "name") VALUES (99, 'Unmatched Media');
INSERT INTO "albums" ("id", "artist_id", "title") VALUES (1, 10, 'Z_Valid_Match_1');
INSERT INTO "albums" ("id", "artist_id", "title") VALUES (2, 20, 'A_Valid_Match_2');
INSERT INTO "albums" ("id", "artist_id", "title") VALUES (3, 30, 'M_Filtered_Balls');
INSERT INTO "albums" ("id", "artist_id", "title") VALUES (4, 40, 'Fk_AlbumId_Only');
INSERT INTO "albums" ("id", "artist_id", "title") VALUES (5, 50, 'MediaType_Match_Only');
INSERT INTO "albums" ("id", "artist_id", "title") VALUES (6, 60, 'Genre_Match_Only');
INSERT INTO "albums" ("id", "artist_id", "title") VALUES (7, 10, 'TrackId_Match_Only');
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (101, 1, 10, 4, 'Song Alpha', 'Composer A', 200000, 5000000, 0.99);
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (102, 1, 10, 4, 'Song Beta', 'Composer B', 210000, 5100000, 0.99);
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (103, 2, 20, 4, 'Song Gamma', 'Composer C', 190000, 4800000, 0.99);
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (104, 3, 30, 4, 'Balls to the Wall', 'Accept', 342562, 5510424, 0.99);
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (105, 5, 99, 4, 'Partial Media', 'Composer D', 180000, 4000000, 0.99);
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (106, 99, 60, 4, 'Partial Genre', 'Composer E', 175000, 3900000, 0.99);
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (7, 99, 10, 4, 'Track ID Confusion', 'Composer F', 160000, 3500000, 0.99);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "title" FROM (SELECT "id", "name", "album_id", "media_type_id", "genre_id", "composer", "milliseconds", "bytes", "unit_price", "title", "genre_id" AS "artist_id" FROM (SELECT "media_type_id" AS "id", "name", "album_id", "media_type_id", "genre_id", "composer", "milliseconds", "bytes", "unit_price", "title" FROM (SELECT "LHS"."id" AS "id", "LHS"."name" AS "name", "LHS"."album_id" AS "album_id", "LHS"."media_type_id" AS "media_type_id", "LHS"."genre_id" AS "genre_id", "LHS"."composer" AS "composer", "LHS"."milliseconds" AS "milliseconds", "LHS"."bytes" AS "bytes", "LHS"."unit_price" AS "unit_price", "RHS"."title" AS "title" FROM "tracks" AS "LHS" INNER JOIN "albums" AS "RHS" ON ("LHS"."media_type_id" = "RHS"."id" AND "LHS"."genre_id" = "RHS"."artist_id")))) WHERE ("name" <> 'Balls to the Wall') ORDER BY title, "title" NULLS LAST;

/*
Gold Result:
('A_Valid_Match_2',)
('Z_Valid_Match_1',)
*/

-- Prediction Query
SELECT T1.title FROM albums AS T1 JOIN tracks AS T2 ON T1.id = T2.genre_id WHERE T2.name = 'Balls to the Wall';

/*
Prediction Result:
*/