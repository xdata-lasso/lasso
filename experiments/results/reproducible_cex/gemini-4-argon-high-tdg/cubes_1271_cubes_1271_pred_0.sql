-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (1, 2001, 'A_Author', 'A_Title', 'Zeta Press', 'A_Cat', 'A_Res');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (2, 2002, 'M_Author', 'M_Title', 'Alpha Books', 'M_Cat', 'M_Res');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (10, 2002, 'B_Author', 'B_Title', 'Beta House', 'B_Cat', 'B_Res');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (3, 2003, 'Z_Author', 'Z_Title', 'Alpha Books', 'Z_Cat', 'Z_Res');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (4, 2003, 'C_Author', 'C_Title', 'Gamma Print', 'C_Cat', 'C_Res');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (5, 2003, 'D_Author', 'D_Title', 'Delta Pub', 'D_Cat', 'D_Res');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (6, 2004, 'E_Author', 'E_Title', 'Epsilon Pub', 'E_Cat', 'E_Res');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (7, 2004, 'F_Author', 'F_Title', 'Eta Pub', 'F_Cat', 'F_Res');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (8, 2004, 'G_Author', 'G_Title', 'Theta Pub', 'G_Cat', 'G_Res');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (9, 2004, 'H_Author', 'H_Title', 'Iota Pub', 'H_Cat', 'H_Res');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT publisher FROM (SELECT LHS.year AS YEAR, LHS.n AS n, RHS.author_or_editor AS author_or_editor, RHS.book_title AS book_title, RHS.publisher AS publisher, RHS.category AS category, RHS.result AS RESULT FROM (SELECT YEAR, COUNT(*) AS n FROM book_club GROUP BY YEAR) AS LHS INNER JOIN book_club AS RHS ON (LHS.year = RHS.year AND LHS.n = RHS.book_club_id)) ORDER BY publisher;

/*
Gold Result:
('Alpha Books',)
('Alpha Books',)
('Zeta Press',)
*/

-- Prediction Query
SELECT publisher FROM book_club GROUP BY publisher ORDER BY COUNT(*) DESC, publisher NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alpha Books',)
*/