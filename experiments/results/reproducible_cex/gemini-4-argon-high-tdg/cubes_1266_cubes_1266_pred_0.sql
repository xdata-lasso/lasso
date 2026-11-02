-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (1, 2010, 'Jane Doe', 'The Silent Forest', 'Penguin', 'Fiction', 'Nominee');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (2, 2005, 'John Smith', 'History of Time', 'HarperCollins', 'Non-Fiction', 'Winner');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (3, 2015, 'Alice Johnson', 'Deep Ocean', 'Penguin', 'Science', 'Winner');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (4, 2020, 'Bob Brown', 'Modern Art', 'Abrams', 'Art', 'Nominee');
INSERT INTO movie (movie_id, Title, Year, Director, Budget_million, Gross_worldwide) VALUES (1, 'The Silent Forest Movie', 2012, 'Sam Green', 15.5, 50000000);
INSERT INTO culture_company (Company_name, movie_id, book_club_id, Type, Incorporated_in, Group_Equity_Shareholding) VALUES ('Penguin Media Group', '1', '1', 'Publishing', 'UK', 45.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT publisher FROM book_club ORDER BY publisher;

/*
Gold Result:
('Abrams',)
('HarperCollins',)
('Penguin',)
*/

-- Prediction Query
SELECT DISTINCT publisher FROM book_club;

/*
Prediction Result:
('Penguin',)
('HarperCollins',)
('Abrams',)
*/