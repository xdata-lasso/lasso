-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (10, 1965, 'Frank Herbert', 'Dune', 'Chilton Books', 'Sci-Fi', 'Won');
INSERT INTO movie (movie_id, Title, Year, Director, Budget_million, Gross_worldwide) VALUES (1, 'Dune', 2021, 'Denis Villeneuve', 165.0, 402027830);
INSERT INTO movie (movie_id, Title, Year, Director, Budget_million, Gross_worldwide) VALUES (2, 'Dune', 1984, 'David Lynch', 40.0, 30925690);
INSERT INTO movie (movie_id, Title, Year, Director, Budget_million, Gross_worldwide) VALUES (3, 'Avatar', 2009, 'James Cameron', 237.0, 2923706026);
INSERT INTO culture_company (Company_name, movie_id, book_club_id, Type, Incorporated_in, Group_Equity_Shareholding) VALUES ('Spice Media', '1', '10', 'Media', 'UK', 75.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, YEAR, director FROM movie ORDER BY title, movie.movie_id NULLS LAST;

/*
Gold Result:
('Avatar', 2009, 'James Cameron')
('Dune', 2021, 'Denis Villeneuve')
('Dune', 1984, 'David Lynch')
*/

-- Prediction Query
SELECT title, YEAR, director FROM movie ORDER BY budget_million, movie.movie_id NULLS LAST;

/*
Prediction Result:
('Dune', 1984, 'David Lynch')
('Dune', 2021, 'Denis Villeneuve')
('Avatar', 2009, 'James Cameron')
*/