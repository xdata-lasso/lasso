-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (1, 1999, 'Jane Doe', 'Alpha Book', 'Zeta Press', 'Fiction', 'Nominated');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (2, 2005, 'John Smith', 'Beta Book', 'Alpha Books', 'Non-Fiction', 'Winner');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (3, 2010, 'Alice Brown', 'Gamma Book', 'Zeta Press', 'History', 'Shortlisted');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (4, 1995, 'Bob White', 'Delta Book', 'Beta House', 'Biography', 'Winner');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (5, 2020, 'Charlie Green', 'Epsilon Book', 'Alpha Books', 'Poetry', 'Nominated');
INSERT INTO movie (movie_id, Title, Year, Director, Budget_million, Gross_worldwide) VALUES (101, 'The Movie', 2010, 'Some Director', 50.0, 150000000);
INSERT INTO culture_company (Company_name, movie_id, book_club_id, Type, Incorporated_in, Group_Equity_Shareholding) VALUES ('Media Corp', '101', '2', 'Corporate', 'USA', 50.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT publisher FROM book_club ORDER BY publisher;

/*
Gold Result:
('Alpha Books',)
('Beta House',)
('Zeta Press',)
*/

-- Prediction Query
SELECT DISTINCT publisher FROM book_club;

/*
Prediction Result:
('Zeta Press',)
('Alpha Books',)
('Beta House',)
*/