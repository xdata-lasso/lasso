-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (1, 'Zack', 'France', 2005, 35);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (2, 'Alice', 'Mexico', 1980, 18);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (3, 'Bob', 'Germany', 2018, 55);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (4, 'Yara', 'Argentina', 2010, 50);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (5, 'Charlie', 'France', 1995, 25);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (6, 'Xena', 'Germany', 2000, 40);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (7, 'Victor', 'France', 2015, 60);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (8, 'David', 'Argentina', 1990, 29);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (9, 'Zoe', 'Spain', 2024, 85);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (101, 1, 2012, 'Modernism', 25.50);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (102, 3, 2020, 'Abstract', 15.00);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (103, 4, 2015, 'Surrealism', 30.00);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (104, 5, 2001, 'Portraits', 10.00);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (105, 9, 2024, 'Avant-Garde', 50.00);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (101, '2012-05-01', 120);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (101, '2012-05-02', 180);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (102, '2020-08-15', 95);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (105, '2024-01-10', 450);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT country FROM artist ORDER BY country;

/*
Gold Result:
('Argentina',)
('France',)
('Germany',)
('Mexico',)
('Spain',)
*/

-- Prediction Query
SELECT DISTINCT country FROM artist;

/*
Prediction Result:
('France',)
('Mexico',)
('Germany',)
('Argentina',)
('Spain',)
*/