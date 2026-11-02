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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483648, 13244799, -1659388584, '2020-06-20 11:35:06+00:00', -1377057208, -841692980, 'bnp', 1, '2022-04-12 01:47:28+00:00', 'dpos', 'ie5', -1209887326, -1399556171, 1038707349, 1, '2024-12-31 04:19:17+00:00', '2024-10-02 15:57:32+00:00', 1620389964, '2025-05-02 19:47:39+00:00', '0t5c4ec', 'gce');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, -688509700, '2025-07-25 08:53:04+00:00', '9uxj4hwbdv', '2021-07-30 02:29:08+00:00', 'h2gn', 'q', 'nqcx5h', -1245312912, 1575412235, -988981234, -841004020, -361507387, '79fjgq8');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -211209314, '2023-11-18 03:19:57+00:00', 'dqv0gcb98ozk', '2023-12-12 02:47:46+00:00', 'bilyrkn', '6vck6ah0f8js', 'wlq7xb', 602161869, 1350414441, 2094425101, -961217731, -1888505890, 'z16nijjai5d');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (0, 1583472758, '2020-10-22 21:08:07+00:00', 'gjd8y', '2023-05-06 21:04:41+00:00', '1afgo', 'ri', 'tsj3ayxp1q4', -1538707438, -163600466, -1826414375, 357330522, -683007527, 'x');

-- Inserting into table: badges --
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483648, 1, 't1__d32101', '2020-04-05 14:43:51+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (2, 1, 't1__d32101', '2021-07-01 18:29:24+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (3, 1, 't1__d32101', '2020-08-18 16:30:34+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483645, 4, '@', '2021-10-07 12:15:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483644, 5, 'A', '2025-07-17 09:46:47+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483643, 4, '8', '2020-02-08 07:26:28+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483642, 5, ']', '2025-01-04 09:05:19+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483641, 4, '$', '2020-11-05 16:17:26+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483640, 5, 'a', '2022-08-10 04:39:07+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483639, 4, '!', '2020-01-08 04:07:26+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483638, 5, '1', '2025-11-25 02:19:30+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (4, 0, 'sh5knzys7', '2020-07-09 13:16:50+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (6, 0, 'yd1jmgj', '2020-01-28 22:49:30+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (5, 0, 'jq1', '2022-03-08 22:35:08+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (7, 5, 'k1y', '2025-10-15 06:35:43+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (8, 1, 'hria2ypuzhs', '2025-08-22 00:34:24+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (9, 1, 'fa9', '2023-06-17 21:52:40+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (10, 1, '5k5swwqcgs', '2021-06-17 14:22:38+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (11, 1, 'luhvdltti', '2021-07-20 10:41:36+00:00');

-- Inserting into table: comments --
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483648, -2147483648, -1585009206, '52zb', '2025-10-02 08:51:14+00:00', 1, 'o4nrqr');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483647, -2147483648, 775304493, 'qyp5s5bbp0', '2025-09-22 03:26:15+00:00', 1, 'eutliqa1');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483646, -2147483648, 274769912, 'oo3o9', '2020-12-13 17:48:30+00:00', 1, '72k');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483645, -2147483648, 1775126557, 'ji7zwau2', '2025-11-10 22:24:59+00:00', 1, 'w');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483644, -2147483648, -953437896, '3pyu78d', '2024-09-04 21:17:21+00:00', 1, 'rljsl0b4y');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483643, -2147483648, -1025564911, 'rkf9vqx5', '2024-08-09 01:13:45+00:00', 1, 'pz0f8jegd21');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483642, -2147483648, -1762140823, 'w1of77pz', '2021-11-28 21:12:32+00:00', 0, '72ctdctmfg62');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483641, -2147483648, -698610044, 'q8qdjpe1io22', '2024-05-29 05:19:47+00:00', 0, '507cvtjpt');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483640, -2147483648, 1467355421, 'ou5z', '2021-02-17 19:49:53+00:00', 0, '6c4bfkfo');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483639, -2147483648, -406331049, 'ezjo7wg', '2023-03-07 00:15:11+00:00', 0, '5');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483638, -2147483648, -915385605, 'm', '2022-04-20 03:52:20+00:00', 0, '0oztdgj5i3lq');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483637, -2147483648, -1212676731, 'm5k', '2024-03-11 05:11:39+00:00', 0, 'qs27p2r94');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483636, -2147483648, 333302050, 'najj', '2021-07-29 14:03:28+00:00', 0, '3');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483635, -2147483648, -1428186898, 'uttmu2ne5', '2024-11-14 17:33:35+00:00', 0, '8lfvyz7zz');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483634, -2147483648, 924693315, 'kv42q7', '2022-05-28 06:47:17+00:00', 0, '58b4pm');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483633, -2147483648, 1164790775, 'auvmkrpd', '2021-03-23 21:08:32+00:00', 0, 'wzw5chn9mo70');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483632, -2147483648, 238533676, 'jxfofws', '2023-05-19 01:23:31+00:00', 0, 'o');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483631, -2147483648, -1197954156, '0', '2022-03-19 07:41:34+00:00', 0, '0k32odwcl5a');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483630, -2147483648, -1177989415, 'wyn', '2025-04-18 20:42:36+00:00', 1, 'c1');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483629, -2147483648, 453340472, '9erhizgk1yoe', '2023-04-04 11:32:59+00:00', 1, 'o6l0hdt6fu');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483628, -2147483648, 1294064538, 'uzkb52', '2023-09-14 18:35:43+00:00', 1, 'wn');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483627, -2147483648, 1718516876, '6elbo', '2020-08-28 14:27:04+00:00', 1, 'wii1');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483626, -2147483648, -564679000, '66', '2023-10-03 17:29:40+00:00', 1, '2xlyo');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483625, -2147483648, 1083479253, '9oaawg', '2024-09-22 16:04:20+00:00', 1, 'aqb0tbind');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483624, -2147483648, 2085299664, 'j', '2023-05-09 01:10:53+00:00', 1, 'td8n5wcgu');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483623, -2147483648, 989306270, 'tdu6bd0w96', '2023-07-02 17:49:19+00:00', 1, 'vzxw1rxe');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483622, -2147483648, -1046720861, '162nh55y3d', '2025-02-15 07:25:43+00:00', 1, 'hvu0');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483621, -2147483648, -438741674, '5rmkio18', '2022-05-12 04:24:33+00:00', 1, 'i2hy08ftp6');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483620, -2147483648, -646944990, 'xxnja', '2020-02-18 15:32:47+00:00', 1, 'mzn2mfx');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483619, -2147483648, -156175571, '6sto', '2023-09-09 05:17:59+00:00', 1, 'j');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (5, -2147483648, 973811121, 'ta8y3a17v4', '2025-06-20 19:52:40+00:00', 0, 'gmayq3q');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (7, -2147483648, 608093726, 'p', '2024-09-13 03:07:40+00:00', 0, 'rntdqrhm5');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (2, -2147483648, -1369148652, '7', '2025-06-14 15:18:28+00:00', 0, 'dn2np490xdms');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3, -2147483648, -827883679, 'lc', '2022-09-26 08:18:54+00:00', 0, 'qb9i9f2ccu');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483614, -2147483648, -1437333179, 'wwqcg', '2022-06-28 11:34:24+00:00', 4, '9n8');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (4, -2147483648, -106629402, 'u7', '2022-10-19 03:44:42+00:00', 1, 'e4');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483612, -2147483648, 906324270, 'b', '2022-01-03 02:42:55+00:00', 5, 'luhvdltti');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (6, -2147483648, 429706943, 'rmdp', '2021-12-08 15:32:00+00:00', 1, 'siie5unw6k');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (8, -2147483648, -1980249628, 'gu7v', '2020-09-25 19:25:33+00:00', 1, '4h');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483609, -2147483648, 1914020640, 'ypuzhsrw', '2020-04-05 14:43:51+00:00', 4, 'p');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (9, -2147483648, -1257178728, 'mdpos', '2021-02-17 05:47:13+00:00', 1, 'e5u');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483607, -2147483648, -1399556171, 'a9000t5c4eci', '2025-03-10 20:24:26+00:00', 5, 'ce');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Name FROM badges AS T1 INNER JOIN comments AS T2 ON T1.UserId = t2.UserId GROUP BY T2.UserId ORDER BY COUNT(T2.UserId) DESC, Name NULLS LAST LIMIT 1;

/*
Gold Result:
('t1__d32101',)
*/

-- Prediction Query
SELECT T1.UserId, T2.Name FROM comments AS T1 INNER JOIN badges AS T2 ON T1.UserId = T2.UserId GROUP BY T1.UserId ORDER BY COUNT(T1.Id) DESC, T1.UserId NULLS LAST, T2.Name NULLS LAST LIMIT 1;

/*
Prediction Result:
(1, '5k5swwqcgs')
*/