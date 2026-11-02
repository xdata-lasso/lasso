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
INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (-2147483648, -2147483648, 1, -2147483648, 'tra_22102a', 'tra_c599ca', -55602865, -59984348, 1.0);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (-2147483647, -2147483648, 1, -2147483648, 'tra_22102a', 'tra_c599ca', -1022641847, -1726781632, 1.0);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (-2147483646, -2147483648, 1, -2147483648, 'tra_22102a', 'tra_c599ca', -1980249628, -734455130, 1.0);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (-2147483645, -2147483648, 1, -2147483648, 'tra_22102a', 'tra_c599ca', 1160656988, -992890117, 1.0);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (-2147483644, -2147483648, 1, -2147483648, 'tra_22102a', 'tra_c599ca', 1219478689, -1670923962, 1.0);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (-2147483643, -2147483648, 1, -2147483648, 'tra_22102a', 'tra_c599ca', 1908028688, 2122220075, 1.0);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (-2147483642, -2147483648, 1, -2147483648, 'tra_22102a', 'tra_c599ca', -1659388584, 1526238907, 1.0);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (-2147483641, -2147483648, 1, -2147483648, 'tra_22102a', 'tra_c599ca', -841692980, -1364429300, 1.0);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (-2147483640, -2147483648, 1, -2147483648, 'tra_22102a', 'tra_c599ca', 1236688122, 2087640001, 1.0);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (-2147483639, -2147483648, 1, -2147483648, 'tra_22102a', 'tra_c599ca', 2026480202, -1576219117, NULL);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (-2147483638, -2147483648, 1, -2147483648, 'tra_22102a', 'tra_c599ca', -1209887326, -1399556171, NULL);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (-2147483637, -2147483648, 1, -2147483648, 'tra_22102a', 'tra_c599ca', 546571701, 947159877, NULL);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (-2147483636, -2147483648, 1, -2147483648, 'tra_22102a', 'tra_c599ca', -1964997180, 1149850321, 1.0);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (-2147483635, -2147483648, 1, -2147483648, 'tra_22102a', 'tra_c599ca', -1585009206, -53231346, 1.0);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (-2147483634, -2147483648, 1, -2147483648, 'tra_22102a', 'tra_c599ca', 757448742, -1179823637, 1.0);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (-2147483633, -2147483648, 1, -2147483648, 'tra_22102a', 'tra_c599ca', -967741825, 775304493, 1.0);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (-2147483632, -2147483648, 1, -2147483648, 'tra_22102a', 'tra_c599ca', -1106983592, 1884179925, 1.0);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (-2147483631, -2147483648, 1, -2147483648, 'tra_22102a', 'tra_c599ca', 2107872094, 882961052, 1.0);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (-2147483630, -2147483648, 1, -2147483648, 'tra_22102a', 'tra_c599ca', -751275471, -1347802441, 1.0);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (-2147483629, -2147483648, 1, -2147483648, 'tra_22102a', 'tra_c599ca', -314162272, 2137741668, 1.0);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (-2147483628, -2147483648, 1, -2147483648, 'tra_22102a', 'tra_c599ca', 1898504886, 624571013, 1.0);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (-2147483627, -2147483648, 1, -2147483648, 'tra_22102a', 'tra_c599ca', 226938182, 90119032, 1.0);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (-2147483626, -2147483648, 1, -2147483648, 'tra_22102a', 'tra_c599ca', -305670381, -1525670226, 1.0);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (-2147483625, -2147483648, 1, -2147483648, 'tra_22102a', 'tra_c599ca', 481163439, 2123196517, 1.0);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (-2147483624, -2147483648, 1, -2147483648, 'tra_22102a', 'tra_c599ca', -511185946, -1021749117, 1.0);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (-2147483623, -2147483648, 1, -2147483648, 'tra_22102a', 'tra_c599ca', -533293970, 176380444, 1.0);

INSERT INTO "tracks" ("id", "media_type_id", "genre_id", "album_id", "name", "composer", "milliseconds", "bytes", "unit_price") VALUES (-2147483622, -2147483648, 1, -2147483648, 'tra_22102a', 'tra_c599ca', 1661181156, -1372125820, 1.0);

-- Inserting into table: artists --
INSERT INTO "artists" ("id", "name") VALUES (-2147483648, 'art_63711c');

-- Inserting into table: albums --
INSERT INTO "albums" ("id", "artist_id", "title") VALUES (-2147483648, -2147483648, 'alb_12252b');

-- Inserting into table: genres --
INSERT INTO "genres" ("id", "name") VALUES (1, 'lhs_66b05f');

INSERT INTO "genres" ("id", "name") VALUES (-2147483647, 'lhs_2d6af6');

-- Inserting into table: media_types --
INSERT INTO "media_types" ("id", "name") VALUES (-2147483648, 'med_55e519');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, name FROM (SELECT LHS.id AS id, LHS.name AS name, RHS.unit_price AS unit_price, RHS.n AS n FROM genres AS LHS INNER JOIN (SELECT genre_id, unit_price, COUNT(*) AS n FROM tracks GROUP BY genre_id, unit_price) AS RHS ON (LHS.id = RHS.genre_id)) ORDER BY count___, name NULLS LAST;

/*
Gold Result:
(3, 'lhs_66b05f')
(24, 'lhs_66b05f')
*/

-- Prediction Query
SELECT COUNT(*), T1.name FROM genres AS T1 JOIN tracks AS T2 ON T1.id = T2.genre_id GROUP BY T1.name;

/*
Prediction Result:
(27, 'lhs_66b05f')
*/