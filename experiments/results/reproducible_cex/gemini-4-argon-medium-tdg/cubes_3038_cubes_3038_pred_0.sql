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
INSERT INTO Artist (ArtistId, Name) VALUES (1, 'Artist A');
INSERT INTO Album (AlbumId, ArtistId, Title) VALUES (1, 1, 'Album A');
INSERT INTO MediaType (MediaTypeId, Name) VALUES (1, 'MPEG audio file');
INSERT INTO Genre (GenreId, Name) VALUES (1, 'Rock');
INSERT INTO Track (TrackId, MediaTypeId, GenreId, AlbumId, Name, Composer, Milliseconds, Bytes, UnitPrice) VALUES (1, 1, 1, 1, 'Track Z', 'Comp Z', 300000, 5000000, 1.99);
INSERT INTO Track (TrackId, MediaTypeId, GenreId, AlbumId, Name, Composer, Milliseconds, Bytes, UnitPrice) VALUES (2, 1, 1, 1, 'Track A', 'Comp A', 200000, 4000000, 0.99);
INSERT INTO Track (TrackId, MediaTypeId, GenreId, AlbumId, Name, Composer, Milliseconds, Bytes, UnitPrice) VALUES (3, 1, 1, 1, 'Track M', 'Comp M', 250000, 4500000, 0.99);
INSERT INTO Track (TrackId, MediaTypeId, GenreId, AlbumId, Name, Composer, Milliseconds, Bytes, UnitPrice) VALUES (4, 1, 1, 1, 'Track B', 'Comp B', 100000, 2000000, 10.99);
INSERT INTO Track (TrackId, MediaTypeId, GenreId, AlbumId, Name, Composer, Milliseconds, Bytes, UnitPrice) VALUES (5, 1, 1, 1, 'Track C', 'Comp C', 150000, 3000000, 2.99);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT unitprice FROM track ORDER BY unitprice;

/*
Gold Result:
(0.99,)
(1.99,)
(2.99,)
(10.99,)
*/

-- Prediction Query
SELECT DISTINCT (UnitPrice) FROM TRACK;

/*
Prediction Result:
(1.99,)
(0.99,)
(10.99,)
(2.99,)
*/