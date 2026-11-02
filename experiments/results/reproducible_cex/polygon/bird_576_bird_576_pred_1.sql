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
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (26, 67, 'thank you user93!23', 23);
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (25, 50, 'thank you user93!23', 23);
INSERT INTO "comments" ("id", "postid", "userid", "score", "text", "creationdate", "userdisplayname") VALUES (49, 23, 50, NULL, 'thank you user93!', NULL, 'thank you user93!53');
INSERT INTO "comments" ("id", "postid", "userid", "score", "text", "creationdate", "userdisplayname") VALUES (66, 23, 67, 68, 'thank you user93!', 69, NULL);
INSERT INTO "postHistory" ("id", "postid", "userid", "posthistorytypeid", "revisionguid", "creationdate", "text", "comment", "userdisplayname") VALUES (22, 23, 67, 23, 'thank you user93!23', 23, 'thank you user93!23', 'thank you user93!23', 'thank you user93!23');
INSERT INTO "postHistory" ("id", "postid", "userid", "posthistorytypeid", "revisionguid", "creationdate", "text", "comment", "userdisplayname") VALUES (21, 23, 67, 23, 'thank you user93!23', 23, 'thank you user93!23', 'thank you user93!23', 'thank you user93!23');
INSERT INTO "postLinks" ("id", "postid", "relatedpostid", "creationdate", "linktypeid") VALUES (28, 23, 23, 23, 23);
INSERT INTO "postLinks" ("id", "postid", "relatedpostid", "creationdate", "linktypeid") VALUES (27, 23, 23, 23, 23);
INSERT INTO "posts" ("id", "lasteditoruserid", "owneruserid", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (24, 50, 67, 23, 23, 23, 23, 23, 'thank you user93!23', 23, 'thank you user93!23', 'thank you user93!23', 23, 23, 23, 23, 23, 23, 23, 'thank you user93!23', 'thank you user93!23');
INSERT INTO "posts" ("id", "lasteditoruserid", "owneruserid", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (23, 67, 67, 23, 23, 23, 23, 23, 'thank you user93!23', 23, 'thank you user93!23', 'thank you user93!23', 23, 23, 23, 23, 23, 23, 23, 'thank you user93!23', 'thank you user93!23');
INSERT INTO "tags" ("id", "excerptpostid", "tagname", "count", "wikipostid") VALUES (30, 23, 'thank you user93!23', 23, 23);
INSERT INTO "tags" ("id", "excerptpostid", "tagname", "count", "wikipostid") VALUES (29, 24, 'thank you user93!23', 23, 23);
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (50, 37, 38, NULL, 39, 'thank you user93!40', 'thank you user93!41', 'thank you user93!42', 43, 44, 45, 46, 47, 'thank you user93!48');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (67, 54, 55, NULL, 56, 'thank you user93!57', 'thank you user93!58', 'thank you user93!59', 60, 61, 62, 63, 64, 'thank you user93!65');
INSERT INTO "votes" ("id", "postid", "userid", "votetypeid", "creationdate", "bountyamount") VALUES (32, 23, 50, 23, '1000-01-24', 23);
INSERT INTO "votes" ("id", "postid", "userid", "votetypeid", "creationdate", "bountyamount") VALUES (31, 23, 67, 23, '1000-01-24', 23);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.DisplayName FROM users AS T1 INNER JOIN comments AS T2 ON T1.Id = T2.UserId WHERE T2.Text = 'thank you user93!';

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT UserDisplayName FROM comments WHERE Text = 'thank you user93!';

/*
Prediction Result:
('thank you user93!53',)
(None,)
*/