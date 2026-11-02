-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic inequality boundary conditions (1988, 1989, 1990) and ordering by Book_Title
INSERT INTO "book_club" ("book_club_id", "Year", "Author_or_Editor", "Book_Title", "Publisher", "Category", "Result") VALUES (1, 1988, 'Author Z', 'Title B', 'Pub 1', 'Cat 1', 'Won');
INSERT INTO "book_club" ("book_club_id", "Year", "Author_or_Editor", "Book_Title", "Publisher", "Category", "Result") VALUES (2, 1989, 'Author Y', 'Title A', 'Pub 2', 'Cat 2', 'Nominated');
INSERT INTO "book_club" ("book_club_id", "Year", "Author_or_Editor", "Book_Title", "Publisher", "Category", "Result") VALUES (3, 1990, 'Author X', 'Title A', 'Pub 3', 'Cat 3', 'Won');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT book_title, author_or_editor FROM book_club WHERE (YEAR <> 1989) ORDER BY book_title, book_club.book_club_id NULLS LAST;

/*
Gold Result:
('Title A', 'Author X')
('Title B', 'Author Z')
*/

-- Prediction Query
SELECT book_title, author_or_editor FROM book_club WHERE YEAR > 1989;

/*
Prediction Result:
('Title A', 'Author X')
*/