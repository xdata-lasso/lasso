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
-- Inserting into table: employee --
INSERT INTO "employee" ("employeeid", "reportsto", "lastname", "firstname", "title", "birthdate", "hiredate", "address", "city", "state", "country", "postalcode", "phone", "fax", "email") VALUES (1, NULL, 'value', 'value', 'value', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 'value', 'value', 'value', 'value', 'value');

-- Inserting into table: customer --
INSERT INTO "customer" ("customerid", "supportrepid", "firstname", "lastname", "company", "address", "city", "state", "country", "postalcode", "phone", "fax", "email") VALUES (1, 1, 'Astrid', 'Gruber', 'cus_305247', 'cus_33aa93', 'cus_cca015', 'cus_f2b867', 'cus_645bc8', 'cus_f44787', 'cus_8b1d96', 'cus_b30fa7', 'cus_e178a3');

INSERT INTO "customer" ("customerid", "supportrepid", "firstname", "lastname", "company", "address", "city", "state", "country", "postalcode", "phone", "fax", "email") VALUES (-2147483647, 1, 'Astrid', 'Gruber', 'cus_305247', 'cus_33aa93', 'cus_cca015', 'cus_f2b867', 'cus_645bc8', 'cus_f44787', 'cus_8b1d96', 'cus_b30fa7', 'cus_e178a3');

INSERT INTO "customer" ("customerid", "supportrepid", "firstname", "lastname", "company", "address", "city", "state", "country", "postalcode", "phone", "fax", "email") VALUES (2, 1, 'Astrid', 'Gruber', 'cus_305247', 'cus_33aa93', 'cus_cca015', 'cus_f2b867', 'cus_645bc8', 'cus_f44787', 'cus_8b1d96', 'cus_b30fa7', 'cus_e178a3');

INSERT INTO "customer" ("customerid", "supportrepid", "firstname", "lastname", "company", "address", "city", "state", "country", "postalcode", "phone", "fax", "email") VALUES (3, 1, 'cus_63fa0a', 'cus_2ef46e', 'cus_305247', 'cus_33aa93', 'cus_cca015', 'cus_f2b867', 'cus_645bc8', 'cus_f44787', 'cus_8b1d96', 'cus_b30fa7', 'cus_e178a3');

INSERT INTO "customer" ("customerid", "supportrepid", "firstname", "lastname", "company", "address", "city", "state", "country", "postalcode", "phone", "fax", "email") VALUES (4, 1, 'Astrid', 't1__b0f72d', 'cus_305247', 'cus_33aa93', 'cus_cca015', 'cus_f2b867', 'cus_645bc8', 'cus_f44787', 'cus_8b1d96', 'cus_b30fa7', 'cus_e178a3');

INSERT INTO "customer" ("customerid", "supportrepid", "firstname", "lastname", "company", "address", "city", "state", "country", "postalcode", "phone", "fax", "email") VALUES (5, 1, 'Astrid', NULL, 'cus_305247', 'cus_33aa93', 'cus_cca015', 'cus_f2b867', 'cus_645bc8', 'cus_f44787', 'cus_8b1d96', 'cus_b30fa7', 'cus_e178a3');

INSERT INTO "customer" ("customerid", "supportrepid", "firstname", "lastname", "company", "address", "city", "state", "country", "postalcode", "phone", "fax", "email") VALUES (6, 1, 't1__753f31', 'Gruber', 'cus_305247', 'cus_33aa93', 'cus_cca015', 'cus_f2b867', 'cus_645bc8', 'cus_f44787', 'cus_8b1d96', 'cus_b30fa7', 'cus_e178a3');

INSERT INTO "customer" ("customerid", "supportrepid", "firstname", "lastname", "company", "address", "city", "state", "country", "postalcode", "phone", "fax", "email") VALUES (7, 1, 't1__753f31', NULL, 'cus_305247', 'cus_33aa93', 'cus_cca015', 'cus_f2b867', 'cus_645bc8', 'cus_f44787', 'cus_8b1d96', 'cus_b30fa7', 'cus_e178a3');

INSERT INTO "customer" ("customerid", "supportrepid", "firstname", "lastname", "company", "address", "city", "state", "country", "postalcode", "phone", "fax", "email") VALUES (8, 1, NULL, 'Gruber', 'cus_305247', 'cus_33aa93', 'cus_cca015', 'cus_f2b867', 'cus_645bc8', 'cus_f44787', 'cus_8b1d96', 'cus_b30fa7', 'cus_e178a3');

INSERT INTO "customer" ("customerid", "supportrepid", "firstname", "lastname", "company", "address", "city", "state", "country", "postalcode", "phone", "fax", "email") VALUES (9, 1, NULL, 't1__b0f72d', 'cus_305247', 'cus_33aa93', 'cus_cca015', 'cus_f2b867', 'cus_645bc8', 'cus_f44787', 'cus_8b1d96', 'cus_b30fa7', 'cus_e178a3');

INSERT INTO "customer" ("customerid", "supportrepid", "firstname", "lastname", "company", "address", "city", "state", "country", "postalcode", "phone", "fax", "email") VALUES (10, 1, NULL, NULL, 'cus_305247', 'cus_33aa93', 'cus_cca015', 'cus_f2b867', 'cus_645bc8', 'cus_f44787', 'cus_8b1d96', 'cus_b30fa7', 'cus_e178a3');

-- Inserting into table: invoice --
INSERT INTO "invoice" ("invoiceid", "customerid", "invoicedate", "billingaddress", "billingcity", "billingstate", "billingcountry", "billingpostalcode", "total") VALUES (-2147483648, 1, '2024-06-15 00:00:00+00:00', 'inv_f977dc', 'inv_db467b', 'inv_8293e0', 'inv_0abfd8', 'inv_a2a7fe', 0.01);

INSERT INTO "invoice" ("invoiceid", "customerid", "invoicedate", "billingaddress", "billingcity", "billingstate", "billingcountry", "billingpostalcode", "total") VALUES (2, 1, '2024-06-15 00:00:00+00:00', 'inv_f977dc', 'inv_db467b', 'inv_8293e0', 'inv_0abfd8', 'inv_a2a7fe', 0.02);

INSERT INTO "invoice" ("invoiceid", "customerid", "invoicedate", "billingaddress", "billingcity", "billingstate", "billingcountry", "billingpostalcode", "total") VALUES (3, 1, '2024-06-15 00:00:00+00:00', 'inv_f977dc', 'inv_db467b', 'inv_8293e0', 'inv_0abfd8', 'inv_a2a7fe', 0.03);

INSERT INTO "invoice" ("invoiceid", "customerid", "invoicedate", "billingaddress", "billingcity", "billingstate", "billingcountry", "billingpostalcode", "total") VALUES (-2147483645, 3, '2024-06-15 00:00:00+00:00', 'inv_f977dc', 'inv_db467b', 'inv_8293e0', 'inv_0abfd8', 'inv_a2a7fe', 0.04);

INSERT INTO "invoice" ("invoiceid", "customerid", "invoicedate", "billingaddress", "billingcity", "billingstate", "billingcountry", "billingpostalcode", "total") VALUES (-2147483644, 3, '2024-06-15 00:00:00+00:00', 'inv_f977dc', 'inv_db467b', 'inv_8293e0', 'inv_0abfd8', 'inv_a2a7fe', 0.05);

INSERT INTO "invoice" ("invoiceid", "customerid", "invoicedate", "billingaddress", "billingcity", "billingstate", "billingcountry", "billingpostalcode", "total") VALUES (-2147483643, 3, '2024-06-15 00:00:00+00:00', 'inv_f977dc', 'inv_db467b', 'inv_8293e0', 'inv_0abfd8', 'inv_a2a7fe', 0.06);

INSERT INTO "invoice" ("invoiceid", "customerid", "invoicedate", "billingaddress", "billingcity", "billingstate", "billingcountry", "billingpostalcode", "total") VALUES (-2147483642, 1, '2024-06-15 00:00:00+00:00', 'inv_f977dc', 'inv_db467b', 'inv_8293e0', 'inv_0abfd8', 'inv_a2a7fe', 0.07);

INSERT INTO "invoice" ("invoiceid", "customerid", "invoicedate", "billingaddress", "billingcity", "billingstate", "billingcountry", "billingpostalcode", "total") VALUES (-2147483641, 1, '2024-06-15 00:00:00+00:00', 'inv_f977dc', 'inv_db467b', 'inv_8293e0', 'inv_0abfd8', 'inv_a2a7fe', 0.08);

INSERT INTO "invoice" ("invoiceid", "customerid", "invoicedate", "billingaddress", "billingcity", "billingstate", "billingcountry", "billingpostalcode", "total") VALUES (-2147483640, 1, NULL, 'inv_f977dc', 'inv_db467b', 'inv_8293e0', 'inv_0abfd8', 'inv_a2a7fe', 0.09);

INSERT INTO "invoice" ("invoiceid", "customerid", "invoicedate", "billingaddress", "billingcity", "billingstate", "billingcountry", "billingpostalcode", "total") VALUES (4, 4, '2021-05-28 17:00:04+00:00', 'inv_f977dc', 'inv_db467b', 'inv_8293e0', 'inv_0abfd8', 'inv_a2a7fe', 0.1);

INSERT INTO "invoice" ("invoiceid", "customerid", "invoicedate", "billingaddress", "billingcity", "billingstate", "billingcountry", "billingpostalcode", "total") VALUES (5, 5, '2022-06-06 02:35:43+00:00', 'inv_f977dc', 'inv_db467b', 'inv_8293e0', 'inv_0abfd8', 'inv_a2a7fe', 0.11);

INSERT INTO "invoice" ("invoiceid", "customerid", "invoicedate", "billingaddress", "billingcity", "billingstate", "billingcountry", "billingpostalcode", "total") VALUES (6, 6, '2023-01-16 20:10:41+00:00', 'inv_f977dc', 'inv_db467b', 'inv_8293e0', 'inv_0abfd8', 'inv_a2a7fe', 0.12);

INSERT INTO "invoice" ("invoiceid", "customerid", "invoicedate", "billingaddress", "billingcity", "billingstate", "billingcountry", "billingpostalcode", "total") VALUES (7, 7, '2020-04-30 03:21:27+00:00', 'inv_f977dc', 'inv_db467b', 'inv_8293e0', 'inv_0abfd8', 'inv_a2a7fe', 0.13);

INSERT INTO "invoice" ("invoiceid", "customerid", "invoicedate", "billingaddress", "billingcity", "billingstate", "billingcountry", "billingpostalcode", "total") VALUES (8, 8, '2022-06-28 11:34:24+00:00', 'inv_f977dc', 'inv_db467b', 'inv_8293e0', 'inv_0abfd8', 'inv_a2a7fe', 0.14);

INSERT INTO "invoice" ("invoiceid", "customerid", "invoicedate", "billingaddress", "billingcity", "billingstate", "billingcountry", "billingpostalcode", "total") VALUES (9, 9, '2024-11-14 12:35:58+00:00', 'inv_f977dc', 'inv_db467b', 'inv_8293e0', 'inv_0abfd8', 'inv_a2a7fe', 0.15);

INSERT INTO "invoice" ("invoiceid", "customerid", "invoicedate", "billingaddress", "billingcity", "billingstate", "billingcountry", "billingpostalcode", "total") VALUES (10, 10, '2025-02-21 23:30:13+00:00', 'inv_f977dc', 'inv_db467b', 'inv_8293e0', 'inv_0abfd8', 'inv_a2a7fe', 0.16);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "invoicedate" FROM (SELECT * FROM "invoice" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "customer" WHERE ("firstname" <> 'Astrid' AND "lastname" <> 'Gruber')) AS RHS WHERE (LHS.customerid = RHS.customerid))) ORDER BY invoicedate, "invoicedate" NULLS LAST;

/*
Gold Result:
(None,)
('2020-04-30 03:21:27+00:00',)
('2021-05-28 17:00:04+00:00',)
('2022-06-06 02:35:43+00:00',)
('2022-06-28 11:34:24+00:00',)
('2023-01-16 20:10:41+00:00',)
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
('2024-11-14 12:35:58+00:00',)
('2025-02-21 23:30:13+00:00',)
*/

-- Prediction Query
SELECT T2.InvoiceDate FROM CUSTOMER AS T1 JOIN INVOICE AS T2 ON T1.CustomerId = T2.CustomerId WHERE T1.FirstName = 'Astrid' AND LastName = 'Gruber';

/*
Prediction Result:
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
(None,)
('2024-06-15 00:00:00+00:00',)
('2024-06-15 00:00:00+00:00',)
*/