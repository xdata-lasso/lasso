-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO book_club (book_club_id, year, author_or_editor, book_title, publisher, category, result) VALUES (1, 1, 'default2', 'default1', 'default2', 'default2', 'default1'), (0, 0, NULL, 'default2', NULL, NULL, 'default1'), (2, 1, 'default2', 'default2', 'default2', 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT YEAR, book_title, publisher FROM book_club ORDER BY YEAR, book_club.book_club_id NULLS LAST;

/*
Gold Result:
(0, 'default2', None)
(1, 'default1', 'default2')
(1, 'default2', 'default2')
*/

-- Prediction Query
SELECT YEAR, book_title, publisher FROM book_club ORDER BY YEAR DESC, book_club.book_club_id NULLS LAST;

/*
Prediction Result:
(1, 'default1', 'default2')
(1, 'default2', 'default2')
(0, 'default2', None)
*/