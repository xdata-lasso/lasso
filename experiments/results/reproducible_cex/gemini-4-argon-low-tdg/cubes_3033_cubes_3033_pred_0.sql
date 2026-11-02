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
INSERT INTO "Employee" ("EmployeeId", "FirstName", "LastName", "City") VALUES (1, 'Zack', 'Adams', 'Calgary');
INSERT INTO "Employee" ("EmployeeId", "FirstName", "LastName", "City") VALUES (2, 'Alice', 'Zebra', 'Calgary');
INSERT INTO "Employee" ("EmployeeId", "FirstName", "LastName", "City") VALUES (3, 'Alice', 'Baker', 'Calgary');
INSERT INTO "Employee" ("EmployeeId", "FirstName", "LastName", "City") VALUES (4, 'Bob', 'Smith', 'Edmonton');
INSERT INTO "Employee" ("EmployeeId", "FirstName", "LastName", "City") VALUES (5, 'Charlie', 'Brown', 'calgary');
INSERT INTO "Employee" ("EmployeeId", "FirstName", "LastName", "City") VALUES (6, 'David', 'Jones', 'Calgary Downtown');
INSERT INTO "Employee" ("EmployeeId", "FirstName", "LastName", "City") VALUES (7, 'Eve', 'White', NULL);
INSERT INTO "Customer" ("CustomerId", "SupportRepId", "FirstName", "LastName", "City") VALUES (1, NULL, 'CustFirst', 'CustLast', 'Calgary');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "firstname", "lastname" FROM "employee" WHERE ("city" = 'Calgary') ORDER BY firstname, employee.employeeid NULLS LAST;

/*
Gold Result:
('Alice', 'Zebra')
('Alice', 'Baker')
('Zack', 'Adams')
*/

-- Prediction Query
SELECT FirstName, LastName FROM EMPLOYEE WHERE City = 'Calgary';

/*
Prediction Result:
('Zack', 'Adams')
('Alice', 'Zebra')
('Alice', 'Baker')
*/