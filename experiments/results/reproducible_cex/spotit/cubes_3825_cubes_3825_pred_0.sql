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
INSERT INTO BOOK_CLUB VALUES (0, 0, 18, 19, -1, 20, 21);
INSERT INTO BOOK_CLUB VALUES (1, 0, 7, 8, 0, 9, 10);
INSERT INTO MOVIE VALUES (-1, 0, 0, 0, 0, 0);
INSERT INTO MOVIE VALUES (0, 0, 0, 0, 0, 0);
INSERT INTO CULTURE_COMPANY VALUES (4, -1, 1, 0, 0, 0);
INSERT INTO CULTURE_COMPANY VALUES (5, 0, 1, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT publisher FROM (SELECT book_club_id, maxn, publisher, book_club_id AS n FROM (SELECT LHS.book_club_id AS book_club_id, LHS.maxn AS maxn, RHS.publisher AS publisher FROM (SELECT book_club_id, MAX(n) AS maxn FROM (SELECT book_club_id, publisher, COUNT(*) AS n FROM book_club GROUP BY book_club_id, publisher) GROUP BY book_club_id) AS LHS INNER JOIN (SELECT book_club_id, publisher, COUNT(*) AS n FROM book_club GROUP BY book_club_id, publisher) AS RHS ON (LHS.book_club_id = RHS.n AND LHS.maxn = RHS.book_club_id))) ORDER BY publisher;

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