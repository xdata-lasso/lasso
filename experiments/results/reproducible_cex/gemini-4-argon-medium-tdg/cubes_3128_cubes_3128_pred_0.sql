-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (1, 'Picasso', 'Spain', 1900, 91);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (2, 'Monet', 'France', 1860, 86);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (10, 1, 2020, 'Modernism', 25.5);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (20, 1, 2015, 'Modernism', 15.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (5, 2, 2022, 'Abstract', 30.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (15, 2, 2018, 'Surrealism', 20.0);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (10, '2020-05-01', 100);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (10, '2020-05-02', 150);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT theme, YEAR FROM exhibition ORDER BY theme, exhibition.exhibition_id NULLS LAST;

/*
Gold Result:
('Abstract', 2022)
('Modernism', 2020)
('Modernism', 2015)
('Surrealism', 2018)
*/

-- Prediction Query
SELECT theme, YEAR FROM exhibition ORDER BY ticket_price DESC, exhibition.exhibition_id NULLS LAST;

/*
Prediction Result:
('Abstract', 2022)
('Modernism', 2020)
('Surrealism', 2018)
('Modernism', 2015)
*/