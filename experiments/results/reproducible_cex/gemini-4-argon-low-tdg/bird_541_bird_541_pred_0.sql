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
INSERT INTO users (Id, DisplayName, Reputation, Views, UpVotes) VALUES (1, 'User_High_Rep_Editor', 9999, 500, 100);
INSERT INTO users (Id, DisplayName, Reputation, Views, UpVotes) VALUES (2, 'User_Target_Owner', 10, 5, 1);
INSERT INTO users (Id, DisplayName, Reputation, Views, UpVotes) VALUES (3, 'User_Low_Fav_Owner', 50, 20, 5);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, FavoriteCount, Score, ViewCount, AnswerCount, CommentCount, OwnerDisplayName, LastEditorDisplayName, Title) VALUES (10, 3, 1, 5, 1000, 5000, 50, 50, 'Wrong_Post_Owner_1', 'Editor_1', 'Post Title 1');
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, FavoriteCount, Score, ViewCount, AnswerCount, CommentCount, OwnerDisplayName, LastEditorDisplayName, Title) VALUES (20, 2, 1, 50, 1, 10, 0, 0, 'Wrong_Post_Owner_2', 'Editor_2', 'Post Title 2');
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, FavoriteCount, Score, ViewCount, AnswerCount, CommentCount, OwnerDisplayName, LastEditorDisplayName, Title) VALUES (30, NULL, 1, 999, 500, 1000, 10, 10, 'Orphan_Owner_Max_Fav', 'Editor_3', 'Post Title 3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.DisplayName FROM posts AS T1 INNER JOIN users AS T2 ON T1.OwnerUserId = T2.Id ORDER BY T1.FavoriteCount DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
('User_Target_Owner',)
*/

-- Prediction Query
SELECT users.DisplayName FROM users INNER JOIN posts ON users.Id = posts.OwnerUserId WHERE posts.FavoriteCount = (SELECT MAX(FavoriteCount) FROM posts);

/*
Prediction Result:
*/