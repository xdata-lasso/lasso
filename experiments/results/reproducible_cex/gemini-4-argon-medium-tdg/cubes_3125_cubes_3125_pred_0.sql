-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (1, 'Artist A', 'USA', 2000, 45);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (1, 1, 2020, 'Modern Art', 10.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (2, 1, 2021, 'Sculpture', 14.99);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (3, 1, 2022, 'Impressionism', 15.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (4, 1, 2023, 'Renaissance', 15.01);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (5, 1, 2024, 'Pop Art', 20.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (6, 1, 2025, 'Abstract', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT theme, YEAR FROM exhibition WHERE (ticket_price <= 15.0) ORDER BY theme, exhibition.exhibition_id NULLS LAST;

/*
Gold Result:
('Impressionism', 2022)
('Modern Art', 2020)
('Sculpture', 2021)
*/

-- Prediction Query
SELECT theme, YEAR FROM exhibition WHERE ticket_price < 15;

/*
Prediction Result:
('Modern Art', 2020)
('Sculpture', 2021)
*/