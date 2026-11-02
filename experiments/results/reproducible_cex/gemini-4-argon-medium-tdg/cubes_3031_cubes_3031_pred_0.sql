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
-- Core test: Duplicates, out-of-order insertion, and differences between Invoice.BillingCountry, Customer.Country, Employee.Country, and other Invoice fields.
INSERT INTO "Employee" ("EmployeeId", "LastName", "FirstName", "Country") VALUES (1, 'Adams', 'Andrew', 'Mexico');
INSERT INTO "Employee" ("EmployeeId", "LastName", "FirstName", "Country") VALUES (2, 'Edwards', 'Nancy', 'Japan');
INSERT INTO "Customer" ("CustomerId", "SupportRepId", "FirstName", "LastName", "Country", "Email") VALUES (1, 1, 'Luís', 'Gonçalves', 'United Kingdom', 'luis@test.com');
INSERT INTO "Customer" ("CustomerId", "SupportRepId", "FirstName", "LastName", "Country", "Email") VALUES (2, 2, 'Leonie', 'Köhler', 'Australia', 'leonie@test.com');
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (1, 1, '2023-05-01 00:00:00', '123 Main', 'Paris', 'NY', 'USA', '10001', 15.50);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (2, 1, '2023-01-01 00:00:00', '456 Oak', 'Berlin', 'TX', 'Germany', '75001', 5.00);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (3, 2, '2023-03-01 00:00:00', '789 Pine', 'London', 'CA', 'Canada', '90210', 25.00);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (4, 2, '2023-02-01 00:00:00', '101 Maple', 'Toronto', 'ON', 'USA', 'M5V', 10.00);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (5, 1, '2023-04-01 00:00:00', '202 Birch', 'Sydney', 'NSW', 'Brazil', '2000', 50.00);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (6, 2, '2023-06-01 00:00:00', '303 Cedar', 'Tokyo', 'TK', 'Canada', '100', 5.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT billingcountry FROM invoice ORDER BY billingcountry;

/*
Gold Result:
('Brazil',)
('Canada',)
('Germany',)
('USA',)
*/

-- Prediction Query
SELECT DISTINCT (BillingCountry) FROM INVOICE;

/*
Prediction Result:
('USA',)
('Germany',)
('Canada',)
('Brazil',)
*/