-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (1, 2000, 'Auth1', 'Title1', 'PubB', 'Cat1', 'Res1');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (2, 2000, 'Auth2', 'Title2', 'PubC', 'Cat2', 'Res2');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (3, 2001, 'Auth3', 'Title3', 'PubA', 'Cat3', 'Res3');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (4, 2001, 'Auth4', 'Title4', 'PubD', 'Cat4', 'Res4');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (5, 2001, 'Auth5', 'Title5', 'PubE', 'Cat5', 'Res5');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (6, 2002, 'Auth6', 'Title6', 'PubF', 'Cat6', 'Res6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT publisher FROM (SELECT LHS.year AS YEAR, LHS.n AS n, RHS.author_or_editor AS author_or_editor, RHS.book_title AS book_title, RHS.publisher AS publisher, RHS.category AS category, RHS.result AS RESULT FROM (SELECT YEAR, COUNT(*) AS n FROM book_club GROUP BY YEAR) AS LHS INNER JOIN book_club AS RHS ON (LHS.year = RHS.year AND LHS.n = RHS.book_club_id)) ORDER BY publisher;

/*
Gold Result:
('PubA',)
('PubC',)
*/

-- Prediction Query
SELECT publisher FROM book_club GROUP BY publisher ORDER BY COUNT(*) DESC, publisher NULLS LAST LIMIT 1;

/*
Prediction Result:
('PubA',)
*/