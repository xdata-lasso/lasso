-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO book_club (book_club_id, year, author_or_editor, book_title, publisher, category, result) VALUES (1991, 1991, 'default2', 'default2', 'default1', 'default1', 'default1'), (1988, 1990, 'default2', NULL, 'default2', 'default2', NULL), (1989, 1989, NULL, 'default1', NULL, 'default2', NULL), (1990, 1990, 'default1', NULL, NULL, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT publisher FROM book_club WHERE (YEAR <> 1989 AND YEAR = 1990) ORDER BY publisher, book_club.book_club_id NULLS LAST;

/*
Gold Result:
(None,)
('default2',)
*/

-- Prediction Query
SELECT publisher FROM book_club WHERE YEAR = 1989 INTERSECT SELECT publisher FROM book_club WHERE YEAR = 1990;

/*
Prediction Result:
(None,)
*/