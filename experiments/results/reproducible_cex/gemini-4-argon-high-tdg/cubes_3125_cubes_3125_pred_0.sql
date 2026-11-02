-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (1, 'Alice', 'USA', 2010, 14);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (2, 'Bob', 'UK', 2015, 30);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (3, 'Charlie', 'France', 2018, 45);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (1, 1, 2023, 'Zebra Art', 15.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (2, 2, 2021, 'Modernism', 14.99);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (3, 3, 2019, 'Alpha Wave', 0.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (4, 1, 2020, 'Cubism', 15.01);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (5, 2, 2022, 'Surrealism', 25.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (6, 3, 2017, 'Impressionism', 10.5);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (1, '2023-05-01', 100);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (2, '2021-06-15', 15);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (4, '2020-07-20', 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT theme, YEAR FROM exhibition WHERE (ticket_price <= 15.0) ORDER BY theme, exhibition.exhibition_id NULLS LAST;

/*
Gold Result:
('Alpha Wave', 2019)
('Impressionism', 2017)
('Modernism', 2021)
('Zebra Art', 2023)
*/

-- Prediction Query
SELECT theme, YEAR FROM exhibition WHERE ticket_price < 15;

/*
Prediction Result:
('Modernism', 2021)
('Alpha Wave', 2019)
('Impressionism', 2017)
*/