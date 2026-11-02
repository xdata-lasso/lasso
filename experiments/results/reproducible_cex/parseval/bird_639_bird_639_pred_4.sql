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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, -1910425938, -845863578, '2021-01-23 18:11:33+00:00', -1364429300, -1257178728, 'mdpos', 1, '2021-02-17 05:47:13+00:00', 'e5u', 'w6kl', 1620389964, 546571701, 947159877, 1, '2022-07-16 22:41:51+00:00', '2024-03-03 15:52:53+00:00', -1964997180, '2025-03-10 20:24:26+00:00', 'ce', '76nium52');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, -1660358170, -1106350634, '2021-04-06 16:11:52+00:00', -841004020, -361507387, '79fjgq8', 1, '2021-10-07 12:15:00+00:00', 'f3dqv0gc', '9', 172461907, 1606439408, 1443629118, 3, '2023-12-12 02:47:46+00:00', '2023-05-15 04:44:08+00:00', 1686459626, '2021-03-04 22:18:05+00:00', 'yrk', 'n6vck6ah0f');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, -932772113, -639539893, '2022-03-20 09:18:33+00:00', -566887085, 602161869, 'xa', 1, '2024-12-20 11:42:02+00:00', 'ryfdrz16n', 'jja', -7597509, -1625552518, -1738458256, 4, '2020-11-09 07:36:21+00:00', '2021-04-29 02:40:32+00:00', -458359144, '2025-06-10 19:01:27+00:00', 'afgogri', 'tsj3ayxp1q4');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, 2078438287, -47052816, '2025-07-13 05:36:35+00:00', -290314193, 76996700, 'o72ctdc', 1, '2022-08-05 18:12:12+00:00', 'mfg62g0v5q8q', 'j', -1139855872, -288338724, 1897687032, 4, '2023-10-10 11:56:21+00:00', '2023-10-17 13:49:58+00:00', 2004147439, '2022-11-19 00:43:43+00:00', 'jpttg', 'bnou5zi36');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483644, 1105964624, -663234145, '2020-04-07 03:05:00+00:00', -1674145149, 234957614, 'o705a9n0jxfo', 1, '2020-09-13 06:13:20+00:00', 'szdo2z', 'obb0q0k32o', -1898678660, 440115543, 292557306, 1, '2025-08-28 09:25:40+00:00', '2021-12-02 07:29:49+00:00', -984562992, '2023-01-20 18:10:08+00:00', 'ngc1dj9', 'rh');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483643, -1589605308, -268740517, '2024-03-11 19:06:57+00:00', 1557188093, 548968280, 'h66', 1, '2023-10-03 17:29:40+00:00', '2xlyo', 'tow9oaawg96a', 966412849, -2061634386, -850941333, 3, '2025-02-14 08:12:06+00:00', '2025-12-21 08:50:01+00:00', -1216952047, '2023-05-07 05:01:37+00:00', '9tajz9td', 'n5wcgumbc');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483642, 237552112, -1046720861, '2024-12-06 05:16:35+00:00', 312804300, -246257698, '55', 1, '2023-03-25 22:22:29+00:00', 'dohvu06d', 'a35rmki', -1160642134, 769234989, 168442149, 4, '2025-03-31 02:33:27+00:00', '2022-08-22 09:26:04+00:00', 2066302536, '2024-04-19 20:17:36+00:00', 'wt', 'xxnja');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483641, -1154091048, -1971560508, '2024-08-04 01:35:33+00:00', 1728926031, -63214972, 'zys7', 1, '2020-07-09 13:16:50+00:00', 'yd1jmgj', 'c', 973811121, 280292620, 620355627, 3, '2025-04-13 01:34:03+00:00', '2024-08-25 18:28:13+00:00', 1122899168, '2023-12-07 21:40:21+00:00', '1', 'v4ygmayq3');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'Community', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -1347802441, '2022-02-19 15:51:21+00:00', 'Community', '2020-01-22 05:30:29+00:00', '1ryytoo', 'o9hl72kl', 'x1', -74849714, 105869088, -2081315180, 1909986641, 1485335077, 'yrq13pyu78d9');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, -1362461264, '2022-06-17 21:46:26+00:00', '0b4', '2023-04-11 01:23:11+00:00', 'p5qi2rkf9v', 'x58pz', 'f8jegd2', 1675430660, -688509700, -792092619, -1492524358, -1612443122, 'd');

-- Inserting into table: tags --
INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483648, 'uo4nrqrofqy', -1106983592, 1, 1884179925);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483647, 'r', 328305758, 1, -751275471);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483646, 'h2gn', 1968874827, 1, -664193365);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483645, '01jh3den', 357330522, 2, -683007527);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483644, '4', -2072838897, 4, -1173368267);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483643, '0', 76987628, 1, -253138337);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483642, 'jo7wgxd', 1999335832, 2, -526612570);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483641, '0oztd', -1699185893, 4, 875300074);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483640, '5lnpi', -1300180872, 1, -1125548818);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483639, 'gth2mnaj', -1478011227, 2, -2096405521);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483638, '8uttmu', -229022515, 4, -1817527403);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483637, 'fvy', -451030047, 1, -2052653308);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483636, 'kv42q7', -2060082151, 2, -1122409769);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483635, 's3auvm', 274891948, 4, 609771851);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483634, 'zgk1yoeyo6l0', -1614619556, 1, 1435223075);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (2, 'uzkb52', -277407746, 1, -670154354);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (3, 'as6', -2076274980, 1, 1731324803);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483631, '3tdu6bd0w9', -379749892, 1, -541917667);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483630, 'mzn2mfx', 1243701948, 1, -156175571);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483629, 'dpuap96rntdq', -951706262, 1, -1324935647);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483628, '7', 899787662, 1, 594760660);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483627, 'p490xdmsqtge', -1391541536, 1, -1025517017);

INSERT INTO "tags" ("id", "tagname", "count", "excerptpostid", "wikipostid") VALUES (-2147483626, 't2__6cb7c8', 238243966, 1, -788896327);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(IIF(T3.TagName = 'r', 1, 0)) AS REAL) * 100 / COUNT(T1.Id) FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId INNER JOIN tags AS T3 ON T3.ExcerptPostId = T2.PostId WHERE T1.DisplayName = 'Community';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T2.TagName = 'r' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) AS percentage FROM posts AS T1 INNER JOIN users AS T3 ON T1.OwnerUserId = T3.Id INNER JOIN posts AS T4 ON T4.Id = T1.Id INNER JOIN tags AS T2 ON T2.ExcerptPostId = T4.Id WHERE T3.DisplayName = 'Community';

/*
Prediction Result:
(4.3478260869565215,)
*/