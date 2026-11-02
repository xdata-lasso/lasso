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
INSERT INTO Artist (ArtistId, Name) VALUES (1, 'AudioSlave');
INSERT INTO Artist (ArtistId, Name) VALUES (2, 'BackBeat');
INSERT INTO Album (AlbumId, ArtistId, Title) VALUES (1, 1, 'Out of Exile');
INSERT INTO MediaType (MediaTypeId, Name) VALUES (1, 'MPEG audio file');
INSERT INTO Genre (GenreId, Name) VALUES (1, 'Rock');
INSERT INTO Genre (GenreId, Name) VALUES (2, 'Jazz');
INSERT INTO Genre (GenreId, Name) VALUES (3, 'Blues');
INSERT INTO Genre (GenreId, Name) VALUES (4, 'Jazz');
INSERT INTO Genre (GenreId, Name) VALUES (5, 'Alternative');
INSERT INTO Playlist (PlaylistId, Name) VALUES (1, 'Music');
INSERT INTO Track (TrackId, MediaTypeId, GenreId, AlbumId, Name, Composer, Milliseconds, Bytes, UnitPrice) VALUES (1, 1, 1, 1, 'Track One', 'Composer A', 200000, 5000000, 0.99);
INSERT INTO Track (TrackId, MediaTypeId, GenreId, AlbumId, Name, Composer, Milliseconds, Bytes, UnitPrice) VALUES (2, 1, 1, 1, 'Track Two', 'Composer A', 210000, 5100000, 0.99);
INSERT INTO Track (TrackId, MediaTypeId, GenreId, AlbumId, Name, Composer, Milliseconds, Bytes, UnitPrice) VALUES (3, 1, 2, 1, 'Track Three', 'Composer B', 180000, 4000000, 1.99);
INSERT INTO PlaylistTrack (PlaylistId, TrackId) VALUES (1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM genre ORDER BY name, genre.genreid NULLS LAST;

/*
Gold Result:
('Alternative',)
('Blues',)
('Jazz',)
('Jazz',)
('Rock',)
*/

-- Prediction Query
SELECT Name FROM GENRE;

/*
Prediction Result:
('Rock',)
('Jazz',)
('Blues',)
('Jazz',)
('Alternative',)
*/