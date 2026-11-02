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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, 1072996612, 13244799, '2022-09-23 20:24:07+00:00', 1019800248, -1910425938, 'tilbn', 1, '2022-01-18 15:57:55+00:00', 'mdpos', 'ie5', -1209887326, -1399556171, 1038707349, 1, '2024-12-31 04:19:17+00:00', '2024-10-02 15:57:32+00:00', 1620389964, '2025-05-02 19:47:39+00:00', '0t5c4ec', 'gce');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, -211209314, -1056308489, '2023-06-17 22:27:46+00:00', 331812443, 1382410067, '9', 1, '2024-08-05 04:49:57+00:00', 'zk3z', 'i', -512640349, 1038566008, 32204797, 4, '2020-04-16 10:31:38+00:00', '2021-05-17 23:21:59+00:00', 37673509, '2025-01-10 14:09:09+00:00', 'h0f8jswwlq7x', '7');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, -541746689, 1294666887, '2023-03-26 06:11:01+00:00', -1888505890, 777149609, '16nijjai5dh', 4, '2024-02-27 00:46:50+00:00', 'grgj', '8', -458359144, 600440952, 1568069663, 4, '2020-09-12 13:47:57+00:00', '2020-11-06 22:27:04+00:00', -1194675273, '2022-05-19 02:17:07+00:00', 'tsj', 'ayxp1q43');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 1072996612, 13244799, '2022-09-23 20:24:07+00:00', 1019800248, -1910425938, 'tilbn', 1, '2022-01-18 15:57:55+00:00', 'mdpos', 'ie5', -1209887326, -1399556171, 1038707349, 1, '2024-12-31 04:19:17+00:00', '2024-10-02 15:57:32+00:00', 1620389964, '2025-05-02 19:47:39+00:00', '0t5c4ec', 'gce');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, -1362461264, -904834265, '2023-07-26 21:52:05+00:00', -2031361952, 1649269347, 'p5qi2rkf9v', 4, '2022-03-30 02:18:34+00:00', 'x58pz0f8je', 'd2', 1675430660, -688509700, -792092619, 5, '2024-12-23 02:48:29+00:00', '2021-04-18 18:49:15+00:00', -87647544, '2023-01-02 20:56:29+00:00', 'd', 'lph2gn');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, 1427161052, 564390026, '2024-11-03 18:41:48+00:00', 61479715, -1496556994, 'i', 1, '2024-03-27 22:48:03+00:00', 'h', 'ogrgjd8y', 1129658414, 1250290042, -1717646459, 3, '2020-11-22 11:14:57+00:00', '2022-05-19 02:17:07+00:00', 710458518, '2025-08-05 22:21:48+00:00', 'j3ayx', '1q43');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, -2033879835, 1798111945, '2022-09-30 05:55:33+00:00', -29242208, 1691780814, '6c4bfkfo', 7, '2020-02-08 07:26:28+00:00', 'cd07z2zezjo7', 'wgxd5ysxcm', 1721638020, 983324983, 1269522000, 5, '2025-12-11 00:03:18+00:00', '2023-06-13 22:32:32+00:00', -870767087, '2020-11-20 06:56:49+00:00', '5i3', 'q5l');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, 989018473, -55494714, '2020-12-08 09:40:56+00:00', 101754718, 628082526, '9n0jxfofwsz', 7, '2020-06-20 19:03:43+00:00', '2zob', '0', 375841374, -1449226553, -225238282, 6, '2020-06-28 23:31:51+00:00', '2023-01-14 08:25:47+00:00', 440115543, '2025-04-19 10:34:51+00:00', 'msorlwyngc', 'dj9erhi');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, 152478847, -625404808, '2020-11-23 15:43:29+00:00', -794767771, 989306270, 'tdu6bd0w96', 1, '2023-07-02 17:49:19+00:00', 'vzxw1rxe', '9yfk7qk162n', -516345261, -1191116453, 1709667347, 5, '2022-09-26 18:21:28+00:00', '2023-07-30 22:23:05+00:00', 30861410, '2023-05-21 01:39:33+00:00', '3', 'rmkio18r');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (10, 555368535, -1369148652, '2020-05-22 01:58:51+00:00', -1260548409, 1409697108, 'p490xdmsqt', 3, '2020-11-30 04:51:31+00:00', 'lc', 'qb9i9f', -788896327, -1541581575, -325680600, 2, '2022-09-04 04:40:22+00:00', '2021-02-17 14:55:24+00:00', -1459013972, '2025-12-05 08:19:48+00:00', 'yhb08hlst1p', 'qomiztvb6m');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -751275471, '2021-08-01 11:21:15+00:00', 'qa1', '2023-08-19 04:29:46+00:00', 'yytoo', 'o9hl72kl', 'x1', -74849714, 105869088, -2081315180, 1909986641, 1485335077, 'yrq13pyu78d9');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 1661181156, '2021-07-14 21:04:24+00:00', 'b4yp5qi', '2023-10-21 02:54:45+00:00', 'kf9vq', 'x58pz0f8je', 'd2', 1675430660, -688509700, -792092619, -1492524358, -1612443122, 'd');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -751275471, '2021-08-01 11:21:15+00:00', 'qa1', '2023-08-19 04:29:46+00:00', 'yytoo', 'o9hl72kl', 'x1', -74849714, 105869088, -2081315180, 1909986641, 1485335077, 'yrq13pyu78d9');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, -1255130038, '2020-10-05 05:32:26+00:00', 'dqv0gcb9', '2024-08-05 04:49:57+00:00', 'zk3z', 'i', 'yrk', 32204797, -1672720816, -1520489792, -658391922, -1388029300, 'xb72fxa7r');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, 76996700, '2023-05-23 12:32:01+00:00', '72ct', '2020-06-07 10:59:23+00:00', 't', 'mfg62g0v5q8q', 'j', -1139855872, -288338724, 1897687032, -241848752, 2004147439, 'tjpttg');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, -1428186898, '2024-08-16 16:07:41+00:00', 'uttmu2ne578', '2021-06-23 03:34:31+00:00', 'vy', '7zzbe8y', 'kv42q7', -2060082151, -1122409769, 1849819405, -929383517, -2090240067, 'mkrpdj');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, 1718516876, '2022-06-25 15:47:56+00:00', 'elboeowii', '2023-09-21 01:04:05+00:00', '5nxih66', 'q2xlyoto', '9oaawg', 1044710644, 966412849, -2061634386, -850941333, -1216952047, '39tajz9');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (10, 1243701948, '2023-12-11 11:19:14+00:00', 'p6sto1cj', '2024-08-04 01:35:33+00:00', 'h5knz', 'ys7dyyd1jmg', 'jach8qta8y3', -2125172723, 339193890, -493230039, -2081662466, -1941472821, 'uap96rntdqr');

-- Inserting into table: posthistory --
INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483648, -1585009206, 1, '52zb', '2025-10-02 08:51:14+00:00', 1, 'o4nrqr', 'fqyp', 's5bbp02e');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483647, -736979194, 1, 'h2gn', '2020-07-01 12:41:54+00:00', 4, 'wnqcx', '5hncprjtu0d', '79fjgq8');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483646, 1235416111, 4, 'jh3den8', '2025-01-28 02:00:27+00:00', 1, 'c68x8vacx7', 'f', '5w1of7');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483645, -435350511, 1, '72ctdctmfg62', '2020-10-18 11:14:36+00:00', 4, 'v5q8qdj', 'e1io', '278507cv');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483644, -847293924, 4, 'bnou5zi36', '2020-04-09 11:24:06+00:00', 1, 'bfkfoacd', '7z2zezj', '7wgx');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483643, -526612570, 1, 'cmr0oz', '2022-07-12 13:13:05+00:00', 4, 'g', '5i3', 'q5l');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483642, 1692046802, 4, '5k58', '2022-02-21 20:00:53+00:00', 1, 's27p2r94gth2', 'najj', 'a3o');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (2, -761353513, 1, 'tmu2ne578l', '2020-09-26 00:22:30+00:00', 1, 'yz7zzb', '8y', 'kv42q7');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (3, -2060082151, 1, 'pmaus3auvmkr', '2025-06-17 13:01:08+00:00', 1, 'djwz', 'w5chn9mo705a', '9n0jxfofwsz');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483639, 375841374, 1, '32o', '2020-06-28 23:31:51+00:00', 1, 'cl5ams', 'orlwyngc1dj', '9erhizgk1yoe');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (4, -1585009206, 2, '52zb', '2025-10-02 08:51:14+00:00', 3, 'o4nrqr', 'fqyp', 's5bbp02e');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (5, 1968874827, 5, 'nqcx5h', '2021-10-14 14:41:11+00:00', 5, 'p', 'jtu0d', '79fjgq8');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (6, 1235416111, 6, 'jh3den8', '2025-01-28 02:00:27+00:00', 6, 'c68x8vacx7', 'f', '5w1of7');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (7, 1339733032, 7, 'im5k', '2024-03-11 05:11:39+00:00', 7, 'qs27p2r94', 'th', '2mnajjla3o');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (8, 1056589776, 8, 'k1', '2023-04-06 19:38:57+00:00', 8, 'eyo6', 'l0hdt6fuqyx', 'uzkb521gwnl');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (9, 431832073, 9, 'hy08ftp6', '2020-07-31 07:58:47+00:00', 9, 'tqxxnj', 'b', 'mzn2mfx');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (10, -74691962, 10, '78aqqlu', '2020-06-26 14:04:44+00:00', 10, 'ftb8r9114', 'bre6b', 'jeuuwsj8kj');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(IIF(T1.DisplayName = 'Mornington', T3.ViewCount, 0)) - SUM(IIF(T1.DisplayName = 'Amos', T3.ViewCount, 0)) AS diff FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId INNER JOIN posts AS T3 ON T3.Id = T2.PostId;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT CAST((SELECT SUM(ViewCount) FROM posts WHERE OwnerDisplayName = 'Mornington') AS REAL) - CAST((SELECT SUM(ViewCount) FROM posts WHERE OwnerDisplayName = 'Amos') AS REAL) AS ViewCountDifference;

/*
Prediction Result:
(None,)
*/