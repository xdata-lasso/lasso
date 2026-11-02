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
-- Inserting into table: tracks --
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (-2147483648, -2147483648, 1, 1, 'Balls to the Wall', 'tra_c599ca', -1437333179, -921145356, 0.01);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (-2147483647, -2147483648, 1, 1, 'Balls to the Wall', 'tra_c599ca', -890215420, 1610062532, 0.02);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (-2147483646, -2147483648, 1, 1, 'Balls to the Wall', 'tra_c599ca', 1871297066, 809183447, 0.03);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (-2147483645, -2147483648, 4, 1, 'Balls to the Wall', 'tra_c599ca', -1633151678, -252690330, 0.04);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (-2147483644, -2147483648, 4, -2147483647, 'Balls to the Wall', 'tra_c599ca', 1465859724, -1349201381, 0.05);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (-2147483643, -2147483648, 4, 1, 'Balls to the Wall', 'tra_c599ca', -1377057208, -841692980, 0.06);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (2, -2147483648, 1, 2, 'Balls to the Wall', 'tra_c599ca', -1257178728, 1236688122, 0.07);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (3, -2147483648, 1, 2, 'Balls to the Wall', 'tra_c599ca', 462974032, -1137908826, 0.08);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (-2147483640, -2147483648, 1, 2, 't2__faab20', 'tra_c599ca', 1620389964, 546571701, 0.09);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (-2147483639, -2147483648, 1, 1, 'Balls to the Wall', 'tra_c599ca', 700088193, 374105386, 0.1);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (4, -2147483648, 3, 3, NULL, 'tra_c599ca', -921145356, 1258409369, 0.11);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (5, -2147483648, 4, 3, 'Balls to the Wall', 'tra_c599ca', -921145356, 1258409369, 0.12);

-- Inserting into table: artists --
INSERT INTO "artists" ("id", "name") VALUES (-2147483648, 'art_63711c');

-- Inserting into table: albums --
INSERT INTO "albums" ("id", "artist_id", "title") VALUES (1, -2147483648, 't1__b24f4c');

INSERT INTO "albums" ("id", "artist_id", "title") VALUES (-2147483647, -2147483648, 't1__b24f4c');

INSERT INTO "albums" ("id", "artist_id", "title") VALUES (2, -2147483648, 't1__b24f4c');

INSERT INTO "albums" ("id", "artist_id", "title") VALUES (3, -2147483648, 'alb_12252b');

INSERT INTO "albums" ("id", "artist_id", "title") VALUES (4, -2147483648, NULL);

-- Inserting into table: genres --
INSERT INTO "genres" ("id", "name") VALUES (1, 'gen_1cede3');

INSERT INTO "genres" ("id", "name") VALUES (4, 'gen_1cede3');

INSERT INTO "genres" ("id", "name") VALUES (3, 'gen_1cede3');

-- Inserting into table: media_types --
INSERT INTO "media_types" ("id", "name") VALUES (-2147483648, 'med_55e519');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "title" FROM (SELECT "id", "name", "album_id", "media_type_id", "genre_id", "composer", "milliseconds", "bytes", "unit_price", "title", "genre_id" AS "artist_id" FROM (SELECT "media_type_id" AS "id", "name", "album_id", "media_type_id", "genre_id", "composer", "milliseconds", "bytes", "unit_price", "title" FROM (SELECT "LHS"."id" AS "id", "LHS"."name" AS "name", "LHS"."album_id" AS "album_id", "LHS"."media_type_id" AS "media_type_id", "LHS"."genre_id" AS "genre_id", "LHS"."composer" AS "composer", "LHS"."milliseconds" AS "milliseconds", "LHS"."bytes" AS "bytes", "LHS"."unit_price" AS "unit_price", "RHS"."title" AS "title" FROM "tracks" AS "LHS" INNER JOIN "albums" AS "RHS" ON ("LHS"."media_type_id" = "RHS"."id" AND "LHS"."genre_id" = "RHS"."artist_id")))) WHERE ("name" <> 'Balls to the Wall') ORDER BY title, "title" NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.title FROM albums AS T1 JOIN tracks AS T2 ON T1.id = T2.genre_id WHERE T2.name = 'Balls to the Wall';

/*
Prediction Result:
('t1__b24f4c',)
('t1__b24f4c',)
('t1__b24f4c',)
(None,)
(None,)
(None,)
('t1__b24f4c',)
('t1__b24f4c',)
('t1__b24f4c',)
(None,)
*/