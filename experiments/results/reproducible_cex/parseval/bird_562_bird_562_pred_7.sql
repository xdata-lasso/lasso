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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1910, 'hvdlttilbnpr', -2147483648, '2021-08-20 16:50:24+00:00', 'dposiie5unw', 'klfa9000t', 1408123494, -1964997180, 1149850321, -2147483648, '2020-05-18 19:45:10+00:00', '2025-04-19 21:11:20+00:00', -1833165707, '2024-05-26 02:52:16+00:00', 'nium52zbu', '4nrq');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, -1068298341, -314162272, '2023-03-22 03:47:49+00:00', -525979501, 1910, 'oo3o9hl72kl', -2147483648, '2020-08-18 16:30:34+00:00', 'x14ji7zwau2d', 'yrq13p', -533293970, 176380444, -977635379, -2147483648, '2021-03-27 18:00:10+00:00', '2022-06-17 21:46:26+00:00', -1372125820, '2020-03-25 00:00:06+00:00', 'yp5qi2rk', '9v');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, 1178000634, 1836127587, '2023-06-28 05:47:44+00:00', 836513442, 176555546, 'gd', -2147483648, '2023-11-06 04:09:03+00:00', 'vy9uxj4', 'wb', -1929953647, 1581736075, -261132974, -2147483648, '2021-09-30 11:37:26+00:00', '2020-07-01 12:41:54+00:00', -1052964641, '2021-10-14 08:16:37+00:00', 'cx5hn', 'p');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, 1, 1, '2024-06-15 00:00:00+00:00', 1, NULL, 'value', -2147483648, '2024-06-15 00:00:00+00:00', 'value', 'value', 1, 1, 1, -2147483648, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, -59984348, -664303813, '2022-03-24 16:30:12+00:00', -1981402255, 1910, 'k9n8c', -2147483648, '2024-01-16 07:29:50+00:00', 'gu7v', 'e4', 1160656988, -992890117, 1914020640, -2147483648, '2023-10-02 15:43:02+00:00', '2023-03-21 21:13:18+00:00', 1115440883, '2023-05-25 17:04:36+00:00', 'sr', 'wbbp6luhvdlt');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, -1823627488, -1209887326, '2024-05-04 23:07:19+00:00', -1399556171, 1910, 'a9000t5c4eci', -2147483648, '2025-03-10 20:24:26+00:00', 'ce', '76nium52', -443340271, 757448742, -1179823637, -2147483648, '2021-09-24 11:50:48+00:00', '2025-01-09 01:18:18+00:00', 902887186, '2025-10-19 18:29:54+00:00', 'rofqy', '5s5b');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, 226938182, 90119032, '2021-05-27 14:39:41+00:00', -1390245819, 1910, 'x14ji7zwau2d', -2147483648, '2023-01-13 04:58:30+00:00', 'yrq13pyu78d9', 'rljsl0b4y', -1116181514, 1255852738, -1555456236, -2147483648, '2022-04-27 23:55:02+00:00', '2021-05-26 08:15:06+00:00', -705985602, '2025-02-21 13:28:29+00:00', 'x58pz0f8jeg', 'd21vy9uxj4hw');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, 555413010, 722884590, '2025-05-27 16:57:17+00:00', -1660358170, 1910, 'p', -2147483648, '2022-04-18 00:53:20+00:00', 'tu0', 'z', -1748371085, -1742081330, 894242932, -2147483648, '2023-11-01 15:52:25+00:00', '2020-10-05 05:32:26+00:00', -1056308489, '2023-06-17 22:27:46+00:00', 'gcb98ozk3z', 'i');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, -566887085, 602161869, '2020-09-05 12:25:49+00:00', 2094425101, 1910, '7', -2147483648, '2022-05-08 02:53:39+00:00', 'fdrz16n', 'jja', -7597509, -1625552518, -1738458256, -2147483648, '2020-11-09 07:36:21+00:00', '2021-04-29 02:40:32+00:00', -458359144, '2025-06-10 19:01:27+00:00', 'afgogri', 'tsj3ayxp1q4');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (10, -47052816, 645287482, '2021-11-22 07:38:31+00:00', 76996700, 1910, 'o72ctdc', -2147483648, '2022-08-05 18:12:12+00:00', 'mfg62g0v5q8q', 'j', -1139855872, -288338724, 1897687032, -2147483648, '2023-10-10 11:56:21+00:00', '2023-10-17 13:49:58+00:00', 2004147439, '2022-11-19 00:43:43+00:00', 'jpttg', 'bnou5zi36');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483648, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

-- Inserting into table: comments --
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483648, 1, -1031969798, '5s5b', '2020-03-11 14:09:37+00:00', -2147483648, '02eu');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483647, 4, -1509264256, '0dz79f', '2021-04-23 15:57:00+00:00', -2147483648, 'q8');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483646, 4, -1056308489, 'gcb98oz', '2021-05-16 14:38:12+00:00', -2147483648, 'zbilyrkn');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483645, 4, 37673509, 'h0f8jswwlq', '2024-06-08 00:23:27+00:00', -2147483648, 'xb72fxa7ryfd');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483644, 4, -1259474148, 'jai', '2024-03-27 22:48:03+00:00', -2147483648, 'h');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (2, 1, -977470238, 'd8y', '2023-05-06 21:04:41+00:00', -2147483648, '1afgo');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3, 1, -946046410, 'tsj3ayxp1q4', '2023-11-21 06:57:41+00:00', -2147483648, '1jh3den');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483641, 1, -435350511, '72ctdctmfg62', '2020-10-18 11:14:36+00:00', -2147483648, 'v5q8qdj');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483640, 1, -1180042408, '78507cvt', '2021-03-27 11:42:11+00:00', -2147483648, 'ttg6');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (4, 3, -921145356, 'qcgsk9', '2021-10-04 22:30:57+00:00', -2147483648, '8c4pgu7vfe');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (5, 5, -1610064545, 'n', '2022-01-18 15:57:55+00:00', -2147483648, 'mdpos');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (6, 6, 328305758, 'tliqa1', '2023-08-19 04:29:46+00:00', -2147483648, 'yytoo');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (7, 7, -1929953647, 'ph2', '2020-12-04 21:49:29+00:00', -2147483648, 'dqwn');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (8, 8, 982314585, 'kn6vc', '2021-05-17 23:21:59+00:00', -2147483648, 'ah0f8jsww');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (9, 9, 1235416111, 'jh3den8', '2025-01-28 02:00:27+00:00', -2147483648, 'c68x8vacx7');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (10, 10, 1722106924, 'f', '2021-05-31 16:00:51+00:00', -2147483648, 'oa');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.Id) FROM posts AS T1 INNER JOIN comments AS T2 ON T1.Id = T2.PostId WHERE T1.ViewCount = 1910;

/*
Gold Result:
(11,)
*/

-- Prediction Query
SELECT T2.CommentCount FROM comments AS T1 INNER JOIN posts AS T2 ON T1.PostId = T2.Id WHERE T2.ViewCount = 1910;

/*
Prediction Result:
(-1964997180,)
(-1964997180,)
(-1964997180,)
(-1964997180,)
(-1964997180,)
(-992890117,)
(757448742,)
(1255852738,)
(-1742081330,)
(-1625552518,)
(-288338724,)
*/