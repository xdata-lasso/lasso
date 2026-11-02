-- Schema DDL
CREATE TABLE badges (Id INTEGER NOT NULL PRIMARY KEY, UserId INTEGER NULL, Name TEXT NULL, Date DATETIME NULL, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE comments (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, Score INTEGER NULL, Text TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postHistory (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostHistoryTypeId INTEGER NULL, PostId INTEGER NULL, RevisionGUID TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, Text TEXT NULL, Comment TEXT NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postLinks (Id INTEGER NOT NULL PRIMARY KEY, CreationDate DATETIME NULL, PostId INTEGER NULL, RelatedPostId INTEGER NULL, LinkTypeId INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (RelatedPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE posts (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostTypeId INTEGER NULL, AcceptedAnswerId INTEGER NULL, CreaionDate DATETIME NULL, Score INTEGER NULL, ViewCount INTEGER NULL, Body TEXT NULL, OwnerUserId INTEGER NULL, LasActivityDate DATETIME NULL, Title TEXT NULL, Tags TEXT NULL, AnswerCount INTEGER NULL, CommentCount INTEGER NULL, FavoriteCount INTEGER NULL, LastEditorUserId INTEGER NULL, LastEditDate DATETIME NULL, CommunityOwnedDate DATETIME NULL, ParentId INTEGER NULL, ClosedDate DATETIME NULL, OwnerDisplayName TEXT NULL, LastEditorDisplayName TEXT NULL, FOREIGN KEY (LastEditorUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (OwnerUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE tags (Id INTEGER NOT NULL PRIMARY KEY, TagName TEXT NULL, Count INTEGER NULL, ExcerptPostId INTEGER NULL, WikiPostId INTEGER NULL, FOREIGN KEY (ExcerptPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE users (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, Reputation INTEGER NULL, CreationDate DATETIME NULL, DisplayName TEXT NULL, LastAccessDate DATETIME NULL, WebsiteUrl TEXT NULL, Location TEXT NULL, AboutMe TEXT NULL, Views INTEGER NULL, UpVotes INTEGER NULL, DownVotes INTEGER NULL, AccountId INTEGER NULL, Age INTEGER NULL, ProfileImageUrl TEXT NULL);

CREATE TABLE votes (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, VoteTypeId INTEGER NULL, CreationDate DATE NULL, UserId INTEGER NULL, BountyAmount INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: posts --
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', 0, -1349201381, 'hvdlttilbnpr', -2147483648, '2021-08-20 16:50:24+00:00', 'dposiie5unw', 'klfa9000t', 1408123494, 1, -1964997180, -2147483648, '2025-03-10 20:24:26+00:00', '2020-12-01 20:25:15+00:00', -1833165707, '2024-05-26 02:52:16+00:00', 'nium52zbu', '4nrq');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, -1068298341, -314162272, '2023-03-22 03:47:49+00:00', 0, -525979501, 'oo3o9hl72kl', -2147483648, '2020-08-18 16:30:34+00:00', 'x14ji7zwau2d', 'yrq13p', -533293970, 1, 176380444, -2147483648, '2024-09-04 21:17:21+00:00', '2024-09-26 13:13:01+00:00', -977635379, '2021-03-27 18:00:10+00:00', 'l0b4y', 'p5qi2rkf9v');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, 1178000634, 1836127587, '2023-06-28 05:47:44+00:00', 836513442, 176555546, 'gd', -2147483648, '2023-11-06 04:09:03+00:00', 'vy9uxj4', 'wb', -1929953647, 1581736075, -261132974, -2147483648, '2021-09-30 11:37:26+00:00', '2020-07-01 12:41:54+00:00', -1052964641, '2021-10-14 08:16:37+00:00', 'cx5hn', 'p');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, -59984348, -664303813, '2022-03-24 16:30:12+00:00', 1, -1981402255, 'k9n8c', -2147483648, '2024-01-16 07:29:50+00:00', 'gu7v', 'e4', 1160656988, 1, -992890117, -2147483648, '2020-01-15 18:18:33+00:00', '2023-10-02 15:43:02+00:00', 1219478689, '2022-10-06 13:20:05+00:00', 'hsrwbbp', 'luhvdltti');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, 1, 1, '2024-06-15 00:00:00+00:00', NULL, 1, 'value', -2147483648, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, -2147483648, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, 1119186446, 781505063, '2025-01-30 02:54:07+00:00', 0, -967741825, 'fqyp5s5bbp0', -2147483648, '2025-09-22 03:26:15+00:00', 'eutliqa1', 'ryytoo3', -1666765085, 2, 1178636309, -2147483648, '2021-07-01 18:29:24+00:00', '2020-08-18 16:30:34+00:00', 1055976837, '2023-08-25 07:55:29+00:00', 'ji7zwau2', 'dwyrq13pyu78');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, 556727997, 1178000634, '2024-08-09 01:13:45+00:00', 1, 537874887, 'z0f8jegd21vy', -2147483648, '2025-07-25 08:53:04+00:00', '9uxj4hwbdv', 'ph2', 1298861365, 2, 1968874827, -2147483648, '2022-12-08 23:34:02+00:00', '2021-10-14 08:16:37+00:00', -1070063173, '2025-05-09 05:17:21+00:00', '5hncpr', 'tu0');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, 1, 1, '2024-06-15 00:00:00+00:00', NULL, 1, 'value', -2147483648, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 2, 1, -2147483648, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, 1, 1, '2024-06-15 00:00:00+00:00', 0, 1, 'value', -2147483648, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, NULL, 1, -2147483648, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (10, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', -2147483648, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, NULL, 1, -2147483648, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (11, 1, 1, '2024-06-15 00:00:00+00:00', NULL, 1, 'value', -2147483648, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, NULL, 1, -2147483648, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483648, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

-- Inserting into table: comments --
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (1, 1, -1031969798, '5s5b', '2020-03-11 14:09:37+00:00', -2147483648, '02eu');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (2, 1, -1762857309, 'dqv0gcb98ozk', '2023-12-12 02:47:46+00:00', -2147483648, 'bilyrkn');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3, 1, -1672720816, '8j', '2022-05-28 16:44:30+00:00', -2147483648, 'wlq7xb');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483645, 1, -2115841792, 'dh5ogrgj', '2020-06-19 19:37:13+00:00', -2147483648, 'yzt1afgog');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483644, 1, 678047687, '3ay', '2023-01-25 15:19:02+00:00', -2147483648, '1q43');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483643, 1, 195720193, 'vacx7afu5', '2023-01-06 16:23:08+00:00', -2147483648, '1of77pzo72c');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (4, 3, 429706943, 'rmdp', '2021-12-08 15:32:00+00:00', -2147483648, 'siie5unw6k');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (5, 5, 1419861592, '4ecigce376n', '2021-02-10 21:10:52+00:00', -2147483648, 'm52zbu');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (6, 6, -977635379, 'sl0', '2020-03-25 00:00:06+00:00', -2147483648, 'yp5qi2rk');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (7, 7, 401805964, 'gq8', '2021-10-07 12:15:00+00:00', -2147483648, 'f3dqv0gc');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (8, 8, 1443629118, 'zbilyrkn', '2025-11-22 09:05:23+00:00', -2147483648, 'vck6ah0f8');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (9, 9, -639539893, '7xb72', '2020-09-05 12:25:49+00:00', -2147483648, 'a7ryfd');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (10, 10, -1259474148, 'jai', '2024-03-27 22:48:03+00:00', -2147483648, 'h');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (11, 11, -977470238, 'd8y', '2023-05-06 21:04:41+00:00', -2147483648, '1afgo');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM comments AS T1 INNER JOIN posts AS T2 ON T1.PostId = T2.Id WHERE T2.CommentCount = 1 AND T2.Score = 0;

/*
Gold Result:
(6,)
*/

-- Prediction Query
SELECT COUNT(*) FROM comments WHERE Score = 0 AND PostId IN (SELECT Id FROM posts WHERE CommentCount = 1);

/*
Prediction Result:
(0,)
*/