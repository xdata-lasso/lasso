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
-- 1. COUNT(*) vs COUNT(city) when city is NULL.
-- 2. NULLS LAST vs NULLS FIRST (default ASC in SQLite) when counts are tied.
-- 3. Primary sort on count___ ASC vs DESC (counts 1, 2, 3 inserted out of order).
-- 4. Tie-breaking on city ASC vs DESC ('Boston' vs 'Denver' vs NULL all with count 2).
-- 5. Exact string matching on title ('IT Staff' vs 'IT Manager', 'it staff', 'IT Staff Senior', NULL).
-- 6. Grouping by city only vs grouping by (city, title) when the same city has both 'IT Staff' and other titles.
INSERT INTO "employees" ("id", "first_name", "last_name", "title", "city") VALUES (1, 'John', 'Doe', 'IT Staff', 'Denver');
INSERT INTO "employees" ("id", "first_name", "last_name", "title", "city") VALUES (2, 'Jane', 'Doe', 'IT Staff', 'Denver');
INSERT INTO "employees" ("id", "first_name", "last_name", "title", "city") VALUES (3, 'Alice', 'Smith', 'IT Staff', NULL);
INSERT INTO "employees" ("id", "first_name", "last_name", "title", "city") VALUES (4, 'Bob', 'Smith', 'IT Staff', NULL);
INSERT INTO "employees" ("id", "first_name", "last_name", "title", "city") VALUES (5, 'Charlie', 'Brown', 'IT Staff', 'Boston');
INSERT INTO "employees" ("id", "first_name", "last_name", "title", "city") VALUES (6, 'Lucy', 'Brown', 'IT Staff', 'Boston');
INSERT INTO "employees" ("id", "first_name", "last_name", "title", "city") VALUES (7, 'Linus', 'Brown', 'Sales Support Agent', 'Boston');
INSERT INTO "employees" ("id", "first_name", "last_name", "title", "city") VALUES (8, 'Sally', 'White', 'IT Staff', 'Austin');
INSERT INTO "employees" ("id", "first_name", "last_name", "title", "city") VALUES (9, 'Snoopy', 'White', 'IT Staff', 'Austin');
INSERT INTO "employees" ("id", "first_name", "last_name", "title", "city") VALUES (10, 'Woodstock', 'White', 'IT Staff', 'Austin');
INSERT INTO "employees" ("id", "first_name", "last_name", "title", "city") VALUES (11, 'Peppermint', 'Patty', 'IT Staff', 'Chicago');
INSERT INTO "employees" ("id", "first_name", "last_name", "title", "city") VALUES (12, 'Marcie', 'Johnson', 'IT Manager', 'Seattle');
INSERT INTO "employees" ("id", "first_name", "last_name", "title", "city") VALUES (13, 'Schroeder', 'Piano', 'it staff', 'Seattle');
INSERT INTO "employees" ("id", "first_name", "last_name", "title", "city") VALUES (14, 'Franklin', 'Armstrong', 'IT Staff Senior', 'Seattle');
INSERT INTO "employees" ("id", "first_name", "last_name", "title", "city") VALUES (15, 'Pig', 'Pen', NULL, 'Seattle');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___", "city" FROM (SELECT "city", "title", COUNT(*) AS "n" FROM "employees" GROUP BY "city", "title") WHERE ("title" = 'IT Staff') ORDER BY count___, "city" NULLS LAST;

/*
Gold Result:
(1, 'Chicago')
(2, 'Boston')
(2, 'Denver')
(2, None)
(3, 'Austin')
*/

-- Prediction Query
SELECT COUNT(*), city FROM employees WHERE title = 'IT Staff' GROUP BY city;

/*
Prediction Result:
(2, None)
(3, 'Austin')
(2, 'Boston')
(1, 'Chicago')
(2, 'Denver')
*/