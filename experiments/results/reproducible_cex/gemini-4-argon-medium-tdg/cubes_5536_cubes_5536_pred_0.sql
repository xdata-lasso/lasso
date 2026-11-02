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
INSERT INTO MediaType (MediaTypeId, Name) VALUES (1, 'MP3');
INSERT INTO Genre (GenreId, Name) VALUES (1, 'Rock');
INSERT INTO Album (AlbumId, ArtistId, Title) VALUES (1, 1, 'Album Cheap');
INSERT INTO Album (AlbumId, ArtistId, Title) VALUES (2, 1, 'Album Boundary');
INSERT INTO Album (AlbumId, ArtistId, Title) VALUES (3, 1, 'Album Expensive');
INSERT INTO Album (AlbumId, ArtistId, Title) VALUES (4, 1, 'Album Mixed');
INSERT INTO Track (TrackId, MediaTypeId, GenreId, AlbumId, Name, Composer, Milliseconds, Bytes, UnitPrice) VALUES (1, 1, 1, 1, 'T1', 'C1', 1000, 100, 0.99);
INSERT INTO Track (TrackId, MediaTypeId, GenreId, AlbumId, Name, Composer, Milliseconds, Bytes, UnitPrice) VALUES (2, 1, 1, 2, 'T2', 'C1', 1000, 100, 1.00);
INSERT INTO Track (TrackId, MediaTypeId, GenreId, AlbumId, Name, Composer, Milliseconds, Bytes, UnitPrice) VALUES (3, 1, 1, 3, 'T3', 'C1', 1000, 100, 1.01);
INSERT INTO Track (TrackId, MediaTypeId, GenreId, AlbumId, Name, Composer, Milliseconds, Bytes, UnitPrice) VALUES (4, 1, 1, 3, 'T4', 'C1', 1000, 100, 2.50);
INSERT INTO Track (TrackId, MediaTypeId, GenreId, AlbumId, Name, Composer, Milliseconds, Bytes, UnitPrice) VALUES (5, 1, 1, 4, 'T5', 'C1', 1000, 100, 1.99);
INSERT INTO Track (TrackId, MediaTypeId, GenreId, AlbumId, Name, Composer, Milliseconds, Bytes, UnitPrice) VALUES (6, 1, 1, 4, 'T6', 'C1', 1000, 100, 0.50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, albumid FROM (SELECT * FROM album AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM track WHERE (unitprice <= 1.0)) AS RHS WHERE (LHS.albumid = RHS.albumid))) ORDER BY title, albumid NULLS LAST;

/*
Gold Result:
('Album Expensive', 3)
*/

-- Prediction Query
SELECT T1.Title, T2.AlbumID FROM ALBUM AS T1 JOIN TRACK AS T2 ON T1.AlbumId = T2.AlbumId WHERE T2.UnitPrice > 1 GROUP BY T2.AlbumID;

/*
Prediction Result:
('Album Expensive', 3)
('Album Mixed', 4)
*/