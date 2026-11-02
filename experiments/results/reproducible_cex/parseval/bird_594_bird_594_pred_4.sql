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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, 907682809, 2026480202, '2021-02-17 05:47:13+00:00', -1602639011, -45536098, 'w6kl', 1, '2020-09-15 12:11:12+00:00', 'a9000t5c4eci', 'gce376nium52', -443340271, 757448742, -1179823637, 1, '2021-09-24 11:50:48+00:00', '2025-01-09 01:18:18+00:00', 902887186, '2025-10-19 18:29:54+00:00', 'rofqy', '5s5b');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, -458359144, 600440952, '2020-02-01 05:25:26+00:00', -1794176801, -1194675273, 'itsj3', 4, '2020-02-17 22:42:09+00:00', 'xp1q430', 'jh3den8', 195720193, 1774087382, 1732258051, 1, '2024-05-22 05:48:31+00:00', '2020-01-27 15:35:08+00:00', 2078438287, '2022-09-01 11:41:59+00:00', 'w1of77pz', '72ct');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, 1, '2024-12-15 00:56:33+00:00', '5k5swwqcgsk9', '2021-10-04 22:30:57+00:00', '8c4pgu7vfe', 'hria2ypu', 'hsrwbbp', 13244799, -1659388584, 1526238907, -1377057208, -841692980, 'bnp');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, 1, '2023-10-09 18:36:37+00:00', 'lex', '2023-08-25 07:55:29+00:00', 'ji7zwau2', 'dwyrq13pyu78', '9', 244829661, -1362461264, -904834265, -346339240, 1692174491, 'qi2rkf9v');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 556727997, '2024-02-28 14:45:41+00:00', 'pz0f8jegd', '2023-11-06 04:09:03+00:00', 'vy9uxj4', 'wb', 'v', 1581736075, -261132974, -1264842910, -1052964641, -1245682094, 'x');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -1823627488, '2022-10-15 07:04:26+00:00', 'w6kl', '2020-09-15 12:11:12+00:00', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 373262291, -472966518, -921187550, -2070843029, 328305758, 'tliqa1');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, -1390245819, '2023-03-10 01:47:11+00:00', '4ji7zwa', '2022-08-31 15:38:50+00:00', '2dwyrq13pyu7', 'd99rljsl0', '4', 1649269347, -1116181514, 1255852738, -1555456236, -975213201, '9v');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, 1581736075, '2023-09-26 13:08:37+00:00', 'nd', '2022-03-02 18:03:57+00:00', 'nqcx5h', 'cprj', 'u0dz7', 401805964, -1485777725, -1255130038, -1762857309, 806170397, 'qv0gcb98ozk');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, -1520489792, '2022-12-13 04:17:12+00:00', 'lq7xb7', '2025-04-29 15:45:27+00:00', '2fxa7ryfdrz', '16nijjai5dh', 'ogrgjd8y', 1129658414, 1250290042, -1717646459, -1696173285, 710458518, 'sj3ayxp1q430');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, -683007527, '2020-05-02 02:12:13+00:00', 'x7afu5w1of77', '2022-01-27 19:59:15+00:00', 'o72ctdc', 'mfg62', '0v', 820970595, 1421303999, -1488156735, -1858644047, -1180042408, '78507cvt');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (10, 2115816682, '2025-09-08 19:36:12+00:00', 'z2zezjo7w', '2020-12-04 11:46:08+00:00', 'd5ysxc', 'r0oz', 'dgj5i', -176606723, -15162884, 1339733032, -1556979799, -55240145, '8qs27p2r');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (11, 618058035, '2022-09-17 08:42:23+00:00', 'ne578lfv', '2025-08-19 19:51:44+00:00', 'z7zzbe8', 'yvkv42q7sx58', 'b4pmaus3auv', -1278087274, -1140595602, -609553675, 989018473, -55494714, 'n9');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (12, 1719800120, '2020-06-20 19:03:43+00:00', '2zob', '2020-04-02 11:13:10+00:00', 'q0k32od', 'cl5ams', 'orlwyngc1dj', 211603887, -413043724, 761519897, 1504707292, 955267863, 'eyo6');

-- Inserting into table: comments --
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483648, 1, 2107872094, '02eutliqa11r', '2023-03-22 03:47:49+00:00', 1, 'ytoo3o9hl7');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483647, 1, 722884590, 'hncprjtu0dz', '2024-06-08 14:05:00+00:00', 4, 'fjgq8n2f3');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483646, 1, 806170397, 'qv0gcb98ozk', '2023-12-12 02:47:46+00:00', 4, 'bilyrkn');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483645, 1, -688098735, '6ah', '2023-07-25 15:03:55+00:00', 4, '8j');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (2, 1, -932772113, 'lq7xb7', '2025-04-29 15:45:27+00:00', 1, '2fxa7ryfdrz');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3, 1, 61479715, 'jja', '2021-02-04 08:22:25+00:00', 1, 'dh5ogrgj');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483642, 2, -1928431425, 'mfg62', '2020-10-18 11:14:36+00:00', 1, 'v5q8qdj');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (4, 1, 2122220075, 'p6luhvdlttil', '2020-03-11 00:23:16+00:00', 3, 'nprmdposii');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (5, 2, 274769912, 'oo3o9', '2020-12-13 17:48:30+00:00', 5, '72k');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (6, 2, 537874887, 'z0f8jegd21vy', '2025-07-25 08:53:04+00:00', 6, '9uxj4hwbdv');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (7, 2, -2078052421, 'yrk', '2025-03-26 10:17:14+00:00', 7, 'n6vck6ah0f8');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (8, 2, 518609210, '3d', '2020-08-20 06:07:09+00:00', 8, '8c68');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (9, 1, -847293924, 'bnou5zi36', '2020-04-09 11:24:06+00:00', 9, 'bfkfoacd');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (10, 2, -1719383707, '2m', '2021-10-18 07:51:02+00:00', 10, 'ajjla3okv8u');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (11, 1, 823835795, '05a9n0jxf', '2021-12-11 06:40:50+00:00', 11, 'ws');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (12, 1, 1428194830, 'dt', '2024-04-21 11:49:54+00:00', 12, 'uq');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.Id, T2.Reputation FROM comments AS T1 INNER JOIN users AS T2 ON T1.UserId = T2.Id WHERE T1.PostId = 1;

/*
Gold Result:
(1, 1)
(4, 556727997)
(4, 556727997)
(4, 556727997)
(1, 1)
(1, 1)
(3, -55602865)
(9, -683007527)
(11, 618058035)
(12, 1719800120)
*/

-- Prediction Query
SELECT users.displayname, users.reputation FROM users INNER JOIN posts ON users.id = posts.owneruserid WHERE posts.id = 1;

/*
Prediction Result:
('5k5swwqcgsk9', 1)
*/