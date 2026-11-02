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
INSERT INTO "employee" ("employeeid", "reportsto", "lastname", "firstname", "title", "birthdate", "hiredate", "address", "city", "state", "country", "postalcode", "phone", "fax", "email") VALUES (1012, 1013, 'Valdez', 'Debbie', 'Biochemist, clinical', '1976-07-07', '1977-08-08', '33387 Robert Harbors Suite 317
North Deniseside, MP 02435', 'Port Melindaburgh', 'Nebraska', 'Libyan Arab Jamahiriya', '63593', '660.826.0647', 'same', 'smoore@example.org');
INSERT INTO "employee" ("employeeid", "reportsto", "lastname", "firstname", "title", "birthdate", "hiredate", "address", "city", "state", "country", "postalcode", "phone", "fax", "email") VALUES (1017, 1018, 'Moore', 'Juan', 'Engineer, materials', '1979-10-10', '1980-11-11', '487 Whitehead Vista
North Cynthiaview, AZ 00965', 'Kellieview', 'Hawaii', 'Saint Vincent and the Grenadines', '58413', '+1-768-401-1280', 'law', 'bobbydiaz@example.org');
INSERT INTO "employee" ("employeeid", "reportsto", "lastname", "firstname", "title", "birthdate", "hiredate", "address", "city", "state", "country", "postalcode", "phone", "fax", "email") VALUES (1013, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "employee" ("employeeid", "reportsto", "lastname", "firstname", "title", "birthdate", "hiredate", "address", "city", "state", "country", "postalcode", "phone", "fax", "email") VALUES (1018, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "customer" ("customerid", "supportrepid", "firstname", "lastname", "company", "address", "city", "state", "country", "postalcode", "phone", "fax", "email") VALUES (1014, 1012, 'Tanya', 'Riley', 'Brown, Edwards and Williams', '81219 Emma Freeway
Wilsonshire, IA 76381', 'New Christophershire', 'Oregon', 'Mali', '41968', '935-334-6247x510', 'back', 'williamanderson@example.com');
INSERT INTO "customer" ("customerid", "supportrepid", "firstname", "lastname", "company", "address", "city", "state", "country", "postalcode", "phone", "fax", "email") VALUES (1019, 1017, 'Rachel', 'Clark', 'Estrada LLC', '232 Nicole Burg Apt. 563
Erikville, MS 05576', 'Walkermouth', 'Minnesota', 'Gambia', '30332', '803.765.4145', 'wrong', 'wilsontara@example.org');
INSERT INTO "invoice" ("invoiceid", "customerid", "invoicedate", "billingaddress", "billingcity", "billingstate", "billingcountry", "billingpostalcode", "total") VALUES (1015, 1014, '1978-09-09', '19655 Obrien Pass Apt. 693
Bradleychester, AL 68647', 'West Darrell', 'Connecticut', 'Samoa', '43780', 1016.5);
INSERT INTO "invoice" ("invoiceid", "customerid", "invoicedate", "billingaddress", "billingcity", "billingstate", "billingcountry", "billingpostalcode", "total") VALUES (1020, 1019, '1981-01-12', '4278 Carr Valley
Lake Lisaport, TN 14078', 'West Ryan', 'Texas', 'Nigeria', '73013', 1021.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT billingcountry FROM invoice ORDER BY billingcountry;

/*
Gold Result:
('Nigeria',)
('Samoa',)
*/

-- Prediction Query
SELECT DISTINCT (BillingCountry) FROM INVOICE;

/*
Prediction Result:
('Samoa',)
('Nigeria',)
*/