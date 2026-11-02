-- Schema DDL
CREATE TABLE "book_club" ("book_club_id" INTEGER PRIMARY KEY, "Year" INTEGER, "Author_or_Editor" TEXT, "Book_Title" TEXT, "Publisher" TEXT, "Category" TEXT, "Result" TEXT);

CREATE TABLE "movie" ("movie_id" INTEGER PRIMARY KEY, "Title" TEXT, "Year" INTEGER, "Director" TEXT, "Budget_million" REAL, "Gross_worldwide" INTEGER);

CREATE TABLE "culture_company" ("Company_name" TEXT PRIMARY KEY, "movie_id" TEXT, "book_club_id" TEXT, "Type" TEXT, "Incorporated_in" TEXT, "Group_Equity_Shareholding" REAL, FOREIGN KEY ("movie_id") REFERENCES "movie" ("movie_id"), FOREIGN KEY ("book_club_id") REFERENCES "book_club" ("book_club_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO movie (movie_id, title, year, director, budget_million, gross_worldwide) VALUES (1, 'default2', 1, NULL, 1.0, 0), (0, NULL, 1, NULL, NULL, 1), (2, 'default1', NULL, 'default1', 0.0, 1), (3, 'default2', 1, 'default2', 0.0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title, YEAR, director FROM movie ORDER BY title, movie.movie_id NULLS LAST;

/*
Gold Result:
(None, 1, None)
('default1', None, 'default1')
('default2', 1, None)
('default2', 1, 'default2')
*/

-- Prediction Query
SELECT title, YEAR, director FROM movie ORDER BY budget_million, movie.movie_id NULLS LAST;

/*
Prediction Result:
(None, 1, None)
('default1', None, 'default1')
('default2', 1, 'default2')
('default2', 1, None)
*/