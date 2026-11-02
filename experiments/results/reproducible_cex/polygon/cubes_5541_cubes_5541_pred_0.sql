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
INSERT INTO "Album" ("albumid", "artistid", "title") VALUES (25, 26, NULL);
INSERT INTO "Album" ("albumid", "artistid", "title") VALUES (24, 27, '52');
INSERT INTO "Artist" ("artistid", "name") VALUES (26, '48');
INSERT INTO "Artist" ("artistid", "name") VALUES (27, '48');
INSERT INTO "Customer" ("customerid", "supportrepid", "firstname", "lastname", "company", "address", "city", "state", "country", "postalcode", "phone", "fax", "email") VALUES (28, NULL, '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO "Employee" ("employeeid", "reportsto", "lastname", "firstname", "title", "birthdate", "hiredate", "address", "city", "state", "country", "postalcode", "phone", "fax", "email") VALUES (29, 30, '1', '1', '1', 1, 1, '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO "Employee" ("employeeid", "reportsto", "lastname", "firstname", "title", "birthdate", "hiredate", "address", "city", "state", "country", "postalcode", "phone", "fax", "email") VALUES (30, 30, '1', '1', '1', 1, 1, '1', '1', '1', '1', '1', '1', '1', '1');
INSERT INTO "Genre" ("genreid", "name") VALUES (32, '1');
INSERT INTO "Genre" ("genreid", "name") VALUES (31, '1');
INSERT INTO "Invoice" ("invoiceid", "customerid", "invoicedate", "billingaddress", "billingcity", "billingstate", "billingcountry", "billingpostalcode", "total") VALUES (33, 28, 1, '1', '1', '1', '1', '1', 1);
INSERT INTO "InvoiceLine" ("invoicelineid", "trackid", "invoiceid", "unitprice", "quantity") VALUES (36, 37, NULL, 1, 1);
INSERT INTO "MediaType" ("mediatypeid", "name") VALUES (39, '1');
INSERT INTO "MediaType" ("mediatypeid", "name") VALUES (38, '1');
INSERT INTO "Playlist" ("playlistid", "name") VALUES (41, '1');
INSERT INTO "Playlist" ("playlistid", "name") VALUES (40, '1');
INSERT INTO "Track" ("trackid", "mediatypeid", "genreid", "albumid", "name", "composer", "milliseconds", "bytes", "unitprice") VALUES (37, 39, 31, 24, '1', '1', 1, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.artistid AS artistid, LHS.name AS name, LHS.n AS n FROM (SELECT LHS.artistid AS artistid, LHS.name AS name, RHS.n AS n FROM artist AS LHS INNER JOIN (SELECT artistid, COUNT(*) AS n FROM album GROUP BY artistid) AS RHS ON (LHS.artistid = RHS.artistid)) AS LHS INNER JOIN (SELECT MAX(n) AS n FROM (SELECT artistid, COUNT(*) AS n FROM album GROUP BY artistid)) AS RHS ON (LHS.n = RHS.n)) ORDER BY name;

/*
Gold Result:
('48',)
('48',)
*/

-- Prediction Query
SELECT T2.Name FROM ALBUM AS T1 JOIN ARTIST AS T2 ON T1.ArtistId = T2.ArtistId GROUP BY T2.Name ORDER BY COUNT(*) DESC, T2.Name NULLS LAST LIMIT 1;

/*
Prediction Result:
('48',)
*/