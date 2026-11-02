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
INSERT INTO "employee" ("employeeid", "reportsto", "lastname", "firstname", "title", "birthdate", "hiredate", "address", "city", "state", "country", "postalcode", "phone", "fax", "email") VALUES (1028, 1029, 'Morris', 'Scott', 'Engineer, production', '1996-05-04', '1970-08-07', '148 Davis Terrace
Lake Lance, AS 26601', 'Calgary', 'Georgia', 'Anguilla', '06558', '643.748.7347x143', 'either', 'dianasmith@example.org');
INSERT INTO "employee" ("employeeid", "reportsto", "lastname", "firstname", "title", "birthdate", "hiredate", "address", "city", "state", "country", "postalcode", "phone", "fax", "email") VALUES (1030, 1031, 'Osborne', 'Eric', 'Scientist, marine', '1998-07-06', '1997-06-05', '72788 Dodson Mills
Rivasside, NV 21362', 'Calgary', 'West Virginia', 'Tokelau', '62717', '979.817.6936', 'front', 'taylorjesse@example.net');
INSERT INTO "employee" ("employeeid", "reportsto", "lastname", "firstname", "title", "birthdate", "hiredate", "address", "city", "state", "country", "postalcode", "phone", "fax", "email") VALUES (1029, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "employee" ("employeeid", "reportsto", "lastname", "firstname", "title", "birthdate", "hiredate", "address", "city", "state", "country", "postalcode", "phone", "fax", "email") VALUES (1031, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "firstname", "lastname" FROM "employee" WHERE ("city" = 'Calgary') ORDER BY firstname, employee.employeeid NULLS LAST;

/*
Gold Result:
('Eric', 'Osborne')
('Scott', 'Morris')
*/

-- Prediction Query
SELECT FirstName, LastName FROM EMPLOYEE WHERE City = 'Calgary';

/*
Prediction Result:
('Scott', 'Morris')
('Eric', 'Osborne')
*/