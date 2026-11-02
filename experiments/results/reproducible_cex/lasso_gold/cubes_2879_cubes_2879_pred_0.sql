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
INSERT INTO "artists" ("id", "name") VALUES (1078, 'Brian Cox DVM');
INSERT INTO "artists" ("id", "name") VALUES (1094, 'Steven Hayes');
INSERT INTO "genres" ("id", "name") VALUES (1079, 'Cynthia Allen');
INSERT INTO "genres" ("id", "name") VALUES (1095, 'Austin Smith');
INSERT INTO "media_types" ("id", "name") VALUES (1080, 'Angela Dennis');
INSERT INTO "media_types" ("id", "name") VALUES (1096, 'Leah Smith');
INSERT INTO "media_types" ("id", "name") VALUES (1088, NULL);
INSERT INTO "albums" ("id", "artist_id", "title") VALUES (1079, 1078, 'Balls to the Wall');
INSERT INTO "albums" ("id", "artist_id", "title") VALUES (1095, 1094, 'Balls to the Wall');
INSERT INTO "albums" ("id", "artist_id", "title") VALUES (1082, NULL, NULL);
INSERT INTO "albums" ("id", "artist_id", "title") VALUES (1090, NULL, NULL);
INSERT INTO "albums" ("id", "artist_id", "title") VALUES (1098, NULL, NULL);
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (1081, 1080, 1079, 1082, 'Vanessa Patel', 'car', 1083, 1084, 1085.5);
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (1089, 1088, 1079, 1090, 'Eric Carney', 'rate', 1091, 1092, 1093.5);
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (1097, 1096, 1095, 1098, 'Amy Jones', 'almost', 1099, 1100, 1101.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."id" AS "id", "LHS"."title" AS "title", "LHS"."artist_id" AS "artist_id", "RHS"."id" AS "id_other", "RHS"."name" AS "name", "RHS"."album_id" AS "album_id", "RHS"."media_type_id" AS "media_type_id", "RHS"."composer" AS "composer", "RHS"."milliseconds" AS "milliseconds", "RHS"."bytes" AS "bytes", "RHS"."unit_price" AS "unit_price" FROM (SELECT * FROM "albums" WHERE ("title" = 'Balls to the Wall')) AS LHS INNER JOIN tracks AS RHS ON (LHS.id = RHS.genre_id)) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Amy Jones',)
('Eric Carney',)
('Vanessa Patel',)
*/

-- Prediction Query
SELECT T2.name FROM albums AS T1 JOIN tracks AS T2 ON T1.id = T2.genre_id WHERE T1.title = 'Balls to the Wall';

/*
Prediction Result:
('Vanessa Patel',)
('Eric Carney',)
('Amy Jones',)
*/