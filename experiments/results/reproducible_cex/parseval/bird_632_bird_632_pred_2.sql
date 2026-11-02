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
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (1, 1526238907, -1377057208, '2022-08-02 13:58:36+00:00', -1610064545, 429706943, 'rmdp', 1, '2021-12-08 15:32:00+00:00', 'siie5unw6k', 'fa9', 1620389964, 546571701, 947159877, 1, '2022-07-16 22:41:51+00:00', '2024-03-03 15:52:53+00:00', -1964997180, '2025-03-10 20:24:26+00:00', 'ce', '76nium52');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 834709651, -348113485, '2024-07-11 21:09:52+00:00', -1520489792, -658391922, 'q7x', 1, '2020-03-06 15:32:29+00:00', '72fxa7ryfd', 'z16ni', 2011234363, -1483100200, -7597509, 4, '2025-07-17 09:46:47+00:00', '2021-01-12 13:18:15+00:00', 1583472758, '2020-10-22 21:08:07+00:00', 'gjd8y', 't1afgog');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, -435350511, 1992637800, '2022-08-17 19:55:37+00:00', -1928431425, 1303877941, 'mfg62g0v5q8q', 1, '2020-06-16 16:03:52+00:00', 'jpe1io22785', '7cvtjpt', 453836040, 1467355421, -1171104889, 4, '2024-03-12 07:01:30+00:00', '2023-06-13 16:42:54+00:00', 1691780814, '2023-12-14 20:00:33+00:00', 'c4bfkfoac', '0');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'Harlan', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -1390245819, '2023-03-10 01:47:11+00:00', 'Harlan', '2023-08-25 07:55:29+00:00', 'ji7zwau2', 'dwyrq13pyu78', '9', 244829661, -1362461264, -904834265, -346339240, 1692174491, 'qi2rkf9v');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 556727997, '2024-02-28 14:45:41+00:00', 'pz0f8jegd', '2023-11-06 04:09:03+00:00', 'vy9uxj4', 'wb', 'v', 1581736075, -261132974, -1264842910, -1052964641, -1245682094, 'x');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -55602865, '2024-02-19 01:18:26+00:00', 'Harlan', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, 947159877, '2022-07-16 22:41:51+00:00', 'Harlan', '2024-03-03 15:52:53+00:00', '4', 'ecigce376n', 'um5', 742285925, -747753377, 902887186, -967741825, 775304493, 'qyp5s5bbp0');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, -977635379, '2021-03-27 18:00:10+00:00', 'Harlan', '2022-06-17 21:46:26+00:00', '0b4', 'p5qi2rk', '9v', 556727997, 1178000634, 1836127587, -1529584866, 1196308825, 'd21vy9uxj4hw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, -1454058168, '2023-05-15 04:44:08+00:00', 'Harlan', '2020-02-20 05:24:11+00:00', 'lyr', 'kn6vck6ah0f8', 'sww', -1388029300, -566887085, 602161869, 1350414441, 2094425101, '7');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, 1568069663, '2020-09-12 13:47:57+00:00', 'Harlan', '2020-11-06 22:27:04+00:00', 'grit', 'sj3ayxp1q430', 'jh3den8', 195720193, 1774087382, 1732258051, -1762140823, 1371234901, '1of77p');

-- Inserting into table: posthistory --
INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483648, -443340271, 1, 'uo4nrqrofqy', '2022-01-22 16:14:13+00:00', 1, 's5bbp02e', 'tliqa1', 'ryytoo3');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483647, 722884590, 1, 'hncprjtu0dz', '2024-06-08 14:05:00+00:00', 4, 'fjgq8n2f3', 'dqv0gcb98ozk', 'zbilyrkn');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483646, -946046410, 2, 'tsj3ayxp1q4', '2023-11-21 06:57:41+00:00', 1, '1jh3den', 'c68x8vacx', 'afu5w1of7');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483645, 304189298, 1, 'xd', '2024-02-20 16:52:17+00:00', 4, 'sxcmr0o', 'ztdgj5i3lq5l', 'pim5');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483644, 1615073310, 2, '7p2r94gth2m', '2021-10-18 07:51:02+00:00', 1, 'ajjla3okv8u', 'tmu2n', '57');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483643, -526633767, 1, 'zzbe8yvkv', '2024-11-18 17:17:10+00:00', 4, '2q7sx58b', 'pmaus3au', 'mkrpdj');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483642, -1674145149, 2, 'mo705a9n0', '2021-04-02 17:49:19+00:00', 1, 'fofwsz', 'o', '2zobb0q0k32o');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483641, 364043263, 1, 'sorlwyngc1', '2020-06-01 03:41:47+00:00', 4, 'j9erhizgk1', 'yoeyo6l0hdt6', 'uq');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483640, 450555855, 2, '1gwnlas6', '2025-03-08 07:37:26+00:00', 1, 'lb', 'eowi', '1z5');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (2, 287256667, 1, 'otow9oa', '2025-12-04 20:24:52+00:00', 1, 'awg96aqb0t', 'i', 'ndz39tajz9');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (3, -841516418, 1, 'n5wcgumbc', '2025-11-17 06:38:18+00:00', 1, '3tdu6bd0w9', '03vzxw1rx', '9y');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483637, 2013745856, 1, 'b', '2023-03-16 17:59:19+00:00', 1, 'mzn2mfx7h3', 'p6sto1cj', 'sh5knzys7');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483636, -1502591405, 1, 'h', '2024-07-16 00:46:06+00:00', 1, 'qta8y3a17v4y', 'ma', 'q3qdpua');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (4, -55602865, 1, 'swwqcgsk', '2024-11-14 12:35:58+00:00', 2, 'n8c4pgu7v', 'e4', 'hria2ypuzhs');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (5, 1019800248, 1, 'dlttil', '2020-03-11 00:23:16+00:00', 5, 'nprmdposii', '5u', 'w6kl');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (6, 743312762, 1, 'eutliqa11r', '2023-03-22 03:47:49+00:00', 6, 'ytoo3o9hl7', 'klex14ji', '7zwau2dwyr');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (7, -2050247126, 1, 'lph2gn', '2020-07-01 12:41:54+00:00', 7, 'wnqcx', '5hncprjtu0d', '79fjgq8');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (8, 1294666887, 1, 'fdrz16n', '2021-02-09 08:26:06+00:00', 8, 'jai', 'dh5ogrgj', '8');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (9, -435350511, 1, '72ctdctmfg62', '2020-10-18 11:14:36+00:00', 9, 'v5q8qdj', 'e1io', '278507cv');

-- Inserting into table: votes --
INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (-2147483648, 1, 226938182, '2022-02-06', 1, 1178636309);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (-2147483647, 1, 32204797, '2020-05-20', 4, 1784916884);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (-2147483646, 3, -406331049, '2024-05-26', 4, 641521863);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (-2147483645, 1, 1379859112, '2022-10-29', 1, 1817366143);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (-2147483644, 3, 1908593332, '2020-12-20', 4, 2123471885);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (-2147483643, 1, -609553675, '2023-11-16', 4, -55494714);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (-2147483642, 3, -613916489, '2022-01-03', 1, 895277769);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (-2147483641, 1, 778835680, '2024-06-14', 3, 1262491793);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (-2147483640, 3, 548968280, '2021-07-21', 1, -251205568);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (-2147483639, 1, 1968783602, '2025-12-07', 1, -1046720861);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (-2147483638, 1, 312804300, '2025-09-21', 4, -246257698);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (-2147483637, 1, 956819642, '2025-06-23', 1, 2105860871);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (-2147483636, 1, -1191116453, '2023-09-10', 3, -1934709172);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (-2147483635, 1, -154207334, '2023-01-25', 1, 2072023304);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (-2147483634, 1, -1580984044, '2024-09-27', 4, 769234989);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (-2147483633, 1, 168442149, '2023-06-25', 4, 2066302536);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (-2147483632, 1, -1853955201, '2023-07-03', 4, -1051623642);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (-2147483631, 1, 1328948152, '2020-08-02', 1, 357443379);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (-2147483630, 1, -845136979, '2022-11-19', 1, -951706262);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (2, 1, 906324270, '2020-05-06', 4, 2122220075);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (3, 1, 1038707349, '2024-07-24', 1, 546571701);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (4, 1, -1097120355, '2023-09-01', 4, 176380444);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (5, 1, -1255130038, '2021-01-01', 6, -1056308489);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (6, 1, 1129658414, '2023-06-17', 7, 600440952);

INSERT INTO "votes" ("id", "postid", "votetypeid", "creationdate", "userid", "bountyamount") VALUES (7, 1, -1523347137, '2023-06-01', 5, 453836040);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.Id) FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId INNER JOIN votes AS T3 ON T3.PostId = T2.PostId WHERE T1.DisplayName = 'Harlan';

/*
Gold Result:
(210,)
*/

-- Prediction Query
SELECT COUNT(Votes.Id) FROM users INNER JOIN votes ON users.Id = votes.UserId WHERE users.DisplayName = 'Harlan';

/*
Prediction Result:
(15,)
*/