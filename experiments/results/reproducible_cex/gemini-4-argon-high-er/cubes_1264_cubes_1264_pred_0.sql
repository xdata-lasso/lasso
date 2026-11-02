-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (1, 1990, 'Author A', 'Title A', 'Pub A', 'Fiction', 'Won');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT category FROM (SELECT category, YEAR, COUNT(DISTINCT YEAR) AS n_distinct FROM (SELECT * FROM book_club WHERE (YEAR <> 1989 OR YEAR < 2)) GROUP BY category, YEAR) ORDER BY category;

/*
Gold Result:
('Fiction',)
*/

-- Prediction Query
SELECT category FROM book_club WHERE YEAR > 1989 GROUP BY category HAVING COUNT(*) >= 2;

/*
Prediction Result:
*/