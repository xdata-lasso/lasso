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
-- Tests Join Path Confusion: Distinguishes joining via postHistory vs joining directly to posts.OwnerUserId or posts.LastEditorUserId.
-- Also tests DISTINCT vs ALL by having multiple postHistory records for the same post by Mark Meckes.
INSERT INTO users (Id, DisplayName, Reputation, Views, UpVotes, DownVotes, Age) VALUES (1, 'Mark Meckes', 100, 10, 5, 1, 30);
INSERT INTO users (Id, DisplayName, Reputation, Views, UpVotes, DownVotes, Age) VALUES (2, 'Alice Smith', 200, 20, 10, 2, 25);
-- Post 101: Owned/Edited by Alice, but in postHistory by Mark Meckes (Should be returned twice).
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, CommentCount, Tags, Title, Body, Score, ViewCount, AnswerCount, FavoriteCount) VALUES (101, 2, 2, 0, '<math><topology>', 'Title 101', 'Body 101', 5, 100, 1, 0);
-- Post 102: Owned and Edited by Mark Meckes, but in postHistory only by Alice (Should NOT be returned).
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, CommentCount, Tags, Title, Body, Score, ViewCount, AnswerCount, FavoriteCount) VALUES (102, 1, 1, 0, '<wrong-direct-join>', 'Title 102', 'Body 102', 3, 50, 0, 1);
-- Post 103: Owned by Mark Meckes, no postHistory at all (Should NOT be returned).
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, CommentCount, Tags, Title, Body, Score, ViewCount, AnswerCount, FavoriteCount) VALUES (103, 1, 1, 0, '<wrong-no-history>', 'Title 103', 'Body 103', 1, 10, 0, 0);
INSERT INTO postHistory (Id, PostId, UserId, PostHistoryTypeId, Text, Comment, UserDisplayName) VALUES (1001, 101, 1, 1, 'History 1', 'Comment 1', 'Alice Smith');
INSERT INTO postHistory (Id, PostId, UserId, PostHistoryTypeId, Text, Comment, UserDisplayName) VALUES (1002, 101, 1, 2, 'History 2', 'Comment 2', 'Alice Smith');
INSERT INTO postHistory (Id, PostId, UserId, PostHistoryTypeId, Text, Comment, UserDisplayName) VALUES (1003, 102, 2, 1, 'History 3', 'Comment 3', 'Mark Meckes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.Tags FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId INNER JOIN posts AS T3 ON T3.Id = T2.PostId WHERE T1.DisplayName = 'Mark Meckes' AND T3.CommentCount = 0;

/*
Gold Result:
('<math><topology>',)
('<math><topology>',)
*/

-- Prediction Query
SELECT T1.Tags FROM posts AS T1 INNER JOIN users AS T2 ON T1.OwnerUserId = T2.Id WHERE T2.DisplayName = 'Mark Meckes' AND T1.CommentCount = 0;

/*
Prediction Result:
('<wrong-direct-join>',)
('<wrong-no-history>',)
*/