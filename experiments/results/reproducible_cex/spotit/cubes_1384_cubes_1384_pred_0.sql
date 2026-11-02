-- Schema DDL
CREATE TABLE "COUNTRY" (
    "COUNTRY_ID" INT,
    "COUNTRY_NAME" TEXT,
    "CAPITAL" TEXT,
    "OFFICIAL_NATIVE_LANGUAGE" TEXT,
    PRIMARY KEY ("COUNTRY_ID")
);
CREATE TABLE "TEAM" (
    "TEAM_ID" INT,
    "NAME" TEXT,
    PRIMARY KEY ("TEAM_ID")
);
CREATE TABLE "MATCH_SEASON" (
    "SEASON" FLOAT,
    "TEAM" INT,
    "COUNTRY" INT,
    "PLAYER" TEXT,
    "POSITION" TEXT,
    "DRAFT_PICK_NUMBER" INT,
    "DRAFT_CLASS" TEXT,
    "COLLEGE" TEXT,
    PRIMARY KEY ("SEASON"),
    FOREIGN KEY ("TEAM") REFERENCES "TEAM"("TEAM_ID"),
    FOREIGN KEY ("COUNTRY") REFERENCES "COUNTRY"("COUNTRY_ID")
);
CREATE TABLE "PLAYER" (
    "PLAYER_ID" INT,
    "TEAM" INT,
    "PLAYER" TEXT,
    "YEARS_PLAYED" TEXT,
    "TOTAL_WL" TEXT,
    "SINGLES_WL" TEXT,
    "DOUBLES_WL" TEXT,
    PRIMARY KEY ("PLAYER_ID"),
    FOREIGN KEY ("TEAM") REFERENCES "TEAM"("TEAM_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO COUNTRY VALUES (-1, 0, 0, 0);
INSERT INTO COUNTRY VALUES (-2, 0, 0, 0);
INSERT INTO TEAM VALUES (-1, 97);
INSERT INTO TEAM VALUES (0, -1);
INSERT INTO MATCH_SEASON VALUES (2, 0, -2, -1, 94, 0, 95, 96);
INSERT INTO MATCH_SEASON VALUES (10, -1, -1, 98, 99, 0, 100, 101);
INSERT INTO PLAYER VALUES (0, 0, 102, 103, 104, 105, 106);
INSERT INTO PLAYER VALUES (-2, 0, 107, 108, 109, 110, 111);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT season, player, name FROM (SELECT season, player, POSITION, country, team, draft_pick_number, draft_class, college, name, player_other, years_played, total_wl, singles_wl, doubles_wl, team_other, country AS player_id FROM (SELECT LHS.season AS season, LHS.player AS player, LHS.position AS POSITION, LHS.country AS country, LHS.team AS team, LHS.draft_pick_number AS draft_pick_number, LHS.draft_class AS draft_class, LHS.college AS college, RHS.name AS name, RHS.player AS player_other, RHS.years_played AS years_played, RHS.total_wl AS total_wl, RHS.singles_wl AS singles_wl, RHS.doubles_wl AS doubles_wl, RHS.team AS team_other FROM match_season AS LHS INNER JOIN (SELECT LHS.team_id AS team_id, LHS.name AS name, RHS.player_id AS player_id, RHS.player AS player, RHS.years_played AS years_played, RHS.total_wl AS total_wl, RHS.singles_wl AS singles_wl, RHS.doubles_wl AS doubles_wl, RHS.team AS team FROM team AS LHS CROSS JOIN player AS RHS) AS RHS ON (LHS.country = RHS.player_id AND LHS.team = RHS.team_id))) ORDER BY season, player NULLS LAST, name NULLS LAST;

/*
Gold Result:
(2.0, '-1', '-1')
*/

-- Prediction Query
SELECT T1.Season, T1.Player, T2.Name FROM match_season AS T1 JOIN team AS T2 ON T1.Team = T2.Team_id;

/*
Prediction Result:
(2.0, '-1', '-1')
(10.0, '98', '97')
*/