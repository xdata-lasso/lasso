-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (0, 1980, 'Author_0', 'Title_0', 'A_Pub', 'Biography', 'Winner');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (1, 1995, 'Author_1', 'Title_1', 'M_Pub', 'Non-Fiction', 'Nominee');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (2, 2001, 'Author_2', 'Title_2', 'Z_Pub', 'Fiction', 'Winner');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (4, 2005, 'Author_4', 'Title_4', 'Z_Pub', 'Poetry', 'Nominee');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (5, 2010, 'Author_5', 'Title_5', 'M_Pub', 'Fiction', 'Winner');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (6, 2020, 'Author_6', 'Title_6', 'Z_Pub', 'Biography', 'Nominee');
INSERT INTO movie (movie_id, Title, Year, Director, Budget_million, Gross_worldwide) VALUES (10, 'Film_A', 1999, 'Dir_A', 25.5, 120000000);
INSERT INTO culture_company (Company_name, movie_id, book_club_id, Type, Incorporated_in, Group_Equity_Shareholding) VALUES ('Corp_Alpha', '10', '2', 'Publishing', 'USA', 50.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT publisher FROM (SELECT book_club_id, maxn, publisher, book_club_id AS n FROM (SELECT LHS.book_club_id AS book_club_id, LHS.maxn AS maxn, RHS.publisher AS publisher FROM (SELECT book_club_id, MAX(n) AS maxn FROM (SELECT book_club_id, publisher, COUNT(*) AS n FROM book_club GROUP BY book_club_id, publisher) GROUP BY book_club_id) AS LHS INNER JOIN (SELECT book_club_id, publisher, COUNT(*) AS n FROM book_club GROUP BY book_club_id, publisher) AS RHS ON (LHS.book_club_id = RHS.n AND LHS.maxn = RHS.book_club_id))) ORDER BY publisher;

/*
Gold Result:
('M_Pub',)
*/

-- Prediction Query
SELECT publisher FROM book_club GROUP BY publisher ORDER BY COUNT(*) DESC, publisher NULLS LAST LIMIT 1;

/*
Prediction Result:
('Z_Pub',)
*/