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
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (23, 64, NULL, 36);
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (61, 65, NULL, NULL);
INSERT INTO "comments" ("id", "postid", "userid", "score", "text", "creationdate", "userdisplayname") VALUES (25, 21, 65, 65, 'Emmett65', 65, 'Emmett65');
INSERT INTO "comments" ("id", "postid", "userid", "score", "text", "creationdate", "userdisplayname") VALUES (24, 21, 65, 65, 'Emmett65', 65, 'Emmett65');
INSERT INTO "postHistory" ("id", "postid", "userid", "posthistorytypeid", "revisionguid", "creationdate", "text", "comment", "userdisplayname") VALUES (20, 21, 65, 65, 'Emmett65', 65, 'Emmett65', 'Emmett65', 'Emmett65');
INSERT INTO "postHistory" ("id", "postid", "userid", "posthistorytypeid", "revisionguid", "creationdate", "text", "comment", "userdisplayname") VALUES (19, 21, 65, 65, 'Emmett65', 65, 'Emmett65', 'Emmett65', 'Emmett65');
INSERT INTO "postLinks" ("id", "postid", "relatedpostid", "creationdate", "linktypeid") VALUES (27, 21, 21, 65, 65);
INSERT INTO "postLinks" ("id", "postid", "relatedpostid", "creationdate", "linktypeid") VALUES (26, 21, 21, 65, 65);
INSERT INTO "posts" ("id", "lasteditoruserid", "owneruserid", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (22, 65, 65, 65, 65, 65, 65, 65, 'Emmett65', 65, 'Emmett65', 'Emmett65', 65, 65, 65, 65, 65, 65, 65, 'Emmett65', 'Emmett65');
INSERT INTO "posts" ("id", "lasteditoruserid", "owneruserid", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (21, 65, 65, 65, 65, 65, 65, 65, 'Emmett65', 65, 'Emmett65', 'Emmett65', 65, 65, 65, 65, 65, 65, 65, 'Emmett65', 'Emmett65');
INSERT INTO "tags" ("id", "excerptpostid", "tagname", "count", "wikipostid") VALUES (29, 21, 'Emmett65', 65, 65);
INSERT INTO "tags" ("id", "excerptpostid", "tagname", "count", "wikipostid") VALUES (28, 21, 'Emmett65', 65, 65);
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (64, 37, 38, 'Emmett', 39, 'Emmett40', 'Emmett41', 'Emmett42', 43, 44, 45, 46, 47, 'Emmett48');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (65, 49, 50, 'Emmett', 51, 'Emmett52', 'Emmett53', 'Emmett54', 55, 56, 57, 58, 59, 'Emmett60');
INSERT INTO "votes" ("id", "postid", "userid", "votetypeid", "creationdate", "bountyamount") VALUES (31, 21, 65, 65, '1000-03-07', 65);
INSERT INTO "votes" ("id", "postid", "userid", "votetypeid", "creationdate", "bountyamount") VALUES (30, 21, 65, 65, '1000-03-07', 65);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Name FROM badges AS T1 INNER JOIN users AS T2 ON T1.UserId = T2.Id WHERE T2.DisplayName = 'Emmett' ORDER BY T1.Date DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT Name FROM badges WHERE UserId = (SELECT Id FROM users WHERE DisplayName = 'Emmett') ORDER BY Date DESC, badges.id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/