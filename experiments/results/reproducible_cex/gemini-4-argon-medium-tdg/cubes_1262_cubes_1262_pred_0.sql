-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "book_club" ("book_club_id", "Year", "Author_or_Editor", "Book_Title", "Publisher", "Category", "Result") VALUES (3, 2005, 'Alice Smith', 'The Great Adventure', 'Penguin', 'Fiction', 'Won');
INSERT INTO "book_club" ("book_club_id", "Year", "Author_or_Editor", "Book_Title", "Publisher", "Category", "Result") VALUES (1, 2010, 'Bob Jones', 'Science Today', 'Oxford', 'Non-Fiction', 'Nominated');
INSERT INTO "book_club" ("book_club_id", "Year", "Author_or_Editor", "Book_Title", "Publisher", "Category", "Result") VALUES (2, 2005, 'Charlie Brown', 'Mystery Night', 'Harper', 'Mystery', 'Won');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT YEAR, book_title, publisher FROM book_club ORDER BY YEAR, book_club.book_club_id NULLS LAST;

/*
Gold Result:
(2005, 'Mystery Night', 'Harper')
(2005, 'The Great Adventure', 'Penguin')
(2010, 'Science Today', 'Oxford')
*/

-- Prediction Query
SELECT YEAR, book_title, publisher FROM book_club ORDER BY YEAR DESC, book_club.book_club_id NULLS LAST;

/*
Prediction Result:
(2010, 'Science Today', 'Oxford')
(2005, 'Mystery Night', 'Harper')
(2005, 'The Great Adventure', 'Penguin')
*/