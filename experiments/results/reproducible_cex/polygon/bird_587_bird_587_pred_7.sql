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
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (36, 72, 'humor39', 39);
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (35, 72, 'humor39', 39);
INSERT INTO "comments" ("id", "postid", "userid", "score", "text", "creationdate", "userdisplayname") VALUES (38, 39, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "comments" ("id", "postid", "userid", "score", "text", "creationdate", "userdisplayname") VALUES (37, 39, NULL, NULL, 'humor55', NULL, NULL);
INSERT INTO "postHistory" ("id", "postid", "userid", "posthistorytypeid", "revisionguid", "creationdate", "text", "comment", "userdisplayname") VALUES (34, 39, 71, 39, 'humor39', 39, 'humor39', 'humor39', 'humor39');
INSERT INTO "postHistory" ("id", "postid", "userid", "posthistorytypeid", "revisionguid", "creationdate", "text", "comment", "userdisplayname") VALUES (33, NULL, NULL, 39, 'humor39', 39, 'humor39', 'humor39', 'humor39');
INSERT INTO "postLinks" ("id", "postid", "relatedpostid", "creationdate", "linktypeid") VALUES (43, 45, 39, 39, 39);
INSERT INTO "postLinks" ("id", "postid", "relatedpostid", "creationdate", "linktypeid") VALUES (42, 45, 39, 39, 39);
INSERT INTO "posts" ("id", "lasteditoruserid", "owneruserid", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (45, 72, 72, 39, 39, 39, 39, 39, 'humor39', 39, 'humor39', NULL, 39, 39, 39, 39, 39, 39, 39, 'humor39', 'humor39');
INSERT INTO "posts" ("id", "lasteditoruserid", "owneruserid", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (39, 71, 72, 73, 74, 75, 76, 0, 'humor77', NULL, 'humor79', 'humor', NULL, 81, 82, 83, 84, 85, 86, 'humor87', '<humor>88');
INSERT INTO "tags" ("id", "excerptpostid", "tagname", "count", "wikipostid") VALUES (89, 39, 'humor', 90, 91);
INSERT INTO "tags" ("id", "excerptpostid", "tagname", "count", "wikipostid") VALUES (44, 45, 'humor', 69, 70);
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (72, 39, 39, 'humor39', 39, 'humor39', 'humor39', 'humor39', 39, 39, 39, 39, 39, 'humor39');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (71, 39, 39, 'humor39', 39, 'humor39', 'humor39', 'humor39', 39, 39, 39, 39, 39, 'humor39');
INSERT INTO "votes" ("id", "postid", "userid", "votetypeid", "creationdate", "bountyamount") VALUES (39, 39, 71, 39, '1000-02-09', 39);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T2.ViewCount), T2.Title, T1.Text FROM comments AS T1 INNER JOIN posts AS T2 ON T1.Id = T1.PostId WHERE T2.Tags = '<humor>';

/*
Gold Result:
(None, None, None)
*/

-- Prediction Query
SELECT AVG(posts.ViewCount) AS AverageViewCount, posts.Title, comments.Text FROM posts INNER JOIN tags ON posts.Tags = tags.TagName LEFT JOIN comments ON posts.Id = comments.PostId WHERE tags.TagName = 'humor' GROUP BY posts.Title, comments.Text;

/*
Prediction Result:
(0.0, 'humor79', None)
(0.0, 'humor79', 'humor55')
*/