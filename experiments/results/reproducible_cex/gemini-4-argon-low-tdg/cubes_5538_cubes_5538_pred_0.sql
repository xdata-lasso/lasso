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
INSERT INTO "Employee" ("EmployeeId", "FirstName", "LastName", "Email") VALUES (1, 'Andrew', 'Adams', 'luisg@embraer.com.br');
INSERT INTO "Customer" ("CustomerId", "SupportRepId", "FirstName", "LastName", "Email") VALUES (10, 1, 'Zoe', 'Alpha', 'luisg@embraer.com.br');
INSERT INTO "Customer" ("CustomerId", "SupportRepId", "FirstName", "LastName", "Email") VALUES (20, NULL, 'Aaron', 'Zeta', 'luisg@embraer.com.br');
INSERT INTO "Customer" ("CustomerId", "SupportRepId", "FirstName", "LastName", "Email") VALUES (30, 1, 'Aaron', 'Beta', 'luisg@embraer.com.br');
INSERT INTO "Customer" ("CustomerId", "SupportRepId", "FirstName", "LastName", "Email") VALUES (40, 1, 'Carlos', 'Gamma', 'LUISG@EMBRAER.COM.BR');
INSERT INTO "Customer" ("CustomerId", "SupportRepId", "FirstName", "LastName", "Email") VALUES (50, 1, 'Diana', 'Delta', 'luisg@embraer.com.br.org');
INSERT INTO "Customer" ("CustomerId", "SupportRepId", "FirstName", "LastName", "Email") VALUES (60, 1, 'Evan', 'Epsilon', NULL);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "Total") VALUES (100, 10, 9.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "Total") VALUES (101, 10, 19.99);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "firstname", "lastname" FROM "customer" WHERE ("email" = 'luisg@embraer.com.br') ORDER BY firstname, customer.customerid NULLS LAST;

/*
Gold Result:
('Aaron', 'Zeta')
('Aaron', 'Beta')
('Zoe', 'Alpha')
*/

-- Prediction Query
SELECT FirstName, LastName FROM CUSTOMER WHERE Email = 'luisg@embraer.com.br';

/*
Prediction Result:
('Zoe', 'Alpha')
('Aaron', 'Zeta')
('Aaron', 'Beta')
*/