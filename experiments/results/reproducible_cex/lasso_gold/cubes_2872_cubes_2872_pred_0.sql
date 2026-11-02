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
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1001, 1012, 'Fowler', 'Anthony', 'Designer, furniture', '1970-01-01', '1981-01-12', '161 Calderon River Suite 931
Lake Jeremyport, CO 31013', 'New Shane', 'Texas', 'Bahamas', '21136', '793-699-0916', 'least', 'zsmith@example.net');
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1002, 1012, 'Johnson', 'James', 'Engineer, structural', '1970-01-02', '1981-01-13', '7525 Clark Grove Apt. 928
East Steven, KY 84387', 'Whitemouth', 'Virginia', 'San Marino', '07956', '353.246.2475', 'police', 'michaeljones@example.net');
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1003, 1012, 'Hill', 'Debra', 'Legal secretary', '1970-01-03', '1981-01-14', '503 Linda Locks
Carlshire, FM 94599', 'Port Sandra', 'New York', 'Germany', '67063', '599.711.8384x251', 'much', 'cindy14@example.net');
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1004, 1012, 'Walker', 'Amy', 'Civil engineer, consulting', '1970-01-04', '1981-01-15', '7242 Julie Plain Suite 969
Coxberg, NY 65187', 'Mortonside', 'Georgia', 'Azerbaijan', '11001', '327-384-9808x4124', 'business', 'elizabeth56@example.net');
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1005, 1012, 'Doyle', 'Jeffrey', 'Chief Executive Officer', '1970-01-05', '1981-01-16', '22691 James Mountain
Tashatown, TX 94967', 'North Deniseside', 'Illinois', 'Australia', '24857', '001-282-344-9353x4874', 'image', 'angela36@example.net');
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1006, 1012, 'Rhodes', 'Bridget', 'Museum/gallery conservator', '1970-01-06', '1981-01-17', '514 Moore Alley Suite 828
Port Colleenhaven, PA 26572', 'North Sarabury', 'Maine', 'Myanmar', '09482', '+1-264-300-5242x7868', 'we', 'lbyrd@example.net');
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1007, 1012, 'Mcclain', 'Lisa', 'Chief Strategy Officer', '1970-01-07', '1981-01-18', '809 Burns Creek
Natashaport, IA 08093', 'South Todd', 'Indiana', 'Lesotho', '78493', '428-205-9826', 'part', 'richard04@example.com');
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1008, 1012, 'Miller', 'Adam', 'Mechanical engineer', '1970-01-08', '1981-01-19', '71822 Arroyo Expressway
Allisonchester, IL 71187', 'Port Richard', 'Arkansas', 'Macao', '09408', '450-453-3158x6923', 'customer', 'russellcarpenter@example.net');
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1009, 1012, 'Henderson', 'Linda', 'Local government officer', '1970-01-09', '1981-01-20', '465 Lam Mission
East Jeffreymouth, AK 77611', 'East Nicholasfurt', 'Pennsylvania', 'Uruguay', '89002', '(902)756-3421x60733', 'environmental', 'steven73@example.net');
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1010, 1012, 'Robinson', 'Helen', 'Trade mark attorney', '1970-01-10', '1981-01-21', '10310 Jones Freeway
Elizabethborough, ND 17843', 'Saramouth', 'West Virginia', 'Timor-Leste', '31329', '733-203-6541x4586', 'another', 'yleon@example.net');
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1011, 1012, 'Wagner', 'Matthew', 'Geneticist, molecular', '1970-01-11', '1981-01-22', '76311 Gomez Loop Suite 010
Chandlerville, IA 25613', 'Rodneyside', 'Ohio', 'Marshall Islands', '53424', '742-794-0196', 'section', 'donnacampbell@example.net');
INSERT INTO "employees" ("id", "reports_to", "last_name", "first_name", "title", "birth_date", "hire_date", "address", "city", "state", "country", "postal_code", "phone", "fax", "email") VALUES (1012, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name, last_name FROM (SELECT * FROM (SELECT * FROM employees ORDER BY first_name, employees.id NULLS LAST) LIMIT 8);

/*
Gold Result:
(None, None)
('Adam', 'Miller')
('Amy', 'Walker')
('Anthony', 'Fowler')
('Bridget', 'Rhodes')
('Debra', 'Hill')
('Helen', 'Robinson')
('James', 'Johnson')
*/

-- Prediction Query
SELECT first_name, last_name FROM employees ORDER BY hire_date ASC, employees.id NULLS LAST LIMIT 10;

/*
Prediction Result:
(None, None)
('Anthony', 'Fowler')
('James', 'Johnson')
('Debra', 'Hill')
('Amy', 'Walker')
('Jeffrey', 'Doyle')
('Bridget', 'Rhodes')
('Lisa', 'Mcclain')
('Adam', 'Miller')
('Linda', 'Henderson')
*/