-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "book_club" ("book_club_id", "Year", "Author_or_Editor", "Book_Title", "Publisher", "Category", "Result") VALUES (1, 2000, 'Author A', 'Title 1', 'Pub X', 'Fiction', 'Won');
INSERT INTO "book_club" ("book_club_id", "Year", "Author_or_Editor", "Book_Title", "Publisher", "Category", "Result") VALUES (2, 2000, 'Author A', 'Title 1', 'Pub X', 'Fiction', 'Won');
INSERT INTO "book_club" ("book_club_id", "Year", "Author_or_Editor", "Book_Title", "Publisher", "Category", "Result") VALUES (3, 2000, 'Author B', 'Title 2', 'Pub Y', 'Fiction', 'Nominated');
INSERT INTO "book_club" ("book_club_id", "Year", "Author_or_Editor", "Book_Title", "Publisher", "Category", "Result") VALUES (4, 1995, 'Author C', 'Title 3', 'Pub Z', 'Fiction', 'Won');
INSERT INTO "book_club" ("book_club_id", "Year", "Author_or_Editor", "Book_Title", "Publisher", "Category", "Result") VALUES (5, 2000, 'Author D', 'Title 4', 'Pub W', 'Biography', 'Won');
INSERT INTO "book_club" ("book_club_id", "Year", "Author_or_Editor", "Book_Title", "Publisher", "Category", "Result") VALUES (6, 2001, 'Author E', 'Title 5', 'Pub V', 'Biography', 'Nominated');
INSERT INTO "book_club" ("book_club_id", "Year", "Author_or_Editor", "Book_Title", "Publisher", "Category", "Result") VALUES (7, 2001, 'Author F', 'Title 6', 'Pub U', 'Biography', 'Won');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT category, n AS count___ FROM (SELECT category, YEAR, COUNT(*) AS n FROM book_club GROUP BY category, YEAR) ORDER BY category, count___ NULLS LAST;

/*
Gold Result:
('Biography', 1)
('Biography', 2)
('Fiction', 1)
('Fiction', 3)
*/

-- Prediction Query
SELECT category, COUNT(*) FROM book_club GROUP BY category;

/*
Prediction Result:
('Biography', 3)
('Fiction', 4)
*/