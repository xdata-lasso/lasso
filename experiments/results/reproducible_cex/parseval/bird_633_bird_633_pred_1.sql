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

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483647, 1178000634, 1836127587, '2023-06-28 05:47:44+00:00', 836513442, 176555546, 'gd', -2147483647, '2023-11-06 04:09:03+00:00', 'vy9uxj4', 'wb', -1929953647, 1581736075, -261132974, -2147483647, '2021-09-30 11:37:26+00:00', '2020-07-01 12:41:54+00:00', -1052964641, '2021-10-14 08:16:37+00:00', 'cx5hn', 'p');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-1, -761353513, 362376128, '2024-12-23 03:48:38+00:00', 618058035, 1553368934, 'e578', 4, '2021-06-23 03:34:31+00:00', 'vy', '7zzbe8y', 1, -705922211, 1043710187, -2147483647, '2024-11-18 17:17:10+00:00', '2024-02-10 01:00:46+00:00', -233617564, '2024-11-20 13:19:41+00:00', 'sx58b4pma', 'us3auvmkrpdj');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, 989018473, -55494714, '2020-12-08 09:40:56+00:00', 101754718, 628082526, '9n0jxfofwsz', 5, '2020-06-20 19:03:43+00:00', '2zob', '0', 375841374, -1449226553, -225238282, 4, '2020-06-28 23:31:51+00:00', '2023-01-14 08:25:47+00:00', 440115543, '2025-04-19 10:34:51+00:00', 'msorlwyngc', 'dj9erhi');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, -499913447, -360096930, '2020-05-28 05:20:14+00:00', 1435223075, 1617348603, 'yxuzk', 5, '2020-03-04 20:06:24+00:00', '521gwnlas6e', 'lboeowii1z5', 1557188093, 548968280, -1552469358, -2147483643, '2024-05-19 10:57:10+00:00', '2024-04-07 18:10:54+00:00', -251205568, '2023-10-18 11:51:31+00:00', 'lyotow', 'oaawg96aq');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (0, -1575692857, 1570917601, '2025-10-15 06:35:43+00:00', -1670335771, 1862728578, 't1pqomiztvb6', -2147483643, '2021-09-01 18:50:29+00:00', 'iz78aqql', 'd8ftb8', 1, 1183069552, -1057355067, 6, '2022-04-07 02:26:31+00:00', '2020-08-05 12:55:21+00:00', 316163741, '2020-08-10 19:57:16+00:00', 'uuwsj8kjh8', 'wpxlvris');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, -1437333179, -921145356, '2023-01-16 20:10:41+00:00', -1022641847, -1726781632, '9n8', -2147483641, '2020-04-30 23:22:06+00:00', 'pgu7vfe4', 'hria2ypuzhs', 700293388, 906324270, 1908028688, 2, '2020-03-08 22:40:47+00:00', '2022-01-03 02:42:55+00:00', 13244799, '2022-09-23 20:24:07+00:00', 'hvdlttilbnpr', 'dpos');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'slashnick', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483647, -1666765085, '2025-11-19 11:50:18+00:00', 'slashnick', '2024-06-06 15:16:07+00:00', 'klex14ji', '7zwau2dwyr', '13pyu', 176380444, -977635379, 1661181156, -1372125820, -2031361952, 'p5qi2rk');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 564390026, '2024-11-03 18:41:48+00:00', 'slashnick', '2024-05-16 22:03:30+00:00', 'ijja', '5dh', 'ogrgjd8y', 1129658414, 1250290042, -1717646459, -1696173285, 710458518, 'sj3ayxp1q430');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, 1923912467, '2024-11-10 21:13:22+00:00', 'slashnick', '2025-04-02 22:54:49+00:00', 'jh3den8c68', '8vacx7', 'f', -47052816, 645287482, 765724008, -1099855564, 87529806, 'ctdctmfg62g0');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, -1488156735, '2020-07-27 22:34:35+00:00', 'io22785', '2023-06-27 00:27:42+00:00', '7cvtjpttg6b', 'ou5z', '36c', 1722106924, -2072838897, -1173368267, 382831862, -406331049, 'ezjo7wg');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483643, -1405314653, '2025-11-16 21:50:04+00:00', 'slashnick', '2024-03-22 11:27:27+00:00', 'npi', '5k58', 's27p2', 1497321728, -95808609, -244633520, 418247369, -1524425594, 'a3o');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483642, 1595632888, '2025-09-12 02:45:33+00:00', 'slashnick', '2021-08-17 12:22:09+00:00', 'io1', 'ri2hy08ft', '6ewt', -1051623642, 2013745856, 917362079, -1312038093, 687330820, 'mfx7h33p');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483641, 594760660, '2023-09-27 08:54:55+00:00', 'slashnick', '2021-10-14 23:04:20+00:00', 'p490xdmsqt', 'el', 'u', 422046500, -1750715330, 277649518, 908468929, 1149620614, 'jq1');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483640, -1340460158, '2024-09-04 04:16:15+00:00', 'slashnick', '2024-07-01 17:30:12+00:00', 'aqz2o20pj6d', 'dlysu6iphd', 'u2g', 1352531282, -269868995, 580887132, 1188674483, -299585625, '2');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

-- Inserting into table: posthistory --
INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (1, -443340271, 1, 'uo4nrqrofqy', '2022-01-22 16:14:13+00:00', 1, 's5bbp02e', 'tliqa1', 'ryytoo3');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (2, -988981234, 1, 'u0dz7', '2024-09-12 11:18:07+00:00', 1, 'fjgq8n2f3dq', '0gcb98', 'zk3z');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (3, 1686459626, 1, 'lyr', '2021-06-12 16:42:05+00:00', 1, 'n6vck6ah0f', 'jswwlq7xb', '72fxa7ryfd');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483645, 1248858185, 1, '5', '2023-03-18 12:07:22+00:00', 6, 'xcmr0', 'ztdg', '5i3');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483644, -2061634386, 6, 'bindz', '2023-12-20 17:13:08+00:00', 1, 'tajz9td8n', '5wcgumbc3td', 'u6bd0w9603');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483643, 920097188, 1, '1rxe9y', '2020-09-21 12:30:27+00:00', 6, '7qk', '162nh55y3d', 'ohvu06dza3');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483642, -1154091048, 6, 'j', '2024-08-04 01:35:33+00:00', 1, 'h5knz', 'ys7dyyd1jmg', 'jach8qta8y3');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483641, 339193890, 1, 'ygmayq3q', '2024-12-02 03:34:47+00:00', 6, 'dpuap96rntdq', 'hm5wl', 'c7d');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483640, -459075802, 6, 'aqt', '2024-12-16 15:00:57+00:00', 1, 'ncgc8s3b7v8', 'kwdmdbdht', 'j47nxar50');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483639, -2121944911, 1, 'xdpunmw', '2020-09-21 03:33:04+00:00', 6, 'xqrlaw', '014', '5dqts');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (-2147483638, 1388661799, 6, '1pa', '2022-10-27 16:29:32+00:00', 1, 'v', 'wnyqrouirlrp', 'ouit63xyfvmj');

INSERT INTO "posthistory" ("id", "posthistorytypeid", "postid", "revisionguid", "creationdate", "userid", "text", "comment", "userdisplayname") VALUES (4, -1576219117, 2, '5u', '2021-11-09 05:42:50+00:00', 2, '6klfa9', '00t5c4e', 'cigce376nium');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.PostId FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId INNER JOIN posts AS T3 ON T2.PostId = T3.Id WHERE T1.DisplayName = 'slashnick' ORDER BY T3.AnswerCount DESC, T1.id NULLS LAST, T2.id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT Id FROM posts WHERE OwnerUserId = (SELECT Id FROM users WHERE DisplayName = 'slashnick') ORDER BY AnswerCount DESC, posts.id NULLS LAST LIMIT 1;

/*
Prediction Result:
(-2147483647,)
*/