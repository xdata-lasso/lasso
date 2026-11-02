-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (1, 1988, 'Author A', 'Book A', 'Pub_1988', 'Fiction', 'Won');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (2, 1989, 'Author B', 'Book B', 'Pub_1989', 'Fiction', 'Nominee');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (3, 1990, 'Author C', 'Book C', 'Pub_Z', 'Non-Fiction', 'Won');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (4, 1990, 'Author D', 'Book D', 'Pub_A', 'Sci-Fi', 'Won');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (5, 1990, 'Author E', 'Book E', 'Pub_A', 'Mystery', 'Nominee');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (6, 1991, 'Author F', 'Book F', 'Pub_1991', 'Biography', 'Won');
INSERT INTO book_club (book_club_id, Year, Author_or_Editor, Book_Title, Publisher, Category, Result) VALUES (7, NULL, 'Author G', 'Book G', 'Pub_NullYear', 'History', 'Nominee');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT publisher FROM book_club WHERE (YEAR <> 1989 AND YEAR = 1990) ORDER BY publisher, book_club.book_club_id NULLS LAST;

/*
Gold Result:
('Pub_A',)
('Pub_A',)
('Pub_Z',)
*/

-- Prediction Query
SELECT publisher FROM book_club WHERE YEAR = 1989 INTERSECT SELECT publisher FROM book_club WHERE YEAR = 1990;

/*
Prediction Result:
*/