-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (2, 2020, 'Author A', 'Title A', 'Publisher A', 'Cat A', 'Won');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT publisher FROM (SELECT book_club_id, maxn, publisher, book_club_id AS n FROM (SELECT LHS.book_club_id AS book_club_id, LHS.maxn AS maxn, RHS.publisher AS publisher FROM (SELECT book_club_id, MAX(n) AS maxn FROM (SELECT book_club_id, publisher, COUNT(*) AS n FROM book_club GROUP BY book_club_id, publisher) GROUP BY book_club_id) AS LHS INNER JOIN (SELECT book_club_id, publisher, COUNT(*) AS n FROM book_club GROUP BY book_club_id, publisher) AS RHS ON (LHS.book_club_id = RHS.n AND LHS.maxn = RHS.book_club_id))) ORDER BY publisher;

/*
Gold Result:
*/

-- Prediction Query
SELECT publisher FROM book_club GROUP BY publisher ORDER BY COUNT(*) DESC, publisher NULLS LAST LIMIT 1;

/*
Prediction Result:
('Publisher A',)
*/