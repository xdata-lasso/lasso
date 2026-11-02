-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (1, 1990, 'Author One', 'Zeta Chronicles', 'Pub A', 'Fiction', 'Winner');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (2, 1989, 'Author Two', 'Alpha Dawn', 'Pub B', 'Fiction', 'Winner');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (3, 1988, 'Author Three', 'Beta Horizon', 'Pub C', 'Non-Fiction', 'Nominee');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (4, NULL, 'Author Four', 'Gamma Ray', 'Pub D', 'Sci-Fi', 'Winner');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (5, 2005, 'Author Five', 'Alpha Dawn', 'Pub E', 'History', 'Nominee');
INSERT INTO movie (movie_id, Title, Year, Director, Budget_million, Gross_worldwide) VALUES (101, 'Movie A', 1990, 'Dir A', 10.5, 50000000);
INSERT INTO movie (movie_id, Title, Year, Director, Budget_million, Gross_worldwide) VALUES (102, 'Movie B', 1989, 'Dir B', 20.0, 80000000);
INSERT INTO culture_company (Company_name, movie_id, book_club_id, Type, Incorporated_in, Group_Equity_Shareholding) VALUES ('CultCorp 1', '101', '1', 'Publishing', 'USA', 50.0);
INSERT INTO culture_company (Company_name, movie_id, book_club_id, Type, Incorporated_in, Group_Equity_Shareholding) VALUES ('CultCorp 2', '102', '2', 'Media', 'UK', 75.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT book_title, author_or_editor FROM book_club WHERE (YEAR <> 1989) ORDER BY book_title, book_club.book_club_id NULLS LAST;

/*
Gold Result:
('Alpha Dawn', 'Author Five')
('Beta Horizon', 'Author Three')
('Zeta Chronicles', 'Author One')
*/

-- Prediction Query
SELECT book_title, author_or_editor FROM book_club WHERE YEAR > 1989;

/*
Prediction Result:
('Zeta Chronicles', 'Author One')
('Alpha Dawn', 'Author Five')
*/