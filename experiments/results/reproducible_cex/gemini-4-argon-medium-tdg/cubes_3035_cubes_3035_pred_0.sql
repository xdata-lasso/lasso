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
-- Tests basic WHERE filtering ('Edmonton' vs other cities, NULL city, case sensitivity, substring)
-- and basic ORDER BY BirthDate ASC (inserted out of chronological order).
INSERT INTO "Employee" ("EmployeeId", "LastName", "FirstName", "Title", "BirthDate", "HireDate", "Address", "City", "State", "Country") VALUES (1, 'Adams', 'Andrew', 'General Manager', '1975-05-15 00:00:00', '2002-08-14 00:00:00', '11120 Jasper Ave NW', 'Edmonton', 'AB', 'Canada');
INSERT INTO "Employee" ("EmployeeId", "LastName", "FirstName", "Title", "BirthDate", "HireDate", "Address", "City", "State", "Country") VALUES (2, 'Edwards', 'Nancy', 'Sales Manager', '1962-02-18 00:00:00', '2002-05-01 00:00:00', '825 8 Ave SW', 'Calgary', 'AB', 'Canada');
INSERT INTO "Employee" ("EmployeeId", "LastName", "FirstName", "Title", "BirthDate", "HireDate", "Address", "City", "State", "Country") VALUES (3, 'Peacock', 'Jane', 'Sales Support Agent', '1968-08-29 00:00:00', '2002-04-01 00:00:00', '1111 6 Ave SW', 'Edmonton', 'AB', 'Canada');
INSERT INTO "Employee" ("EmployeeId", "LastName", "FirstName", "Title", "BirthDate", "HireDate", "Address", "City", "State", "Country") VALUES (4, 'Park', 'Margaret', 'Sales Support Agent', '1947-09-19 00:00:00', '2003-05-03 00:00:00', '683 10 Street SW', 'edmonton', 'AB', 'Canada');
INSERT INTO "Employee" ("EmployeeId", "LastName", "FirstName", "Title", "BirthDate", "HireDate", "Address", "City", "State", "Country") VALUES (5, 'Johnson', 'Steve', 'Sales Support Agent', '1965-03-03 00:00:00', '2003-10-17 00:00:00', '7727B 41 Ave', NULL, 'AB', 'Canada');
INSERT INTO "Employee" ("EmployeeId", "LastName", "FirstName", "Title", "BirthDate", "HireDate", "Address", "City", "State", "Country") VALUES (6, 'Mitchell', 'Michael', 'IT Manager', '1973-07-01 00:00:00', '2003-10-17 00:00:00', '5827 Bowness Road NW', 'North Edmonton', 'AB', 'Canada');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "birthdate" FROM "employee" WHERE ("city" = 'Edmonton') ORDER BY birthdate, employee.employeeid NULLS LAST;

/*
Gold Result:
('1968-08-29 00:00:00',)
('1975-05-15 00:00:00',)
*/

-- Prediction Query
SELECT BirthDate FROM EMPLOYEE WHERE City = 'Edmonton';

/*
Prediction Result:
('1975-05-15 00:00:00',)
('1968-08-29 00:00:00',)
*/