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
-- Inserting into table: track --
INSERT INTO "track" ("trackid", "mediatypeid", "genreid", "albumid", "name", "composer", "milliseconds", "bytes", "unitprice") VALUES (-2147483648, -2147483648, 1, -2147483648, 'tra_a32572', 'tra_062330', -55602865, -59984348, 0.01);

INSERT INTO "track" ("trackid", "mediatypeid", "genreid", "albumid", "name", "composer", "milliseconds", "bytes", "unitprice") VALUES (-2147483647, -2147483648, 2, -2147483648, 'tra_a32572', 'tra_062330', -1022641847, -1726781632, 0.02);

INSERT INTO "track" ("trackid", "mediatypeid", "genreid", "albumid", "name", "composer", "milliseconds", "bytes", "unitprice") VALUES (-2147483646, -2147483648, 2, -2147483648, 'tra_a32572', 'tra_062330', -1980249628, -734455130, 0.03);

INSERT INTO "track" ("trackid", "mediatypeid", "genreid", "albumid", "name", "composer", "milliseconds", "bytes", "unitprice") VALUES (-2147483645, -2147483648, 2, -2147483648, 'tra_a32572', 'tra_062330', 1160656988, -992890117, 0.04);

INSERT INTO "track" ("trackid", "mediatypeid", "genreid", "albumid", "name", "composer", "milliseconds", "bytes", "unitprice") VALUES (-2147483644, -2147483648, 2, -2147483648, 'tra_a32572', 'tra_062330', 1219478689, -1670923962, 0.05);

INSERT INTO "track" ("trackid", "mediatypeid", "genreid", "albumid", "name", "composer", "milliseconds", "bytes", "unitprice") VALUES (2, -2147483648, 1, -2147483648, 'tra_a32572', 'tra_062330', 1908028688, 2122220075, 0.06);

INSERT INTO "track" ("trackid", "mediatypeid", "genreid", "albumid", "name", "composer", "milliseconds", "bytes", "unitprice") VALUES (3, -2147483648, 1, -2147483648, 'tra_a32572', 'tra_062330', -1659388584, 1526238907, 0.07);

INSERT INTO "track" ("trackid", "mediatypeid", "genreid", "albumid", "name", "composer", "milliseconds", "bytes", "unitprice") VALUES (-2147483641, -2147483648, 1, -2147483648, 'tra_a32572', 'tra_062330', -1576219117, -1823627488, 0.08);

INSERT INTO "track" ("trackid", "mediatypeid", "genreid", "albumid", "name", "composer", "milliseconds", "bytes", "unitprice") VALUES (-2147483640, -2147483648, 1, -2147483648, 'tra_a32572', 'tra_062330', 44952191, 1151980946, 0.09);

INSERT INTO "track" ("trackid", "mediatypeid", "genreid", "albumid", "name", "composer", "milliseconds", "bytes", "unitprice") VALUES (4, -2147483648, 4, -2147483648, 'tra_a32572', 'tra_062330', -59984348, -664303813, 0.1);

INSERT INTO "track" ("trackid", "mediatypeid", "genreid", "albumid", "name", "composer", "milliseconds", "bytes", "unitprice") VALUES (5, -2147483648, 5, -2147483648, 'tra_a32572', 'tra_062330', -59984348, -664303813, 0.11);

INSERT INTO "track" ("trackid", "mediatypeid", "genreid", "albumid", "name", "composer", "milliseconds", "bytes", "unitprice") VALUES (6, -2147483648, 6, -2147483648, 'tra_a32572', 'tra_062330', -1726781632, 247012447, 0.12);

INSERT INTO "track" ("trackid", "mediatypeid", "genreid", "albumid", "name", "composer", "milliseconds", "bytes", "unitprice") VALUES (7, -2147483648, 7, -2147483648, 'tra_a32572', 'tra_062330', -734455130, 1744686505, 0.13);

INSERT INTO "track" ("trackid", "mediatypeid", "genreid", "albumid", "name", "composer", "milliseconds", "bytes", "unitprice") VALUES (8, -2147483648, 8, -2147483648, 'tra_a32572', 'tra_062330', -992890117, 1914020640, 0.14);

INSERT INTO "track" ("trackid", "mediatypeid", "genreid", "albumid", "name", "composer", "milliseconds", "bytes", "unitprice") VALUES (9, -2147483648, 9, -2147483648, 'tra_a32572', 'tra_062330', 1115440883, 1644814318, 0.15);

INSERT INTO "track" ("trackid", "mediatypeid", "genreid", "albumid", "name", "composer", "milliseconds", "bytes", "unitprice") VALUES (10, -2147483648, 10, -2147483648, 'tra_a32572', 'tra_062330', 700293388, 906324270, 0.16);

-- Inserting into table: album --
INSERT INTO "album" ("albumid", "artistid", "title") VALUES (-2147483648, -2147483648, 'alb_1a7f80');

-- Inserting into table: artist --
INSERT INTO "artist" ("artistid", "name") VALUES (-2147483648, 'art_c4cda2');

-- Inserting into table: genre --
INSERT INTO "genre" ("genreid", "name") VALUES (1, 'Rock');

INSERT INTO "genre" ("genreid", "name") VALUES (3, 'Rock');

INSERT INTO "genre" ("genreid", "name") VALUES (2, 'gen_20e4c7');

INSERT INTO "genre" ("genreid", "name") VALUES (4, NULL);

INSERT INTO "genre" ("genreid", "name") VALUES (5, 'Rock');

INSERT INTO "genre" ("genreid", "name") VALUES (6, 'Rock');

INSERT INTO "genre" ("genreid", "name") VALUES (7, 'Rock');

INSERT INTO "genre" ("genreid", "name") VALUES (8, 'Rock');

INSERT INTO "genre" ("genreid", "name") VALUES (9, 'Rock');

INSERT INTO "genre" ("genreid", "name") VALUES (10, 'Rock');

-- Inserting into table: mediatype --
INSERT INTO "mediatype" ("mediatypeid", "name") VALUES (-2147483648, 'med_cd66d1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "genreid", COUNT(*) AS "n" FROM (SELECT "LHS"."trackid" AS "trackid", "LHS"."name" AS "name", "LHS"."albumid" AS "albumid", "LHS"."mediatypeid" AS "mediatypeid", "LHS"."genreid" AS "genreid", "LHS"."composer" AS "composer", "LHS"."milliseconds" AS "milliseconds", "LHS"."bytes" AS "bytes", "LHS"."unitprice" AS "unitprice", "RHS"."name" AS "name_other" FROM "track" AS "LHS" INNER JOIN (SELECT * FROM "genre" WHERE ("name" = 'Rock')) AS RHS ON (LHS.genreid = RHS.genreid)) GROUP BY genreid) ORDER BY count___;

/*
Gold Result:
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(5,)
*/

-- Prediction Query
SELECT COUNT(*) FROM GENRE AS T1 JOIN TRACK AS T2 ON T1.GenreId = T2.GenreId WHERE T1.Name = 'Rock';

/*
Prediction Result:
(11,)
*/