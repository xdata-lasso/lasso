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
INSERT INTO Artist (ArtistId, Name) VALUES (1, 'Charlie');
INSERT INTO Artist (ArtistId, Name) VALUES (2, 'Zebra');
INSERT INTO Artist (ArtistId, Name) VALUES (3, 'Bravo');
INSERT INTO Artist (ArtistId, Name) VALUES (4, 'Alpha');
INSERT INTO Album (AlbumId, ArtistId, Title) VALUES (10, 1, 'Charlie 1');
INSERT INTO Album (AlbumId, ArtistId, Title) VALUES (20, 2, 'Zebra 1');
INSERT INTO Album (AlbumId, ArtistId, Title) VALUES (21, 2, 'Zebra 2');
INSERT INTO Album (AlbumId, ArtistId, Title) VALUES (22, 2, 'Zebra 3');
INSERT INTO Album (AlbumId, ArtistId, Title) VALUES (30, 3, 'Bravo 1');
INSERT INTO Album (AlbumId, ArtistId, Title) VALUES (31, 3, 'Bravo 2');
INSERT INTO Album (AlbumId, ArtistId, Title) VALUES (32, 3, 'Bravo 3');
INSERT INTO Album (AlbumId, ArtistId, Title) VALUES (40, 4, 'Alpha 1');
INSERT INTO Album (AlbumId, ArtistId, Title) VALUES (41, 4, 'Alpha 2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.artistid AS artistid, LHS.name AS name, LHS.n AS n FROM (SELECT LHS.artistid AS artistid, LHS.name AS name, RHS.n AS n FROM artist AS LHS INNER JOIN (SELECT artistid, COUNT(*) AS n FROM album GROUP BY artistid) AS RHS ON (LHS.artistid = RHS.artistid)) AS LHS INNER JOIN (SELECT MAX(n) AS n FROM (SELECT artistid, COUNT(*) AS n FROM album GROUP BY artistid)) AS RHS ON (LHS.n = RHS.n)) ORDER BY name;

/*
Gold Result:
('Bravo',)
('Zebra',)
*/

-- Prediction Query
SELECT T2.Name FROM ALBUM AS T1 JOIN ARTIST AS T2 ON T1.ArtistId = T2.ArtistId GROUP BY T2.Name ORDER BY COUNT(*) DESC, T2.Name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Bravo',)
*/