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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', -2147483648, '2020-03-11 00:23:16+00:00', 'nprmdposii', '5u', 1861536320, 44952191, 1151980946, -2147483648, '2020-09-15 12:11:12+00:00', '2020-01-18 08:28:25+00:00', 1419861592, '2025-08-21 21:00:40+00:00', 'ecigce37', 'nium52zbu');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, -751275471, -1347802441, '2022-02-19 15:51:21+00:00', 1, -2118135981, 'ryytoo3', -2147483648, '2021-12-11 04:26:48+00:00', 'hl72klex1', 'ji7zwau2', 364869063, -953437896, -1097120355, -2147483648, '2022-10-12 16:19:32+00:00', '2024-06-05 19:22:34+00:00', 244829661, '2021-07-21 20:51:39+00:00', 'sl0', '4');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, -975213201, -705985602, '2025-02-21 13:28:29+00:00', 556727997, 1178000634, 'pz0f8jegd', -2147483648, '2023-11-06 04:09:03+00:00', 'vy9uxj4', 'wb', -1929953647, 1581736075, -261132974, -2147483648, '2021-09-30 11:37:26+00:00', '2020-07-01 12:41:54+00:00', -1052964641, '2021-10-14 08:16:37+00:00', 'cx5hn', 'p');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483645, -7597509, -1625552518, '2021-12-10 17:04:01+00:00', 1449284300, -977470238, 'd8y', -2147483648, '2023-05-06 21:04:41+00:00', '1afgo', 'ri', -902895762, -197933860, 2111987706, -2147483648, '2023-01-25 15:19:02+00:00', '2022-01-13 07:24:35+00:00', 1972233925, '2022-03-04 13:07:03+00:00', '4301jh3den8', 'c68x8vacx7');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483644, -698610044, -1021978385, '2025-05-19 01:18:37+00:00', -1488156735, -1858644047, 'o22', -2147483648, '2024-05-29 05:19:47+00:00', '507cvtjpt', 'tg6bnou5zi', 1944978593, 1722106924, -2072838897, -2147483648, '2021-05-31 16:00:51+00:00', '2020-10-11 01:34:34+00:00', 1923659053, '2020-02-08 07:26:28+00:00', 'cd07z2zezjo7', 'wgxd5ysxcm');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483643, 1497321728, -95808609, '2022-08-10 04:39:07+00:00', 1273687251, 333302050, 'najj', -2147483648, '2021-07-29 14:03:28+00:00', '3', 'okv8uttmu2', -1252009958, 1908593332, 697257217, -2147483648, '2023-05-05 20:15:58+00:00', '2024-06-27 07:12:45+00:00', 448935289, '2023-04-29 21:53:50+00:00', 'be8yvkv42q7', 'x58b4');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483642, -1514700303, -1796351243, '2020-09-13 06:13:20+00:00', -634585028, 1719800120, 'o', -2147483648, '2023-11-02 10:05:42+00:00', 'obb0q0k', '2odwcl5a', 292557306, 709097796, -984562992, -2147483648, '2023-01-20 18:10:08+00:00', '2023-03-23 15:19:54+00:00', -1689155697, '2023-08-12 12:46:14+00:00', 'j', '9erhizgk1yoe');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483641, -2076274980, 1731324803, '2021-12-15 23:43:59+00:00', -647898186, -1610380698, '5nxih66', -2147483648, '2023-10-03 17:29:40+00:00', '2xlyo', 'tow9oaawg96a', 966412849, -2061634386, -850941333, -2147483648, '2025-02-14 08:12:06+00:00', '2025-12-21 08:50:01+00:00', -1216952047, '2023-05-07 05:01:37+00:00', '9tajz9td', 'n5wcgumbc');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483640, -516345261, -1191116453, '2022-10-20 05:01:15+00:00', -1, -1934709172, '3', -2147483648, '2024-02-16 12:52:03+00:00', 'rmkio18ri2', 'y0', 168442149, 1299171592, 2066302536, -2147483648, '2024-04-19 20:17:36+00:00', '2020-07-31 07:58:47+00:00', -646944990, '2022-03-03 17:20:50+00:00', 'xnjaby', 'mzn2mfx7h3');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483639, 1728926031, -63214972, '2021-10-06 21:42:28+00:00', 0, -515419519, 'dyyd1jmgj', -2147483648, '2020-01-28 22:49:30+00:00', 'h', 'qta8y3a17', -735270562, 614314115, 306260487, -2147483648, '2020-02-17 14:43:43+00:00', '2023-04-07 07:58:06+00:00', -1941472821, '2025-06-16 07:53:05+00:00', 'ap96rn', 'dqrhm');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483638, 1409697108, -1104749933, '2024-09-08 22:53:00+00:00', -1, -384749431, 'm', -2147483648, '2025-02-20 13:44:44+00:00', 'qtgel', 'u', 422046500, -1750715330, 277649518, -2147483648, '2020-04-14 17:03:31+00:00', '2022-09-09 18:35:07+00:00', -1414362698, '2022-02-26 17:54:28+00:00', '1quik1yhb08h', 'st1');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, -59984348, -664303813, '2022-03-24 16:30:12+00:00', -1981402255, -890215420, '9n8c4pgu7v', -2147483648, '2020-09-25 19:25:33+00:00', '4h', 'ia2yp', -1670923962, 700293388, 906324270, -2147483648, '2020-04-05 14:43:51+00:00', '2020-03-08 22:40:47+00:00', 1072996612, '2024-04-12 00:38:47+00:00', 'uhv', 'l');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, -1610064545, 429706943, '2022-01-18 15:57:55+00:00', 1236688122, 2087640001, 'dposiie5unw', -2147483648, '2024-05-04 23:07:19+00:00', 'lfa', '9000t5c4ec', -1683203397, 528680845, -1585009206, -2147483648, '2021-08-19 01:10:02+00:00', '2024-10-24 14:16:53+00:00', -53231346, '2025-09-21 09:36:38+00:00', 'buo4nrq', 'rofqyp5s5b');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, 1, 1, '2024-06-15 00:00:00+00:00', NULL, 1, 'value', -2147483648, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, -2147483648, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, 1178636309, -1390245819, '2023-03-10 01:47:11+00:00', 1775126557, -74849714, '7zw', -2147483648, '2025-03-16 12:14:02+00:00', 'u', '2dwyrq13pyu7', 244829661, -1362461264, -904834265, -2147483648, '2023-07-26 21:52:05+00:00', '2020-03-25 00:00:06+00:00', 1692174491, '2024-03-18 20:04:07+00:00', 'i2rkf', 'vqx58pz0f');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483648, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

-- Inserting into table: comments --
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (1, 1, 418417917, 'fqyp', '2024-02-28 04:46:49+00:00', -2147483648, '5bbp0');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-1, 7, -1509264256, '0dz79f', '2021-04-23 15:57:00+00:00', -2147483648, 'q8');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (0, 7, -211209314, 'dqv0gcb9', '2024-08-05 04:49:57+00:00', -2147483648, 'zk3z');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483645, 1, -47052816, '1of77pzo72c', '2022-08-17 19:55:37+00:00', -2147483648, 'c');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483644, 1, 1269522000, 'ztdgj5i3lq5l', '2021-11-07 05:17:12+00:00', -2147483648, 'im5k');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483643, 1, 1849819405, 'us3auvmkrpdj', '2025-10-04 15:32:15+00:00', -2147483648, 'zw5chn');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483642, 1, 718167481, 'hdt6fuq', '2023-04-23 07:11:55+00:00', -2147483648, 'uzkb52');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483641, 1, 1378873397, 'u6bd0w9603', '2025-01-19 15:40:16+00:00', -2147483648, 'vzxw1rxe9yf');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (2, 3, 328305758, 'tliqa1', '2023-08-19 04:29:46+00:00', -2147483648, 'yytoo');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3, 6, -1937207087, 'vy9uxj4', '2021-01-22 00:53:52+00:00', -2147483648, 'bdvlph');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.Id) FROM posts AS T1 INNER JOIN comments AS T2 ON T1.Id = T2.PostId GROUP BY T1.Id ORDER BY SUM(T1.Score) DESC, COUNT(T2.Id) NULLS LAST LIMIT 1;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(c.Id) AS CommentCount FROM posts AS p INNER JOIN comments AS c ON p.Id = c.PostId WHERE p.Score = (SELECT MAX(Score) FROM posts);

/*
Prediction Result:
(0,)
*/