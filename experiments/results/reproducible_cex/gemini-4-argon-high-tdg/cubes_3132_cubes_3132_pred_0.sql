-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (1, 'John', 'USA', 1998, 55);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (2, 'John', 'Canada', 2005, 33);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (3, 'Mary', 'UK', 2001, 41);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (4, 'Mary', 'Australia', 2003, 37);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (1, 2, 2005, 'Nature', 14.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (2, 4, 2004, 'Portrait', 19.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM artist AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM exhibition WHERE (YEAR = 2004)) AS RHS WHERE (LHS.artist_id = RHS.artist_id))) ORDER BY name;

/*
Gold Result:
('John',)
('John',)
('Mary',)
*/

-- Prediction Query
SELECT name FROM artist EXCEPT SELECT T2.name FROM exhibition AS T1 JOIN artist AS T2 ON T1.artist_id = T2.artist_id WHERE T1.year = 2004;

/*
Prediction Result:
('John',)
*/