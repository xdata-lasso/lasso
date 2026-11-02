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
INSERT INTO "artist" ("artistid", "name") VALUES (1018, 'Brent Abbott');
INSERT INTO "artist" ("artistid", "name") VALUES (1026, 'Michele Williams');
INSERT INTO "genre" ("genreid", "name") VALUES (1019, 'Renee Blair');
INSERT INTO "genre" ("genreid", "name") VALUES (1027, 'Dylan Miller');
INSERT INTO "mediatype" ("mediatypeid", "name") VALUES (1020, 'Valerie Gray');
INSERT INTO "mediatype" ("mediatypeid", "name") VALUES (1028, 'Brian Ramirez');
INSERT INTO "album" ("albumid", "artistid", "title") VALUES (1021, 1018, 'Sub');
INSERT INTO "album" ("albumid", "artistid", "title") VALUES (1029, 1026, 'Medical sales representative');
INSERT INTO "track" ("trackid", "mediatypeid", "genreid", "albumid", "name", "composer", "milliseconds", "bytes", "unitprice") VALUES (1022, 1020, 1019, 1021, 'Henry Santiago', 'high', 1023, 1024, 1026.5);
INSERT INTO "track" ("trackid", "mediatypeid", "genreid", "albumid", "name", "composer", "milliseconds", "bytes", "unitprice") VALUES (1030, 1028, 1027, 1029, 'Mark Mcclure', 'science', 1024, 1025, 1025.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT unitprice FROM track ORDER BY unitprice;

/*
Gold Result:
(1025.5,)
(1026.5,)
*/

-- Prediction Query
SELECT DISTINCT (UnitPrice) FROM TRACK;

/*
Prediction Result:
(1026.5,)
(1025.5,)
*/