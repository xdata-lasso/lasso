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
INSERT INTO "employee" ("employeeid", "reportsto", "lastname", "firstname", "title", "birthdate", "hiredate", "address", "city", "state", "country", "postalcode", "phone", "fax", "email") VALUES (1006, 1007, 'Henderson', 'Bryan', 'Museum/gallery curator', '1973-04-04', '1974-05-05', '480 Erin Plain Suite 514
Mooretown, VA 94830', 'Teresaburgh', 'North Carolina', 'United States Minor Outlying Islands', '14448', '+1-948-293-2528x8095', 'brother', 'natasha43@example.org');
INSERT INTO "employee" ("employeeid", "reportsto", "lastname", "firstname", "title", "birthdate", "hiredate", "address", "city", "state", "country", "postalcode", "phone", "fax", "email") VALUES (1007, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "customer" ("customerid", "supportrepid", "firstname", "lastname", "company", "address", "city", "state", "country", "postalcode", "phone", "fax", "email") VALUES (1008, 1006, 'Laura', 'Gruber', 'Astrid', 'Astrid', 'Astrid', 'Astrid', 'Astrid', 'Astrid', 'Astrid', 'Astrid', 'Astrid');
INSERT INTO "invoice" ("invoiceid", "customerid", "invoicedate", "billingaddress", "billingcity", "billingstate", "billingcountry", "billingpostalcode", "total") VALUES (1009, 1008, '1975-06-06', '71822 Arroyo Expressway
Allisonchester, IL 71187', 'Lake Larry', 'Texas', 'Pakistan', '49445', 1010.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "invoicedate" FROM (SELECT * FROM "invoice" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "customer" WHERE ("firstname" <> 'Astrid' AND "lastname" <> 'Gruber')) AS RHS WHERE (LHS.customerid = RHS.customerid))) ORDER BY invoicedate, "invoicedate" NULLS LAST;

/*
Gold Result:
('1975-06-06',)
*/

-- Prediction Query
SELECT T2.InvoiceDate FROM CUSTOMER AS T1 JOIN INVOICE AS T2 ON T1.CustomerId = T2.CustomerId WHERE T1.FirstName = 'Astrid' AND LastName = 'Gruber';

/*
Prediction Result:
*/