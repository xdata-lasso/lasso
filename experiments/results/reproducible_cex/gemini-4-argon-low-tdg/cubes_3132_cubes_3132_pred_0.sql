-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Core scenarios:
-- 1. Artist with NO exhibitions at all (should be returned).
-- 2. Artist with ONLY a 2004 exhibition (should NOT be returned).
-- 3. Artist with BOTH a 2004 exhibition and a non-2004 exhibition (should NOT be returned; kills `WHERE Year != 2004` join mutants).
-- 4. Artist with MULTIPLE non-2004 exhibitions (should be returned ONCE; kills missing DISTINCT in join mutants).
-- 5. Boundary years (2003, 2005) to kill off-by-one/range operator mutants (<, <=, >, >=).
-- 6. Artist with Year_Join = 2004 (kills column confusion mutants checking artist.Year_Join instead of exhibition.Year).
-- 7. Duplicate Artist Names (one valid, one excluded, two valid with same name; kills SELECT DISTINCT name mutants).
-- 8. Unordered insertion of names to test ORDER BY name.
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (1, 'Zack', 'USA', 2000, 40);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (2, 'Alice', 'UK', 2001, 35);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (3, 'Bob', 'Canada', 2002, 50);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (4, 'Charlie', 'France', 2004, 28);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (5, 'David', 'Germany', 1999, 60);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (6, 'Charlie', 'Spain', 2005, 31);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (7, 'Eve', 'Italy', 2003, 45);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (101, 2, 2004, 'Modern', 15.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (102, 3, 2003, 'Classic', 10.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (103, 3, 2004, 'Future', 20.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (104, 4, 2003, 'Abstract', 12.5);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (105, 4, 2005, 'Realism', 18.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (106, 7, 2004, 'Renaissance', 25.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM artist AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM exhibition WHERE (YEAR = 2004)) AS RHS WHERE (LHS.artist_id = RHS.artist_id))) ORDER BY name;

/*
Gold Result:
('Charlie',)
('Charlie',)
('David',)
('Zack',)
*/

-- Prediction Query
SELECT name FROM artist EXCEPT SELECT T2.name FROM exhibition AS T1 JOIN artist AS T2 ON T1.artist_id = T2.artist_id WHERE T1.year = 2004;

/*
Prediction Result:
('Charlie',)
('David',)
('Zack',)
*/