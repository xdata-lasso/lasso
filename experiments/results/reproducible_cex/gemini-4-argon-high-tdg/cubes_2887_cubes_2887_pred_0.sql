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
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "address", "city", "state", "country") VALUES (1, NULL, 'Adams', 'Andrew', 'IT Manager', '101 Main St', 'Zich', 'NY', 'USA');
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "address", "city", "state", "country") VALUES (2, 1, 'Edwards', 'Nancy', 'IT Staff', '102 Main St', 'Zich', 'NY', 'USA');
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "address", "city", "state", "country") VALUES (3, 1, 'Peacock', 'Jane', 'Sales Support Agent', '103 Main St', 'Zich', 'NY', 'USA');
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "address", "city", "state", "country") VALUES (4, NULL, 'Park', 'Margaret', 'IT Staff', '201 Oak St', 'Rome', 'NY', 'USA');
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "address", "city", "state", "country") VALUES (5, 4, 'Johnson', 'Steve', 'IT Staff', '202 Oak St', 'Rome', 'NY', 'USA');
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "address", "city", "state", "country") VALUES (6, 1, 'Mitchell', 'Michael', 'IT Staff', '301 Pine St', 'Cairo', 'NY', 'USA');
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "address", "city", "state", "country") VALUES (7, NULL, 'King', 'Robert', 'IT Staff', '302 Pine St', 'Cairo', 'NY', 'USA');
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "address", "city", "state", "country") VALUES (8, NULL, 'Callahan', 'Laura', 'IT Staff', '401 Elm St', NULL, 'NY', 'USA');
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "address", "city", "state", "country") VALUES (9, 8, 'Dodsworth', 'Anne', 'IT Staff', '402 Elm St', NULL, 'NY', 'USA');
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "address", "city", "state", "country") VALUES (10, 1, 'Fuller', 'Andrew', 'IT Staff', '501 Maple St', 'Athens', 'NY', 'USA');
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "address", "city", "state", "country") VALUES (11, 1, 'Leverling', 'Janet', 'IT Staff', '502 Maple St', 'Athens', 'NY', 'USA');
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "address", "city", "state", "country") VALUES (12, NULL, 'Buchanan', 'Steven', 'IT Staff', '503 Maple St', 'Athens', 'NY', 'USA');
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "address", "city", "state", "country") VALUES (13, 1, 'Suyama', 'Michael', 'Sales Manager', '601 Birch St', 'Paris', 'NY', 'USA');
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "address", "city", "state", "country") VALUES (14, 1, 'Davolio', 'Nancy', NULL, '203 Oak St', 'Rome', 'NY', 'USA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___", "city" FROM (SELECT "city", "title", COUNT(*) AS "n" FROM "employees" GROUP BY "city", "title") WHERE ("title" = 'IT Staff') ORDER BY count___, "city" NULLS LAST;

/*
Gold Result:
(1, 'Zich')
(2, 'Cairo')
(2, 'Rome')
(2, None)
(3, 'Athens')
*/

-- Prediction Query
SELECT COUNT(*), city FROM employees WHERE title = 'IT Staff' GROUP BY city;

/*
Prediction Result:
(2, None)
(3, 'Athens')
(2, 'Cairo')
(2, 'Rome')
(1, 'Zich')
*/