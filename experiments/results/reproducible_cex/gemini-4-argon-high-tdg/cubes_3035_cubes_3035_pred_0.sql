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
INSERT INTO "Employee" ("EmployeeId", "ReportsTo", "LastName", "FirstName", "Title", "BirthDate", "HireDate", "Address", "City", "State", "Country", "PostalCode", "Phone", "Fax", "Email") VALUES (1, NULL, 'Adams', 'Andrew', 'General Manager', '1980-06-15 00:00:00', '2002-01-10 00:00:00', '11120 Jasper Ave NW', 'Edmonton', 'AB', 'Canada', 'T5K 2N1', '+1 (780) 428-9482', '+1 (780) 428-3457', 'andrew@chinookcorp.com');
INSERT INTO "Employee" ("EmployeeId", "ReportsTo", "LastName", "FirstName", "Title", "BirthDate", "HireDate", "Address", "City", "State", "Country", "PostalCode", "Phone", "Fax", "Email") VALUES (2, 1, 'Edwards', 'Nancy', 'Sales Manager', '1965-02-20 00:00:00', '2004-05-12 00:00:00', '825 8 Ave SW', 'Edmonton', 'AB', 'Canada', 'T2P 2T3', '+1 (780) 262-3443', '+1 (780) 262-3322', 'nancy@chinookcorp.com');
INSERT INTO "Employee" ("EmployeeId", "ReportsTo", "LastName", "FirstName", "Title", "BirthDate", "HireDate", "Address", "City", "State", "Country", "PostalCode", "Phone", "Fax", "Email") VALUES (3, 1, 'Peacock', 'Jane', 'Sales Support Agent', '1972-11-03 00:00:00', '2003-08-01 00:00:00', '1111 6 Ave SW', 'Edmonton', 'AB', 'Canada', 'T2P 5M5', '+1 (780) 262-6712', '+1 (780) 262-6712', 'jane@chinookcorp.com');
INSERT INTO "Employee" ("EmployeeId", "ReportsTo", "LastName", "FirstName", "Title", "BirthDate", "HireDate", "Address", "City", "State", "Country", "PostalCode", "Phone", "Fax", "Email") VALUES (4, 1, 'Park', 'Margaret', 'Sales Support Agent', '1958-01-01 00:00:00', '2001-01-01 00:00:00', '683 10 Street SW', 'Calgary', 'AB', 'Canada', 'T2P 5G3', '+1 (403) 263-4423', '+1 (403) 263-4289', 'margaret@chinookcorp.com');
INSERT INTO "Customer" ("CustomerId", "SupportRepId", "FirstName", "LastName", "Company", "Address", "City", "State", "Country", "PostalCode", "Phone", "Fax", "Email") VALUES (1, 4, 'Mark', 'Philips', 'Telus', '8210 111 St', 'Edmonton', 'AB', 'Canada', 'T6G 2C5', '+1 (780) 439-5555', NULL, 'mphilips@telus.ca');
INSERT INTO "Customer" ("CustomerId", "SupportRepId", "FirstName", "LastName", "Company", "Address", "City", "State", "Country", "PostalCode", "Phone", "Fax", "Email") VALUES (2, 2, 'Martha', 'Silk', NULL, '100 Main St', 'Calgary', 'AB', 'Canada', 'T2P 1J9', '+1 (403) 555-0199', NULL, 'msilk@example.com');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "birthdate" FROM "employee" WHERE ("city" = 'Edmonton') ORDER BY birthdate, employee.employeeid NULLS LAST;

/*
Gold Result:
('1965-02-20 00:00:00',)
('1972-11-03 00:00:00',)
('1980-06-15 00:00:00',)
*/

-- Prediction Query
SELECT BirthDate FROM EMPLOYEE WHERE City = 'Edmonton';

/*
Prediction Result:
('1980-06-15 00:00:00',)
('1965-02-20 00:00:00',)
('1972-11-03 00:00:00',)
*/