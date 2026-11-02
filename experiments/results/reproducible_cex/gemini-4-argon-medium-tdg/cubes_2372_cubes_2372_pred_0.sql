-- Schema DDL
CREATE TABLE "all_star" ("player_id" TEXT, "year" INTEGER, "game_num" INTEGER, "game_id" TEXT, "team_id" TEXT, "league_id" TEXT, "gp" REAL, "starting_pos" REAL, FOREIGN KEY ("player_id") REFERENCES "player" ("player_id"));

CREATE TABLE "appearances" ("player_id" TEXT, "team_id" TEXT, "year" INTEGER, "league_id" TEXT, "g_all" REAL, "gs" REAL, "g_batting" INTEGER, "g_defense" REAL, "g_p" INTEGER, "g_c" INTEGER, "g_1b" INTEGER, "g_2b" INTEGER, "g_3b" INTEGER, "g_ss" INTEGER, "g_lf" INTEGER, "g_cf" INTEGER, "g_rf" INTEGER, "g_of" INTEGER, "g_dh" REAL, "g_ph" REAL, "g_pr" REAL, FOREIGN KEY ("player_id") REFERENCES "player" ("player_id"), FOREIGN KEY ("team_id") REFERENCES "team" ("team_id"));

CREATE TABLE "manager_award" ("player_id" TEXT, "award_id" TEXT, "year" INTEGER, "league_id" TEXT, "tie" TEXT, "notes" REAL, FOREIGN KEY ("player_id") REFERENCES "player" ("player_id"));

CREATE TABLE "player_award" ("player_id" TEXT, "award_id" TEXT, "year" INTEGER, "league_id" TEXT, "tie" TEXT, "notes" TEXT, FOREIGN KEY ("player_id") REFERENCES "player" ("player_id"));

CREATE TABLE "manager_award_vote" ("award_id" TEXT, "year" INTEGER, "league_id" TEXT, "player_id" TEXT, "points_won" INTEGER, "points_max" INTEGER, "votes_first" INTEGER);

CREATE TABLE "player_award_vote" ("player_id" TEXT, "award_id" TEXT, "year" INTEGER, "league_id" TEXT, "points_won" REAL, "points_max" INTEGER, "votes_first" REAL, FOREIGN KEY ("player_id") REFERENCES "player" ("player_id"));

CREATE TABLE "batting" ("player_id" TEXT, "year" INTEGER, "stint" INTEGER, "team_id" TEXT, "league_id" TEXT, "g" INTEGER, "ab" REAL, "r" REAL, "h" REAL, "double" REAL, "triple" REAL, "hr" REAL, "rbi" REAL, "sb" REAL, "cs" REAL, "bb" REAL, "so" REAL, "ibb" REAL, "hbp" REAL, "sh" REAL, "sf" REAL, "g_idp" REAL, FOREIGN KEY ("player_id") REFERENCES "player" ("player_id"));

CREATE TABLE "batting_postseason" ("team_id" TEXT, "player_id" TEXT, "year" INTEGER, "round" TEXT, "league_id" TEXT, "g" INTEGER, "ab" INTEGER, "r" INTEGER, "h" INTEGER, "double" INTEGER, "triple" INTEGER, "hr" INTEGER, "rbi" INTEGER, "sb" INTEGER, "cs" REAL, "bb" INTEGER, "so" INTEGER, "ibb" REAL, "hbp" REAL, "sh" REAL, "sf" REAL, "g_idp" REAL, FOREIGN KEY ("team_id") REFERENCES "team" ("team_id"), FOREIGN KEY ("player_id") REFERENCES "player" ("player_id"));

CREATE TABLE "player_college" ("college_id" TEXT, "player_id" TEXT, "year" INTEGER, FOREIGN KEY ("college_id") REFERENCES "college" ("college_id"), FOREIGN KEY ("player_id") REFERENCES "player" ("player_id"));

CREATE TABLE "fielding" ("player_id" TEXT, "year" INTEGER, "stint" INTEGER, "team_id" TEXT, "league_id" TEXT, "pos" TEXT, "g" INTEGER, "gs" REAL, "inn_outs" REAL, "po" REAL, "a" REAL, "e" REAL, "dp" REAL, "pb" REAL, "wp" REAL, "sb" REAL, "cs" REAL, "zr" REAL, FOREIGN KEY ("player_id") REFERENCES "player" ("player_id"));

CREATE TABLE "fielding_outfield" ("player_id" TEXT, "year" INTEGER, "stint" INTEGER, "glf" REAL, "gcf" REAL, "grf" REAL, FOREIGN KEY ("player_id") REFERENCES "player" ("player_id"));

CREATE TABLE "fielding_postseason" ("team_id" TEXT, "player_id" TEXT, "year" INTEGER, "league_id" TEXT, "round" TEXT, "pos" TEXT, "g" INTEGER, "gs" REAL, "inn_outs" REAL, "po" INTEGER, "a" INTEGER, "e" INTEGER, "dp" INTEGER, "tp" INTEGER, "pb" REAL, "sb" REAL, "cs" REAL, FOREIGN KEY ("player_id") REFERENCES "player" ("player_id"));

CREATE TABLE "hall_of_fame" ("player_id" TEXT, "yearid" INTEGER, "votedby" TEXT, "ballots" REAL, "needed" REAL, "votes" REAL, "inducted" TEXT, "category" TEXT, "needed_note" TEXT, FOREIGN KEY ("player_id") REFERENCES "player" ("player_id"));

CREATE TABLE "home_game" ("park_id" TEXT, "team_id" TEXT, "year" INTEGER, "league_id" TEXT, "span_first" TEXT, "span_last" TEXT, "games" INTEGER, "openings" INTEGER, "attendance" INTEGER, FOREIGN KEY ("park_id") REFERENCES "park" ("park_id"), FOREIGN KEY ("team_id") REFERENCES "team" ("team_id"));

CREATE TABLE "manager" ("team_id" TEXT, "player_id" TEXT, "year" INTEGER, "league_id" TEXT, "inseason" INTEGER, "g" INTEGER, "w" INTEGER, "l" INTEGER, "rank" REAL, "plyr_mgr" TEXT, FOREIGN KEY ("team_id") REFERENCES "team" ("team_id"));

CREATE TABLE "manager_half" ("team_id" TEXT, "player_id" TEXT, "year" INTEGER, "league_id" TEXT, "inseason" INTEGER, "half" INTEGER, "g" INTEGER, "w" INTEGER, "l" INTEGER, "rank" INTEGER, FOREIGN KEY ("team_id") REFERENCES "team" ("team_id"));

CREATE TABLE "player" ("player_id" TEXT UNIQUE, "birth_year" REAL, "birth_month" REAL, "birth_day" REAL, "birth_country" TEXT, "birth_state" TEXT, "birth_city" TEXT, "death_year" REAL, "death_month" REAL, "death_day" REAL, "death_country" TEXT, "death_state" TEXT, "death_city" TEXT, "name_first" TEXT, "name_last" TEXT, "name_given" TEXT, "weight" REAL, "height" REAL, "bats" TEXT, "throws" TEXT, "debut" TEXT, "final_game" TEXT, "retro_id" TEXT, "bbref_id" TEXT);

CREATE TABLE "park" ("park_id" TEXT UNIQUE, "park_name" TEXT, "park_alias" TEXT, "city" TEXT, "state" TEXT, "country" TEXT);

CREATE TABLE "pitching" ("player_id" TEXT, "year" INTEGER, "stint" INTEGER, "team_id" TEXT, "league_id" TEXT, "w" INTEGER, "l" INTEGER, "g" INTEGER, "gs" INTEGER, "cg" INTEGER, "sho" INTEGER, "sv" INTEGER, "ipouts" REAL, "h" INTEGER, "er" INTEGER, "hr" INTEGER, "bb" INTEGER, "so" INTEGER, "baopp" REAL, "era" REAL, "ibb" REAL, "wp" REAL, "hbp" REAL, "bk" INTEGER, "bfp" REAL, "gf" REAL, "r" INTEGER, "sh" REAL, "sf" REAL, "g_idp" REAL);

CREATE TABLE "pitching_postseason" ("player_id" TEXT, "year" INTEGER, "round" TEXT, "team_id" TEXT, "league_id" TEXT, "w" INTEGER, "l" INTEGER, "g" INTEGER, "gs" INTEGER, "cg" INTEGER, "sho" INTEGER, "sv" INTEGER, "ipouts" INTEGER, "h" INTEGER, "er" INTEGER, "hr" INTEGER, "bb" INTEGER, "so" INTEGER, "baopp" TEXT, "era" REAL, "ibb" REAL, "wp" REAL, "hbp" REAL, "bk" REAL, "bfp" REAL, "gf" INTEGER, "r" INTEGER, "sh" REAL, "sf" REAL, "g_idp" REAL);

CREATE TABLE "salary" ("year" INTEGER, "team_id" TEXT, "league_id" TEXT, "player_id" TEXT, "salary" INTEGER);

CREATE TABLE "college" ("college_id" TEXT UNIQUE, "name_full" TEXT, "city" TEXT, "state" TEXT, "country" TEXT);

CREATE TABLE "postseason" ("year" INTEGER, "round" TEXT, "team_id_winner" TEXT, "league_id_winner" TEXT, "team_id_loser" TEXT, "league_id_loser" TEXT, "wins" INTEGER, "losses" INTEGER, "ties" INTEGER);

CREATE TABLE "team" ("year" INTEGER, "league_id" TEXT, "team_id" TEXT UNIQUE, "franchise_id" TEXT, "div_id" TEXT, "rank" INTEGER, "g" INTEGER, "ghome" REAL, "w" INTEGER, "l" INTEGER, "div_win" TEXT, "wc_win" TEXT, "lg_win" TEXT, "ws_win" TEXT, "r" INTEGER, "ab" INTEGER, "h" INTEGER, "double" INTEGER, "triple" INTEGER, "hr" INTEGER, "bb" INTEGER, "so" REAL, "sb" REAL, "cs" REAL, "hbp" REAL, "sf" REAL, "ra" INTEGER, "er" INTEGER, "era" REAL, "cg" INTEGER, "sho" INTEGER, "sv" INTEGER, "ipouts" INTEGER, "ha" INTEGER, "hra" INTEGER, "bba" INTEGER, "soa" INTEGER, "e" INTEGER, "dp" REAL, "fp" REAL, "name" TEXT, "park" TEXT, "attendance" REAL, "bpf" INTEGER, "ppf" INTEGER, "team_id_br" TEXT, "team_id_lahman45" TEXT, "team_id_retro" TEXT);

CREATE TABLE "team_franchise" ("franchise_id" TEXT, "franchise_name" TEXT, "active" TEXT, "na_assoc" TEXT);

CREATE TABLE "team_half" ("year" INTEGER, "league_id" TEXT, "team_id" TEXT, "half" INTEGER, "div_id" TEXT, "div_win" TEXT, "rank" INTEGER, "g" INTEGER, "w" INTEGER, "l" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "team_franchise" ("franchise_id", "franchise_name", "active", "na_assoc") VALUES ('F1', 'Franchise One', 'N', 'NA1');
INSERT INTO "team_franchise" ("franchise_id", "franchise_name", "active", "na_assoc") VALUES ('F2', 'Franchise Two', 'N', 'NA2');
INSERT INTO "team_franchise" ("franchise_id", "franchise_name", "active", "na_assoc") VALUES ('F3', 'Franchise Three', NULL, 'NA3');
INSERT INTO "team_franchise" ("franchise_id", "franchise_name", "active", "na_assoc") VALUES ('F4', 'Franchise Four', 'y', 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "active", COUNT(*) AS "n" FROM (SELECT * FROM "team_franchise" WHERE ("active" = 'Y')) GROUP BY active) ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM team_franchise WHERE active = 'Y';

/*
Prediction Result:
(0,)
*/