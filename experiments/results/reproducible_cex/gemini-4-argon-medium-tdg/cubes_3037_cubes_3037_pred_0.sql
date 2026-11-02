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
-- DATASET 1
-- General comprehensive dataset:
-- Tests filtering by Genre.Name = 'Rock' vs 'Pop', 'Rock and Roll', 'rock', NULL.
-- Tests GROUP BY genreid with multiple genres having 'Rock' and different track counts (ordered ascending).
-- Tests COUNT(*) vs COUNT(column) by including NULLs in Track attributes.
-- Tests INNER JOIN vs LEFT/RIGHT JOIN by including tracks with NULL GenreId and genres with 0 tracks.
-- Tests confusing Track.Name = 'Rock' with Genre.Name = 'Rock'.
INSERT INTO "Artist" ("ArtistId", "Name") VALUES (1, 'Artist 1');
INSERT INTO "Album" ("AlbumId", "ArtistId", "Title") VALUES (1, 1, 'Album 1');
INSERT INTO "MediaType" ("MediaTypeId", "Name") VALUES (1, 'Media 1');
INSERT INTO "Genre" ("GenreId", "Name") VALUES (1, 'Rock');
INSERT INTO "Genre" ("GenreId", "Name") VALUES (2, 'Rock');
INSERT INTO "Genre" ("GenreId", "Name") VALUES (3, 'Rock');
INSERT INTO "Genre" ("GenreId", "Name") VALUES (4, 'Pop');
INSERT INTO "Genre" ("GenreId", "Name") VALUES (5, 'Rock and Roll');
INSERT INTO "Genre" ("GenreId", "Name") VALUES (6, 'rock');
INSERT INTO "Genre" ("GenreId", "Name") VALUES (7, NULL);
-- Genre 1 ('Rock') has 3 tracks. Track 1 has NULLs in optional columns, Track 3 has identical Name to Track 2.
INSERT INTO "Track" ("TrackId", "MediaTypeId", "GenreId", "AlbumId", "Name", "Composer", "Milliseconds", "Bytes", "UnitPrice") VALUES (1, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "Track" ("TrackId", "MediaTypeId", "GenreId", "AlbumId", "Name", "Composer", "Milliseconds", "Bytes", "UnitPrice") VALUES (2, 1, 1, 1, 'DupName', 'Comp', 100, 100, 0.99);
INSERT INTO "Track" ("TrackId", "MediaTypeId", "GenreId", "AlbumId", "Name", "Composer", "Milliseconds", "Bytes", "UnitPrice") VALUES (3, 1, 1, 1, 'DupName', 'Comp', 100, 100, 0.99);
-- Genre 2 ('Rock') has 1 track.
INSERT INTO "Track" ("TrackId", "MediaTypeId", "GenreId", "AlbumId", "Name", "Composer", "Milliseconds", "Bytes", "UnitPrice") VALUES (4, 1, 2, 1, 'Track 4', 'Comp', 200, 200, 1.99);
-- Genre 3 ('Rock') has 0 tracks.
-- Genre 4 ('Pop') has 2 tracks, one of which is named 'Rock' to catch predicate column confusion.
INSERT INTO "Track" ("TrackId", "MediaTypeId", "GenreId", "AlbumId", "Name", "Composer", "Milliseconds", "Bytes", "UnitPrice") VALUES (5, 1, 4, 1, 'Rock', 'Rock', 300, 300, 0.99);
INSERT INTO "Track" ("TrackId", "MediaTypeId", "GenreId", "AlbumId", "Name", "Composer", "Milliseconds", "Bytes", "UnitPrice") VALUES (6, 1, 4, 1, 'Track 6', 'Comp', 300, 300, 0.99);
-- Genre 5 ('Rock and Roll') has 1 track to catch LIKE '%Rock%' mutations.
INSERT INTO "Track" ("TrackId", "MediaTypeId", "GenreId", "AlbumId", "Name", "Composer", "Milliseconds", "Bytes", "UnitPrice") VALUES (7, 1, 5, 1, 'Track 7', 'Comp', 300, 300, 0.99);
-- Genre 6 ('rock') has 1 track to catch case-insensitivity mutations.
INSERT INTO "Track" ("TrackId", "MediaTypeId", "GenreId", "AlbumId", "Name", "Composer", "Milliseconds", "Bytes", "UnitPrice") VALUES (8, 1, 6, 1, 'Track 8', 'Comp', 300, 300, 0.99);
-- Track with NULL GenreId to catch LEFT JOIN from Track.
INSERT INTO "Track" ("TrackId", "MediaTypeId", "GenreId", "AlbumId", "Name", "Composer", "Milliseconds", "Bytes", "UnitPrice") VALUES (9, 1, NULL, 1, 'Rock', 'Comp', 300, 300, 0.99);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "genreid", COUNT(*) AS "n" FROM (SELECT "LHS"."trackid" AS "trackid", "LHS"."name" AS "name", "LHS"."albumid" AS "albumid", "LHS"."mediatypeid" AS "mediatypeid", "LHS"."genreid" AS "genreid", "LHS"."composer" AS "composer", "LHS"."milliseconds" AS "milliseconds", "LHS"."bytes" AS "bytes", "LHS"."unitprice" AS "unitprice", "RHS"."name" AS "name_other" FROM "track" AS "LHS" INNER JOIN (SELECT * FROM "genre" WHERE ("name" = 'Rock')) AS RHS ON (LHS.genreid = RHS.genreid)) GROUP BY genreid) ORDER BY count___;

/*
Gold Result:
(1,)
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM GENRE AS T1 JOIN TRACK AS T2 ON T1.GenreId = T2.GenreId WHERE T1.Name = 'Rock';

/*
Prediction Result:
(4,)
*/