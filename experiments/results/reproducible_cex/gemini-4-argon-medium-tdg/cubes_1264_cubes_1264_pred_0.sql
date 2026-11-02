-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (1, 1989, 'Author A', 'Book 1', 'Pub A', 'History', 'Nominee');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (2, 1990, 'Author B', 'Book 2', 'Pub B', 'Fiction', 'Winner');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (3, 1990, 'Author C', 'Book 3', 'Pub C', 'Fiction', 'Nominee');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (4, 1991, 'Author D', 'Book 4', 'Pub D', 'Fiction', 'Winner');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (5, 1988, 'Author E', 'Book 5', 'Pub E', 'Arts', 'Winner');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT category FROM (SELECT category, YEAR, COUNT(DISTINCT YEAR) AS n_distinct FROM (SELECT * FROM book_club WHERE (YEAR <> 1989 OR YEAR < 2)) GROUP BY category, YEAR) ORDER BY category;

/*
Gold Result:
('Arts',)
('Fiction',)
('Fiction',)
*/

-- Prediction Query
SELECT category FROM book_club WHERE YEAR > 1989 GROUP BY category HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Fiction',)
*/