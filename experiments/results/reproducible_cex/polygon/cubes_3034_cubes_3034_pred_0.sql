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
INSERT INTO "Album" ("albumid", "artistid", "title") VALUES (42, 43, 'Metallica44');
INSERT INTO "Album" ("albumid", "artistid", "title") VALUES (23, NULL, 'Metallica43');
INSERT INTO "Artist" ("artistid", "name") VALUES (43, 'Metallica');
INSERT INTO "Artist" ("artistid", "name") VALUES (24, 'Metallica43');
INSERT INTO "Customer" ("customerid", "supportrepid", "firstname", "lastname", "company", "address", "city", "state", "country", "postalcode", "phone", "fax", "email") VALUES (25, 26, 'Metallica43', 'Metallica43', 'Metallica43', 'Metallica43', 'Metallica43', 'Metallica43', 'Metallica43', 'Metallica43', 'Metallica43', 'Metallica43', 'Metallica43');
INSERT INTO "Employee" ("employeeid", "reportsto", "lastname", "firstname", "title", "birthdate", "hiredate", "address", "city", "state", "country", "postalcode", "phone", "fax", "email") VALUES (26, 27, 'Metallica43', 'Metallica43', 'Metallica43', 43, 43, 'Metallica43', 'Metallica43', 'Metallica43', 'Metallica43', 'Metallica43', 'Metallica43', 'Metallica43', 'Metallica43');
INSERT INTO "Employee" ("employeeid", "reportsto", "lastname", "firstname", "title", "birthdate", "hiredate", "address", "city", "state", "country", "postalcode", "phone", "fax", "email") VALUES (27, 26, 'Metallica43', 'Metallica43', 'Metallica43', 43, 43, 'Metallica43', 'Metallica43', 'Metallica43', 'Metallica43', 'Metallica43', 'Metallica43', 'Metallica43', 'Metallica43');
INSERT INTO "Invoice" ("invoiceid", "customerid", "invoicedate", "billingaddress", "billingcity", "billingstate", "billingcountry", "billingpostalcode", "total") VALUES (30, 25, 43, 'Metallica43', 'Metallica43', 'Metallica43', 'Metallica43', 'Metallica43', 43);
INSERT INTO "MediaType" ("mediatypeid", "name") VALUES (34, 'Metallica43');
INSERT INTO "Playlist" ("playlistid", "name") VALUES (36, 'Metallica43');
INSERT INTO "Track" ("trackid", "mediatypeid", "genreid", "albumid", "name", "composer", "milliseconds", "bytes", "unitprice") VALUES (33, 34, NULL, 23, 'Metallica43', 'Metallica43', 43, 43, 43);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "name", COUNT(*) AS "n" FROM (SELECT "LHS"."albumid" AS "albumid", "LHS"."title" AS "title", "LHS"."artistid" AS "artistid", "RHS"."name" AS "name" FROM "album" AS "LHS" INNER JOIN "artist" AS "RHS" ON ("LHS"."artistid" = "RHS"."artistid")) GROUP BY "name") WHERE ("name" = 'Metallica') ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM ALBUM AS T1 JOIN ARTIST AS T2 ON T1.ArtistId = T2.ArtistId WHERE T2.Name = 'Metallica';

/*
Prediction Result:
(1,)
*/