-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (1, 1990, 'Alice Munro', 'Selected Stories', 'Penguin', 'Fiction', 'Winner');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (2, 1990, 'Bob Smith', 'Modern Tales', 'Harper', 'Fiction', 'Nominee');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (3, 1995, 'Carol Danvers', 'Future Worlds', 'Tor', 'Fiction', 'Winner');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (4, 1989, 'David Yates', 'Past Lives', 'Vintage', 'Biography', 'Winner');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (5, 1988, 'Eve Adams', 'Canvas Life', 'Thames', 'Art', 'Shortlisted');
INSERT INTO movie (movie_id, Title, Year, Director, Budget_million, Gross_worldwide) VALUES (10, 'The Adaptation', 1991, 'John Doe', 15.5, 50000000);
INSERT INTO culture_company (Company_name, movie_id, book_club_id, Type, Incorporated_in, Group_Equity_Shareholding) VALUES ('MediaCorp', '10', '1', 'Publishing', 'USA', 50.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT category FROM (SELECT category, YEAR, COUNT(DISTINCT YEAR) AS n_distinct FROM (SELECT * FROM book_club WHERE (YEAR <> 1989 OR YEAR < 2)) GROUP BY category, YEAR) ORDER BY category;

/*
Gold Result:
('Art',)
('Fiction',)
('Fiction',)
*/

-- Prediction Query
SELECT category FROM book_club WHERE YEAR > 1989 GROUP BY category HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Fiction',)
*/