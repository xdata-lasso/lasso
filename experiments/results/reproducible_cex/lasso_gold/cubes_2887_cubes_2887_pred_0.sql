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
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1054, 1055, 'Howard', 'Kenneth', 'IT Staff', '1993-09-07', '1994-10-08', '640 Renee Summit
Wallport, WI 30663', 'Amystad', 'South Carolina', 'El Salvador', '89336', '001-421-504-7095x21456', 'cause', 'alyssa42@example.com');
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1056, 1057, 'Sloan', 'Sherry', 'IT Staff', '1995-11-09', '1996-01-10', 'Unit 4517 Box 1236
DPO AP 48443', 'Amystad', 'Ohio', 'British Virgin Islands', '60110', '(549)365-1370x985', 'prove', 'tblankenship@example.net');
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1058, 1059, 'Ortiz', 'Donald', 'IT Staff', '1997-02-11', '1998-03-12', 'USNV Ferrell
FPO AE 13240', 'Jefferyborough', 'New Jersey', 'Heard Island and McDonald Islands', '88382', '001-586-992-6179x6405', 'light', 'melissagarcia@example.net');
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1055, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1057, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1059, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___", "city" FROM (SELECT "city", "title", COUNT(*) AS "n" FROM "employees" GROUP BY "city", "title") WHERE ("title" = 'IT Staff') ORDER BY count___, "city" NULLS LAST;

/*
Gold Result:
(1, 'Jefferyborough')
(2, 'Amystad')
*/

-- Prediction Query
SELECT COUNT(*), city FROM employees WHERE title = 'IT Staff' GROUP BY city;

/*
Prediction Result:
(2, 'Amystad')
(1, 'Jefferyborough')
*/