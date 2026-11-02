-- Schema DDL
CREATE TABLE "BOOK_CLUB" (
    "BOOK_CLUB_ID" INT,
    "YEAR" INT,
    "AUTHOR_OR_EDITOR" TEXT,
    "BOOK_TITLE" TEXT,
    "PUBLISHER" TEXT,
    "CATEGORY" TEXT,
    "RESULT" TEXT,
    PRIMARY KEY ("BOOK_CLUB_ID")
);
CREATE TABLE "MOVIE" (
    "MOVIE_ID" INT,
    "TITLE" TEXT,
    "YEAR" INT,
    "DIRECTOR" TEXT,
    "BUDGET_MILLION" FLOAT,
    "GROSS_WORLDWIDE" INT,
    PRIMARY KEY ("MOVIE_ID")
);
CREATE TABLE "CULTURE_COMPANY" (
    "COMPANY_NAME" TEXT,
    "MOVIE_ID" TEXT,
    "BOOK_CLUB_ID" TEXT,
    "TYPE" TEXT,
    "INCORPORATED_IN" TEXT,
    "GROUP_EQUITY_SHAREHOLDING" FLOAT,
    PRIMARY KEY ("COMPANY_NAME"),
    FOREIGN KEY ("MOVIE_ID") REFERENCES "MOVIE"("MOVIE_ID"),
    FOREIGN KEY ("BOOK_CLUB_ID") REFERENCES "BOOK_CLUB"("BOOK_CLUB_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO BOOK_CLUB VALUES (0, 0, 14, 15, -1, 16, 17);
INSERT INTO BOOK_CLUB VALUES (2, 0, 8, 9, 0, 10, 11);
INSERT INTO MOVIE VALUES (0, 0, 0, 0, 0, 0);
INSERT INTO MOVIE VALUES (1, 0, 0, 0, 0, 0);
INSERT INTO CULTURE_COMPANY VALUES (5, 1, 2, 0, 0, 0);
INSERT INTO CULTURE_COMPANY VALUES (6, 0, 2, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT publisher FROM (SELECT LHS.year AS YEAR, LHS.n AS n, RHS.author_or_editor AS author_or_editor, RHS.book_title AS book_title, RHS.publisher AS publisher, RHS.category AS category, RHS.result AS RESULT FROM (SELECT YEAR, COUNT(*) AS n FROM book_club GROUP BY YEAR) AS LHS INNER JOIN book_club AS RHS ON (LHS.year = RHS.year AND LHS.n = RHS.book_club_id)) ORDER BY publisher;

/*
Gold Result:
('0',)
*/

-- Prediction Query
SELECT publisher FROM book_club GROUP BY publisher ORDER BY COUNT(*) DESC, publisher NULLS LAST LIMIT 1;

/*
Prediction Result:
('-1',)
*/