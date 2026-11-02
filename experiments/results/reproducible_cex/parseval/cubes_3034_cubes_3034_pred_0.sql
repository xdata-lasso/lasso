-- Schema DDL
CREATE TABLE "Album" ("AlbumId" INTEGER PRIMARY KEY, "ArtistId" INTEGER, "Title" TEXT(160), FOREIGN KEY ("ArtistId") REFERENCES "Artist" ("ArtistId"));

CREATE TABLE "Artist" ("ArtistId" INTEGER PRIMARY KEY, "Name" TEXT(120));

CREATE TABLE "Customer" ("CustomerId" INTEGER PRIMARY KEY, "SupportRepId" INTEGER, "FirstName" TEXT(40), "LastName" TEXT(20), "Company" TEXT(80), "Address" TEXT(70), "City" TEXT(40), "State" TEXT(40), "Country" TEXT(40), "PostalCode" TEXT(10), "Phone" TEXT(24), "Fax" TEXT(24), "Email" TEXT(60), FOREIGN KEY ("SupportRepId") REFERENCES "Employee" ("EmployeeId"));

CREATE TABLE "Employee" ("EmployeeId" INTEGER PRIMARY KEY, "ReportsTo" INTEGER, "LastName" TEXT(20), "FirstName" TEXT(20), "Title" TEXT(30), "BirthDate" DATETIME, "HireDate" DATETIME, "Address" TEXT(70), "City" TEXT(40), "State" TEXT(40), "Country" TEXT(40), "PostalCode" TEXT(10), "Phone" TEXT(24), "Fax" TEXT(24), "Email" TEXT(60), FOREIGN KEY ("ReportsTo") REFERENCES "Employee" ("EmployeeId"));

CREATE TABLE "Genre" ("GenreId" INTEGER PRIMARY KEY, "Name" TEXT(120));

CREATE TABLE "Invoice" ("InvoiceId" INTEGER PRIMARY KEY, "CustomerId" INTEGER, "InvoiceDate" DATETIME, "BillingAddress" TEXT(70), "BillingCity" TEXT(40), "BillingState" TEXT(40), "BillingCountry" TEXT(40), "BillingPostalCode" TEXT(10), "Total" REAL(10, 2), FOREIGN KEY ("CustomerId") REFERENCES "Customer" ("CustomerId"));

CREATE TABLE "InvoiceLine" ("InvoiceLineId" INTEGER PRIMARY KEY, "TrackId" INTEGER, "InvoiceId" INTEGER, "UnitPrice" REAL(10, 2), "Quantity" INTEGER, FOREIGN KEY ("TrackId") REFERENCES "Track" ("TrackId"), FOREIGN KEY ("InvoiceId") REFERENCES "Invoice" ("InvoiceId"));

CREATE TABLE "MediaType" ("MediaTypeId" INTEGER PRIMARY KEY, "Name" TEXT(120));

CREATE TABLE "Playlist" ("PlaylistId" INTEGER PRIMARY KEY, "Name" TEXT(120));

CREATE TABLE "PlaylistTrack" ("PlaylistId" INTEGER, "TrackId" INTEGER, PRIMARY KEY ("PlaylistId", "TrackId"), FOREIGN KEY ("TrackId") REFERENCES "Track" ("TrackId"), FOREIGN KEY ("PlaylistId") REFERENCES "Playlist" ("PlaylistId"));

CREATE TABLE "Track" ("TrackId" INTEGER PRIMARY KEY, "MediaTypeId" INTEGER, "GenreId" INTEGER, "AlbumId" INTEGER, "Name" TEXT(200), "Composer" TEXT(220), "Milliseconds" INTEGER, "Bytes" INTEGER, "UnitPrice" REAL(10, 2), FOREIGN KEY ("MediaTypeId") REFERENCES "MediaType" ("MediaTypeId"), FOREIGN KEY ("GenreId") REFERENCES "Genre" ("GenreId"), FOREIGN KEY ("AlbumId") REFERENCES "Album" ("AlbumId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: album --
INSERT INTO "album" ("albumid", "artistid", "title") VALUES (1, 1, 'lhs_a8c7e9');

INSERT INTO "album" ("albumid", "artistid", "title") VALUES (-2147483647, 1, 'lhs_7f437d');

INSERT INTO "album" ("albumid", "artistid", "title") VALUES (2, 1, 'lhs_a8c7e9');

INSERT INTO "album" ("albumid", "artistid", "title") VALUES (3, 1, 'lhs_7f437d');

INSERT INTO "album" ("albumid", "artistid", "title") VALUES (4, 4, 'alb_1a7f80');

INSERT INTO "album" ("albumid", "artistid", "title") VALUES (5, 5, 'alb_1a7f80');

INSERT INTO "album" ("albumid", "artistid", "title") VALUES (6, 6, 'alb_1a7f80');

INSERT INTO "album" ("albumid", "artistid", "title") VALUES (7, 7, 'alb_1a7f80');

INSERT INTO "album" ("albumid", "artistid", "title") VALUES (8, 8, 'alb_1a7f80');

INSERT INTO "album" ("albumid", "artistid", "title") VALUES (9, 9, 'alb_1a7f80');

INSERT INTO "album" ("albumid", "artistid", "title") VALUES (10, 10, 'alb_1a7f80');

INSERT INTO "album" ("albumid", "artistid", "title") VALUES (11, 11, 'alb_1a7f80');

INSERT INTO "album" ("albumid", "artistid", "title") VALUES (12, 12, 'alb_1a7f80');

INSERT INTO "album" ("albumid", "artistid", "title") VALUES (13, 13, 'alb_1a7f80');

-- Inserting into table: artist --
INSERT INTO "artist" ("artistid", "name") VALUES (1, 'rhs_367102');

INSERT INTO "artist" ("artistid", "name") VALUES (-2147483647, 'rhs_86029d');

INSERT INTO "artist" ("artistid", "name") VALUES (3, 'rhs_367102');

INSERT INTO "artist" ("artistid", "name") VALUES (2, 'art_c4cda2');

INSERT INTO "artist" ("artistid", "name") VALUES (-2147483644, 'Metallica');

INSERT INTO "artist" ("artistid", "name") VALUES (4, 'art_c4cda2');

INSERT INTO "artist" ("artistid", "name") VALUES (-2147483642, 'Metallica');

INSERT INTO "artist" ("artistid", "name") VALUES (5, 'art_c4cda2');

INSERT INTO "artist" ("artistid", "name") VALUES (-2147483640, 'Metallica');

INSERT INTO "artist" ("artistid", "name") VALUES (6, 'art_c4cda2');

INSERT INTO "artist" ("artistid", "name") VALUES (-2147483638, 'Metallica');

INSERT INTO "artist" ("artistid", "name") VALUES (7, 'art_c4cda2');

INSERT INTO "artist" ("artistid", "name") VALUES (-2147483636, 'Metallica');

INSERT INTO "artist" ("artistid", "name") VALUES (8, 'art_c4cda2');

INSERT INTO "artist" ("artistid", "name") VALUES (-2147483634, 'Metallica');

INSERT INTO "artist" ("artistid", "name") VALUES (9, 'art_c4cda2');

INSERT INTO "artist" ("artistid", "name") VALUES (-2147483632, 'Metallica');

INSERT INTO "artist" ("artistid", "name") VALUES (10, 'art_c4cda2');

INSERT INTO "artist" ("artistid", "name") VALUES (-2147483630, 'Metallica');

INSERT INTO "artist" ("artistid", "name") VALUES (11, 'art_c4cda2');

INSERT INTO "artist" ("artistid", "name") VALUES (-2147483628, 'Metallica');

INSERT INTO "artist" ("artistid", "name") VALUES (12, 'art_c4cda2');

INSERT INTO "artist" ("artistid", "name") VALUES (-2147483626, 'Metallica');

INSERT INTO "artist" ("artistid", "name") VALUES (13, 'art_c4cda2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "name", COUNT(*) AS "n" FROM (SELECT "LHS"."albumid" AS "albumid", "LHS"."title" AS "title", "LHS"."artistid" AS "artistid", "RHS"."name" AS "name" FROM "album" AS "LHS" INNER JOIN "artist" AS "RHS" ON ("LHS"."artistid" = "RHS"."artistid")) GROUP BY "name") WHERE ("name" = 'Metallica') ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM ALBUM AS T1 JOIN ARTIST AS T2 ON T1.ArtistId = T2.ArtistId WHERE T2.Name = 'Metallica';

/*
Prediction Result:
(0,)
*/