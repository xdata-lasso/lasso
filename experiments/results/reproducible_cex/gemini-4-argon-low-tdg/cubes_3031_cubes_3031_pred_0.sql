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
-- Core test: Duplicates, unsorted insertion order, and divergence from Customer.Country and Employee.Country
INSERT INTO Employee (EmployeeId, FirstName, LastName, Country) VALUES (1, 'Jane', 'Peacock', 'United Kingdom');
INSERT INTO Customer (CustomerId, SupportRepId, FirstName, LastName, Country, Email) VALUES (1, 1, 'Luís', 'Gonçalves', 'Brazil', 'luisg@embraer.com.br');
INSERT INTO Customer (CustomerId, SupportRepId, FirstName, LastName, Country, Email) VALUES (2, 1, 'Leonie', 'Köhler', 'Germany', 'leonekohler@surfeu.de');
INSERT INTO Customer (CustomerId, SupportRepId, FirstName, LastName, Country, Email) VALUES (3, 1, 'François', 'Tremblay', 'Canada', 'ftremblay@gmail.com');
INSERT INTO Invoice (InvoiceId, CustomerId, InvoiceDate, BillingAddress, BillingCity, BillingState, BillingCountry, BillingPostalCode, Total) VALUES (1, 1, '2023-01-15 00:00:00', '123 Maple St', 'Toronto', 'ON', 'USA', '10001', 15.50);
INSERT INTO Invoice (InvoiceId, CustomerId, InvoiceDate, BillingAddress, BillingCity, BillingState, BillingCountry, BillingPostalCode, Total) VALUES (2, 1, '2023-01-10 00:00:00', '456 Oak Ave', 'Paris', 'IDF', 'Argentina', '20002', 5.00);
INSERT INTO Invoice (InvoiceId, CustomerId, InvoiceDate, BillingAddress, BillingCity, BillingState, BillingCountry, BillingPostalCode, Total) VALUES (3, 2, '2023-01-20 00:00:00', '789 Pine Rd', 'Berlin', 'BE', 'USA', '30003', 25.00);
INSERT INTO Invoice (InvoiceId, CustomerId, InvoiceDate, BillingAddress, BillingCity, BillingState, BillingCountry, BillingPostalCode, Total) VALUES (4, 1, '2023-01-05 00:00:00', '321 Elm St', 'London', 'LDN', 'Denmark', '40004', 10.00);
INSERT INTO Invoice (InvoiceId, CustomerId, InvoiceDate, BillingAddress, BillingCity, BillingState, BillingCountry, BillingPostalCode, Total) VALUES (5, 2, '2023-01-25 00:00:00', '654 Birch Ln', 'Madrid', 'MD', 'Argentina', '50005', 30.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT billingcountry FROM invoice ORDER BY billingcountry;

/*
Gold Result:
('Argentina',)
('Denmark',)
('USA',)
*/

-- Prediction Query
SELECT DISTINCT (BillingCountry) FROM INVOICE;

/*
Prediction Result:
('USA',)
('Argentina',)
('Denmark',)
*/