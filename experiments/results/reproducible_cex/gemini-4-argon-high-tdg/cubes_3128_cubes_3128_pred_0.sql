-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (1, 'Alice Reynolds', 'USA', 1995, 52);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (2, 'Bruno Silva', 'Brazil', 2008, 39);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (3, 'Chiyo Takahashi', 'Japan', 2015, 31);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (1, 3, 2020, 'Sculpture', 50.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (2, 2, 2023, 'Abstract', 30.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (3, 1, 2019, 'Abstract', 10.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (4, 1, 2019, 'Abstract', 10.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (5, 2, 2021, 'Modern', 25.0);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (1, '2020-05-01', 120);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (1, '2020-05-02', 185);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (2, '2023-09-10', 300);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT theme, YEAR FROM exhibition ORDER BY theme, exhibition.exhibition_id NULLS LAST;

/*
Gold Result:
('Abstract', 2023)
('Abstract', 2019)
('Abstract', 2019)
('Modern', 2021)
('Sculpture', 2020)
*/

-- Prediction Query
SELECT theme, YEAR FROM exhibition ORDER BY ticket_price DESC, exhibition.exhibition_id NULLS LAST;

/*
Prediction Result:
('Sculpture', 2020)
('Abstract', 2023)
('Modern', 2021)
('Abstract', 2019)
('Abstract', 2019)
*/