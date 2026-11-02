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
-- DATASET 2
INSERT INTO "Artist" ("ArtistId", "Name") VALUES (1, 'Artist One');
INSERT INTO "Album" ("AlbumId", "ArtistId", "Title") VALUES (1, 1, 'Album One');
INSERT INTO "MediaType" ("MediaTypeId", "Name") VALUES (1, 'MPEG audio file');
INSERT INTO "Genre" ("GenreId", "Name") VALUES (10, 'Rock');
INSERT INTO "Genre" ("GenreId", "Name") VALUES (20, 'Rock');
INSERT INTO "Genre" ("GenreId", "Name") VALUES (30, 'Rock');
INSERT INTO "Genre" ("GenreId", "Name") VALUES (40, 'Pop');
INSERT INTO "Track" ("TrackId", "MediaTypeId", "GenreId", "AlbumId", "Name", "Composer", "Milliseconds", "Bytes", "UnitPrice") VALUES (1, 1, 10, 1, 'Track 1', 'Comp A', 100, 1000, 0.99);
INSERT INTO "Track" ("TrackId", "MediaTypeId", "GenreId", "AlbumId", "Name", "Composer", "Milliseconds", "Bytes", "UnitPrice") VALUES (2, 1, 10, 1, 'Track 2', 'Comp B', 200, 2000, 0.99);
INSERT INTO "Track" ("TrackId", "MediaTypeId", "GenreId", "AlbumId", "Name", "Composer", "Milliseconds", "Bytes", "UnitPrice") VALUES (3, 1, 10, 1, 'Track 3', 'Comp C', 300, 3000, 0.99);
INSERT INTO "Track" ("TrackId", "MediaTypeId", "GenreId", "AlbumId", "Name", "Composer", "Milliseconds", "Bytes", "UnitPrice") VALUES (4, 1, 10, 1, 'Track 4', 'Comp D', 400, 4000, 0.99);
INSERT INTO "Track" ("TrackId", "MediaTypeId", "GenreId", "AlbumId", "Name", "Composer", "Milliseconds", "Bytes", "UnitPrice") VALUES (5, 1, 20, 1, 'Track 5', 'Comp E', 500, 5000, 0.99);
INSERT INTO "Track" ("TrackId", "MediaTypeId", "GenreId", "AlbumId", "Name", "Composer", "Milliseconds", "Bytes", "UnitPrice") VALUES (6, 1, 30, 1, 'Track 6', 'Comp F', 600, 6000, 0.99);
INSERT INTO "Track" ("TrackId", "MediaTypeId", "GenreId", "AlbumId", "Name", "Composer", "Milliseconds", "Bytes", "UnitPrice") VALUES (7, 1, 30, 1, 'Track 7', 'Comp G', 700, 7000, 0.99);
INSERT INTO "Track" ("TrackId", "MediaTypeId", "GenreId", "AlbumId", "Name", "Composer", "Milliseconds", "Bytes", "UnitPrice") VALUES (8, 1, 30, 1, 'Track 8', 'Comp H', 800, 8000, 0.99);
INSERT INTO "Track" ("TrackId", "MediaTypeId", "GenreId", "AlbumId", "Name", "Composer", "Milliseconds", "Bytes", "UnitPrice") VALUES (9, 1, 40, 1, 'Track 9', 'Comp I', 900, 9000, 0.99);
INSERT INTO "Track" ("TrackId", "MediaTypeId", "GenreId", "AlbumId", "Name", "Composer", "Milliseconds", "Bytes", "UnitPrice") VALUES (10, 1, 40, 1, 'Track 10', 'Comp J', 1000, 10000, 0.99);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "genreid", COUNT(*) AS "n" FROM (SELECT "LHS"."trackid" AS "trackid", "LHS"."name" AS "name", "LHS"."albumid" AS "albumid", "LHS"."mediatypeid" AS "mediatypeid", "LHS"."genreid" AS "genreid", "LHS"."composer" AS "composer", "LHS"."milliseconds" AS "milliseconds", "LHS"."bytes" AS "bytes", "LHS"."unitprice" AS "unitprice", "RHS"."name" AS "name_other" FROM "track" AS "LHS" INNER JOIN (SELECT * FROM "genre" WHERE ("name" = 'Rock')) AS RHS ON (LHS.genreid = RHS.genreid)) GROUP BY genreid) ORDER BY count___;

/*
Gold Result:
(1,)
(3,)
(4,)
*/

-- Prediction Query
SELECT COUNT(*) FROM GENRE AS T1 JOIN TRACK AS T2 ON T1.GenreId = T2.GenreId WHERE T1.Name = 'Rock';

/*
Prediction Result:
(8,)
*/