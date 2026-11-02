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
-- DATASET 1
INSERT INTO users (Id, Reputation, DisplayName, AccountId) VALUES (10, 500, 'Daniel Vassallo', 1000);
INSERT INTO users (Id, Reputation, DisplayName, AccountId) VALUES (20, 300, 'John Doe', 2000);
INSERT INTO posts (Id, PostTypeId, OwnerUserId, LastEditorUserId, Score, Title) VALUES (50, 1, 10, 20, 5, 'Daniel Post');
INSERT INTO posts (Id, PostTypeId, OwnerUserId, LastEditorUserId, Score, Title) VALUES (51, 1, 20, 10, 3, 'John Post');
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, UserId, Text, Comment, UserDisplayName) VALUES (101, 1, 50, 10, 'Initial Title', 'Created', 'Daniel Vassallo');
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, UserId, Text, Comment, UserDisplayName) VALUES (102, 2, 50, 10, 'Initial Body', 'Created body', 'Daniel Vassallo');
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, UserId, Text, Comment, UserDisplayName) VALUES (103, 5, 51, 10, 'Edited Body', 'Fixed typo', 'Daniel Vassallo');
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, UserId, Text, Comment, UserDisplayName) VALUES (104, 5, 50, 20, 'John Edit', 'Updated tags', 'John Doe');
INSERT INTO comments (Id, PostId, Score, Text, UserId, UserDisplayName) VALUES (1, 50, 1, 'Nice post', 10, 'Daniel Vassallo');
INSERT INTO comments (Id, PostId, Score, Text, UserId, UserDisplayName) VALUES (2, 51, 2, 'Another comment', 10, 'Daniel Vassallo');
INSERT INTO badges (Id, UserId, Name) VALUES (1, 10, 'Editor');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.Id) FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId WHERE T1.DisplayName = 'Daniel Vassallo';

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT("posts"."id") FROM "posts" INNER JOIN "users" ON "posts"."owneruserid" = "users"."id" WHERE "users"."displayname" = 'Daniel Vassallo';

/*
Prediction Result:
(1,)
*/