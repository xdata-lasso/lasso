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
INSERT INTO "Album" ("albumid", "artistid", "title") VALUES (15, NULL, '142');
INSERT INTO "Artist" ("artistid", "name") VALUES (16, '142');
INSERT INTO "Artist" ("artistid", "name") VALUES (17, '142');
INSERT INTO "Customer" ("customerid", "supportrepid", "firstname", "lastname", "company", "address", "city", "state", "country", "postalcode", "phone", "fax", "email") VALUES (18, 21, '142', '142', '142', '142', '142', '142', '142', '142', '142', '142', '142');
INSERT INTO "Employee" ("employeeid", "reportsto", "lastname", "firstname", "title", "birthdate", "hiredate", "address", "city", "state", "country", "postalcode", "phone", "fax", "email") VALUES (20, 21, '142', '142', '142', 142, 142, '142', '142', '142', '142', '142', '142', '142', '142');
INSERT INTO "Employee" ("employeeid", "reportsto", "lastname", "firstname", "title", "birthdate", "hiredate", "address", "city", "state", "country", "postalcode", "phone", "fax", "email") VALUES (21, 21, '142', '142', '142', 142, 142, '142', '142', '142', '142', '142', '142', '142', '142');
INSERT INTO "Genre" ("genreid", "name") VALUES (22, '142');
INSERT INTO "Invoice" ("invoiceid", "customerid", "invoicedate", "billingaddress", "billingcity", "billingstate", "billingcountry", "billingpostalcode", "total") VALUES (24, 18, 142, '142', '142', '142', '142', '142', 142);
INSERT INTO "Invoice" ("invoiceid", "customerid", "invoicedate", "billingaddress", "billingcity", "billingstate", "billingcountry", "billingpostalcode", "total") VALUES (23, NULL, 142, '142', '142', '142', '142', '142', 142);
INSERT INTO "InvoiceLine" ("invoicelineid", "trackid", "invoiceid", "unitprice", "quantity") VALUES (26, 27, 23, 142, 142);
INSERT INTO "MediaType" ("mediatypeid", "name") VALUES (30, '142');
INSERT INTO "MediaType" ("mediatypeid", "name") VALUES (29, '142');
INSERT INTO "Playlist" ("playlistid", "name") VALUES (31, '142');
INSERT INTO "PlaylistTrack" ("playlistid", "trackid") VALUES (31, 28);
INSERT INTO "Track" ("trackid", "mediatypeid", "genreid", "albumid", "name", "composer", "milliseconds", "bytes", "unitprice") VALUES (27, 29, 22, 15, '32', '33', 142, 34, 35);
INSERT INTO "Track" ("trackid", "mediatypeid", "genreid", "albumid", "name", "composer", "milliseconds", "bytes", "unitprice") VALUES (28, 29, 22, 15, '142', '142', -719, 142, 142);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT maxmilliseconds AS max_milliseconds_, MIN(milliseconds) OVER () AS min_milliseconds_ FROM (SELECT trackid, name, albumid, mediatypeid, genreid, composer, milliseconds, bytes, unitprice, MAX(milliseconds) OVER () AS maxmilliseconds FROM track) ORDER BY max_milliseconds_, min_milliseconds_ NULLS LAST;

/*
Gold Result:
(142, -719)
*/

-- Prediction Query
SELECT MAX(Milliseconds), MIN(Milliseconds) FROM TRACK;

/*
Prediction Result:
(142, -719)
*/