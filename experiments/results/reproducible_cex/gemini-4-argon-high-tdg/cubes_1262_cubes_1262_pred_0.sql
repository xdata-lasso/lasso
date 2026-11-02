-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "book_club" ("book_club_id", "Year", "Author_or_Editor", "Book_Title", "Publisher", "Category", "Result") VALUES (1, 2005, 'Jane Doe', 'The Silent Forest', 'Oak Press', 'Fiction', 'Winner');
INSERT INTO "book_club" ("book_club_id", "Year", "Author_or_Editor", "Book_Title", "Publisher", "Category", "Result") VALUES (2, 1998, 'Zack Taylor', 'Zorro Returns', 'Zenith House', 'Adventure', 'Nominee');
INSERT INTO "book_club" ("book_club_id", "Year", "Author_or_Editor", "Book_Title", "Publisher", "Category", "Result") VALUES (3, 1998, 'Aaron Smith', 'Alpha Dawn', 'Apex Books', 'Sci-Fi', 'Winner');
INSERT INTO "book_club" ("book_club_id", "Year", "Author_or_Editor", "Book_Title", "Publisher", "Category", "Result") VALUES (4, 2012, 'Mary Major', 'Modern Art', 'Beacon Publishing', 'Non-Fiction', 'Shortlisted');
INSERT INTO "movie" ("movie_id", "Title", "Year", "Director", "Budget_million", "Gross_worldwide") VALUES (10, 'Cinema Paradise', 1988, 'Giuseppe Tornatore', 5.0, 12000000);
INSERT INTO "movie" ("movie_id", "Title", "Year", "Director", "Budget_million", "Gross_worldwide") VALUES (20, 'Future World', 2015, 'John Director', 45.5, 150000000);
INSERT INTO "culture_company" ("Company_name", "movie_id", "book_club_id", "Type", "Incorporated_in", "Group_Equity_Shareholding") VALUES ('Culture Corp A', '10', '1', 'Media', 'USA', 50.0);
INSERT INTO "culture_company" ("Company_name", "movie_id", "book_club_id", "Type", "Incorporated_in", "Group_Equity_Shareholding") VALUES ('Culture Corp B', '20', '1', 'Publishing', 'UK', 75.5);
INSERT INTO "culture_company" ("Company_name", "movie_id", "book_club_id", "Type", "Incorporated_in", "Group_Equity_Shareholding") VALUES ('Culture Corp C', '10', '3', 'Entertainment', 'Canada', 25.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT YEAR, book_title, publisher FROM book_club ORDER BY YEAR, book_club.book_club_id NULLS LAST;

/*
Gold Result:
(1998, 'Zorro Returns', 'Zenith House')
(1998, 'Alpha Dawn', 'Apex Books')
(2005, 'The Silent Forest', 'Oak Press')
(2012, 'Modern Art', 'Beacon Publishing')
*/

-- Prediction Query
SELECT YEAR, book_title, publisher FROM book_club ORDER BY YEAR DESC, book_club.book_club_id NULLS LAST;

/*
Prediction Result:
(2012, 'Modern Art', 'Beacon Publishing')
(2005, 'The Silent Forest', 'Oak Press')
(1998, 'Zorro Returns', 'Zenith House')
(1998, 'Alpha Dawn', 'Apex Books')
*/