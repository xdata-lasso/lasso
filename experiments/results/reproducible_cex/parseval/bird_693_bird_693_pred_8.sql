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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', 1, '2020-03-11 00:23:16+00:00', 'nprmdposii', '5u', 1861536320, 44952191, 1151980946, 1, '2020-09-15 12:11:12+00:00', '2020-01-18 08:28:25+00:00', 1419861592, '2025-08-21 21:00:40+00:00', 'ecigce37', 'nium52zbu');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (0, -1929953647, 1581736075, '2023-09-26 13:08:37+00:00', 1298861365, 1968874827, 'nqcx5h', 0, '2021-10-14 14:41:11+00:00', 'p', 'jtu0d', 401805964, -1485777725, -1255130038, 1, '2020-10-05 05:32:26+00:00', '2023-11-18 03:19:57+00:00', 806170397, '2025-08-02 02:30:29+00:00', 'qv0gcb98ozk', 'zbilyrkn');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-1, -541746689, 1294666887, '2023-03-26 06:11:01+00:00', -1888505890, 777149609, '16nijjai5dh', -1, '2024-02-27 00:46:50+00:00', 'grgj', '8', -458359144, 600440952, 1568069663, 0, '2020-09-12 13:47:57+00:00', '2020-11-06 22:27:04+00:00', -1194675273, '2022-05-19 02:17:07+00:00', 'tsj', 'ayxp1q43');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, -546516406, -405743609, '2020-06-02 03:52:50+00:00', -1699185893, 875300074, '3lq', 1, '2025-11-16 21:50:04+00:00', 'lnpim5k5', 'qs27p2r94', -1719383707, 1273687251, 333302050, -1, '2021-08-24 18:58:08+00:00', '2021-10-18 07:51:02+00:00', -2136247961, '2021-04-29 06:47:06+00:00', 'a3o', 'v8u');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, 362376128, -1311735207, '2023-10-19 18:37:00+00:00', -1252009958, 1908593332, 'vy', 1, '2023-05-05 20:15:58+00:00', 'zzbe8yvkv', '42q7sx58b4', -1122409769, 1849819405, -929383517, -1, '2020-02-11 09:48:43+00:00', '2022-09-08 09:11:51+00:00', -699574669, '2021-05-14 07:56:41+00:00', 'rpdjwzw5ch', '9mo7');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', 2, '2020-03-11 00:23:16+00:00', 'nprmdposii', '5u', 1861536320, 44952191, 1151980946, 1, '2020-09-15 12:11:12+00:00', '2020-01-18 08:28:25+00:00', 1419861592, '2025-08-21 21:00:40+00:00', 'ecigce37', 'nium52zbu');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, -977635379, 1661181156, '2021-07-14 21:04:24+00:00', -346339240, 1692174491, 'qi2rkf9v', 3, '2022-03-30 02:18:34+00:00', 'x58pz0f8je', 'd2', 1675430660, -688509700, -792092619, 3, '2024-12-23 02:48:29+00:00', '2021-04-18 18:49:15+00:00', -87647544, '2023-01-02 20:56:29+00:00', 'd', 'lph2gn');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, -566887085, 602161869, '2020-09-05 12:25:49+00:00', 2094425101, -961217731, 'dr', 4, '2025-10-16 14:52:58+00:00', '16nijja', '5dh', 1583472758, 1449284300, -977470238, 0, '2021-04-29 02:40:32+00:00', '2020-06-19 19:37:13+00:00', 1074760385, '2023-05-06 21:04:41+00:00', '1afgo', 'ri');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, -847293924, -2033879835, '2021-12-07 07:01:12+00:00', 944975670, -1575410149, 'c4bfkfoac', 5, '2020-07-08 07:50:44+00:00', '7z2zezj', '7wgx', -57705450, -915385605, -2005628382, -1, '2022-04-20 03:52:20+00:00', '2023-06-27 00:46:15+00:00', 1269522000, '2025-12-11 00:03:18+00:00', 'tdgj5i3', 'q5l');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, -699574669, 274891948, '2025-06-17 13:01:08+00:00', -1140595602, -609553675, 'w5chn9mo705a', 6, '2025-07-08 06:16:45+00:00', 'n0jxfofws', 'do2zobb', -397848196, -366775518, 575038073, 4, '2021-12-14 11:59:29+00:00', '2020-06-28 23:31:51+00:00', -613916489, '2021-07-10 06:02:47+00:00', '5amsorlwyngc', 'dj9erhi');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, 727608179, 456034296, '2023-01-03 20:24:22+00:00', -1048779857, -381485009, 'i', 7, '2025-04-01 08:16:25+00:00', 'dz39', 'ajz9t', 748154000, 1148916014, -1988582944, 7, '2022-09-05 12:39:02+00:00', '2021-09-22 22:06:25+00:00', 989306270, '2025-03-26 09:37:26+00:00', 'tdu6bd0w96', '3vzxw1r');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-1, -868774469, '1970-01-01 00:00:01+00:00', 'qa1', '2023-08-19 04:29:46+00:00', 'yytoo', 'o9hl72kl', 'x1', -74849714, 105869088, -2081315180, 1909986641, 1485335077, 'yrq13pyu78d9');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (0, 244829661, '1970-01-01 00:00:00+00:00', 'jsl', '2023-07-26 21:52:05+00:00', '4', 'p5qi2rk', '9v', 556727997, 1178000634, 1836127587, -1529584866, 1196308825, 'd21vy9uxj4hw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -868774469, '2021-03-04 19:22:02+00:00', 'a11ry', '2024-10-18 05:00:47+00:00', 'too3o9h', '72k', 'ex1', -74849714, 105869088, -2081315180, 1909986641, 1485335077, 'yrq13pyu78d9');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 1575412235, '2022-04-18 00:53:20+00:00', 'tu0', '2020-06-29 02:04:50+00:00', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', 638024588, -688098735, 1784916884, 37673509, 834709651, 'f8jswwl');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -683007527, '2020-05-02 02:12:13+00:00', 'x7afu5w1of77', '2022-01-27 19:59:15+00:00', 'o72ctdc', 'mfg62', '0v', 820970595, 1421303999, -1488156735, -1858644047, -1180042408, '78507cvt');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, -1719383707, '2020-12-28 23:17:24+00:00', '2mnajjla3o', '2021-06-04 07:47:26+00:00', '8uttmu', 'ne578lfv', 'yz7zzbe8yvk', 1043710187, 318331233, -233617564, 79330142, 1735561423, '58b4pmaus3a');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, -1418927432, '2025-06-29 01:47:27+00:00', '521gwnlas6', '2025-03-08 07:37:26+00:00', 'lb', 'eowi', '1z5', 1557188093, 548968280, -1552469358, 7342822, -1034034171, 'lyotow');

-- Inserting into table: comments --
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (1, 1, 902887186, 'qrofqyp5s5b', '2020-03-11 14:09:37+00:00', 1, '02eu');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (0, 0, -1672720816, '8j', '2022-05-28 16:44:30+00:00', -1, 'wlq7xb');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483646, 0, -163600466, 'n8', '2025-01-28 02:00:27+00:00', 1, 'c68x8vacx7');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483645, 0, 76996700, 'o72ctdc', '2022-08-05 18:12:12+00:00', 1, 'mfg62g0v5q8q');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483644, 0, -241848752, '8507cvtjp', '2025-12-22 07:46:37+00:00', 1, 'tg6bn');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483643, 0, 1944978593, 'bfkfoacd', '2023-07-08 08:00:15+00:00', 0, '7z2zezjo7wg');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483642, 1, -1245584612, 'xfo', '2020-09-13 06:13:20+00:00', 1, 'szdo2z');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483641, 1, -366775518, '2odwcl5a', '2025-04-19 10:34:51+00:00', -1, 'msorlwyngc');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483640, 1, 681061317, 'iz', '2020-11-27 04:53:28+00:00', 0, 'k1yoeyo6l0h');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483639, 1, 1294064538, 'uzkb52', '2023-09-14 18:35:43+00:00', -1, 'wn');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483638, 1, 1468640756, 'boeowii1z5nx', '2021-03-06 10:06:33+00:00', 1, '66');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483637, 0, 412199481, 'tow9oaawg96a', '2022-03-05 18:43:06+00:00', -1, '0');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483636, 0, -1216952047, '39tajz9', '2022-08-02 17:02:31+00:00', 0, '8');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (2, 4, 902887186, 'qrofqyp5s5b', '2020-03-11 14:09:37+00:00', -1, '02eu');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3, 5, -1052964641, 'qcx5', '2025-05-27 16:57:17+00:00', 1, 'nc');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (4, 6, 710458518, 'sj3ayxp1q430', '2023-08-17 20:15:35+00:00', 4, 'jh3den8c68');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (5, 7, -1212676731, 'm5k', '2024-03-11 05:11:39+00:00', 5, 'qs27p2r94');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (6, 8, -499913447, 'yo', '2024-05-17 09:41:22+00:00', 5, 'l0hdt6fuqyx');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (7, 9, 2012400150, '9yfk7qk162n', '2020-12-13 20:46:34+00:00', 4, '55y3dohvu06d');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T2.Id) FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId INNER JOIN comments AS T3 ON T3.PostId = T2.Id ORDER BY T1.CreationDate DESC, T1.id NULLS LAST, T2.id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
(19,)
*/

-- Prediction Query
SELECT (SELECT COUNT(Id) FROM posts WHERE OwnerUserId = (SELECT T1.Id FROM users AS T1 WHERE T1.Id IN (SELECT OwnerUserId FROM posts UNION SELECT UserId FROM comments) ORDER BY T1.CreationDate DESC, T1.id NULLS LAST LIMIT 1)), (SELECT COUNT(Id) FROM comments WHERE UserId = (SELECT T1.Id FROM users AS T1 WHERE T1.Id IN (SELECT OwnerUserId FROM posts UNION SELECT UserId FROM comments) ORDER BY T1.CreationDate DESC, T1.id NULLS LAST LIMIT 1));

/*
Prediction Result:
(1, 0)
*/