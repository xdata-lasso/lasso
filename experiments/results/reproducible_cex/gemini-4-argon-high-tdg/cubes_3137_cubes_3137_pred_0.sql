-- Schema DDL
CREATE TABLE "artist" ("Artist_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Year_Join" INTEGER, "Age" INTEGER);

CREATE TABLE "exhibition" ("Exhibition_ID" INTEGER PRIMARY KEY, "Artist_ID" INTEGER, "Year" INTEGER, "Theme" TEXT, "Ticket_Price" REAL, FOREIGN KEY ("Artist_ID") REFERENCES "artist" ("Artist_ID"));

CREATE TABLE "exhibition_record" ("Exhibition_ID" INTEGER, "Date" TEXT, "Attendance" INTEGER, PRIMARY KEY ("Exhibition_ID", "Date"), FOREIGN KEY ("Exhibition_ID") REFERENCES "exhibition" ("Exhibition_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (1, 'Charlie', 'USA', 2010, 50);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (2, 'Alice', 'UK', 2012, 25);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (3, 'Alice', 'Canada', 2015, 40);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (4, 'Bob', 'France', 2018, 30);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (5, 'Bob', 'Germany', 2019, 30);
INSERT INTO artist (Artist_ID, Name, Country, Year_Join, Age) VALUES (6, 'Diana', 'Italy', 2020, 28);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (101, 1, 2021, 'Modern', 15.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (102, 2, 2020, 'Abstract', 20.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (103, 2, 2021, 'Portrait', 25.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (104, 2, 2022, 'Nature', 30.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (105, 3, 2021, 'Classic', 10.0);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (106, 4, 2022, 'Realism', 12.5);
INSERT INTO exhibition (Exhibition_ID, Artist_ID, Year, Theme, Ticket_Price) VALUES (107, 5, 2023, 'Surrealism', 18.0);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (101, '2021-05-01', 120);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (101, '2021-05-02', 150);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (101, '2021-05-03', 200);
INSERT INTO exhibition_record (Exhibition_ID, Date, Attendance) VALUES (105, '2021-06-10', 80);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT age, name, COUNT(*) AS n FROM (SELECT LHS.artist_id AS artist_id, LHS.name AS name, LHS.country AS country, LHS.year_join AS year_join, LHS.age AS age, RHS.exhibition_id AS exhibition_id, RHS.year AS YEAR, RHS.theme AS theme, RHS.ticket_price AS ticket_price FROM artist AS LHS INNER JOIN exhibition AS RHS ON (LHS.artist_id = RHS.artist_id)) GROUP BY age, name) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Alice', 1)
('Alice', 3)
('Bob', 2)
('Charlie', 1)
*/

-- Prediction Query
SELECT T2.name, COUNT(*) FROM exhibition AS T1 JOIN artist AS T2 ON T1.artist_id = T2.artist_id GROUP BY T1.artist_id;

/*
Prediction Result:
('Charlie', 1)
('Alice', 3)
('Alice', 1)
('Bob', 1)
('Bob', 1)
*/