-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (1, 2010, 'Alice Munro', 'Dear Life', 'McClelland', 'Fiction', 'Nominee');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (2, 2012, 'Hilary Mantel', 'Bring Up the Bodies', 'Fourth Estate', 'Historical', 'Winner');
INSERT INTO movie (movie_id, Title, Year, Director, Budget_million, Gross_worldwide) VALUES (1, 'Inception', 2010, 'Zack', 160.0, 5000);
INSERT INTO movie (movie_id, Title, Year, Director, Budget_million, Gross_worldwide) VALUES (2, 'Inception', 2010, NULL, 160.0, 5000);
INSERT INTO movie (movie_id, Title, Year, Director, Budget_million, Gross_worldwide) VALUES (3, 'Inception', 2010, 'Aaron', 160.0, 5000);
INSERT INTO movie (movie_id, Title, Year, Director, Budget_million, Gross_worldwide) VALUES (4, 'Avatar', 2009, 'James', 237.0, 5000);
INSERT INTO movie (movie_id, Title, Year, Director, Budget_million, Gross_worldwide) VALUES (5, 'Matrix', 1999, 'Lana', 63.0, 3000);
INSERT INTO movie (movie_id, Title, Year, Director, Budget_million, Gross_worldwide) VALUES (6, 'Dune', 2021, 'Denis', 165.0, 2000);
INSERT INTO movie (movie_id, Title, Year, Director, Budget_million, Gross_worldwide) VALUES (7, 'Bambi', 1942, 'David', 1.7, 1000);
INSERT INTO movie (movie_id, Title, Year, Director, Budget_million, Gross_worldwide) VALUES (8, 'Alien', 1979, 'Ridley', 11.0, NULL);
INSERT INTO culture_company (Company_name, movie_id, book_club_id, Type, Incorporated_in, Group_Equity_Shareholding) VALUES ('WarnerMedia', 1, 1, 'Corporate', 'USA', 50.0);
INSERT INTO culture_company (Company_name, movie_id, book_club_id, Type, Incorporated_in, Group_Equity_Shareholding) VALUES ('Syncopy', 1, 2, 'Subsidiary', 'UK', 25.0);
INSERT INTO culture_company (Company_name, movie_id, book_club_id, Type, Incorporated_in, Group_Equity_Shareholding) VALUES ('Lightstorm', 6, 1, 'Joint Venture', 'USA', 75.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, director FROM (SELECT movie_id, title, YEAR, director, budget_million, gross_worldwide, MAX(gross_worldwide) OVER () AS maxgross_worldwide FROM movie) WHERE (maxgross_worldwide <= 2000 OR maxgross_worldwide = gross_worldwide) ORDER BY title, director NULLS LAST;

/*
Gold Result:
('Avatar', 'James')
('Inception', 'Aaron')
('Inception', 'Zack')
('Inception', None)
*/

-- Prediction Query
SELECT title, director FROM movie WHERE YEAR <= 2000 ORDER BY gross_worldwide DESC, movie.movie_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Matrix', 'Lana')
*/