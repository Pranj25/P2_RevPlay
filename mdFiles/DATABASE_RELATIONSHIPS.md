# RevPlay Database Relationships

## Entity Relationship Diagram (Parent-Child Relationships)

### Overview
This document describes all parent-child relationships in the RevPlay database schema.

---

## 1. Users → Artists (One-to-One)

**Parent**: `users`  
**Child**: `artists`  
**Relationship**: One user can be one artist

```
users (1) ──────── (1) artists
  └─ id                  └─ user_id (FK)
```

**Foreign Key**: `artists.user_id` → `users.id`  
**On Delete**: CASCADE (deleting a user deletes their artist profile)

**Example**:
- User "john@example.com" → Artist "John Doe Music"

---

## 2. Artists → Albums (One-to-Many)

**Parent**: `artists`  
**Child**: `albums`  
**Relationship**: One artist can have many albums

```
artists (1) ──────── (N) albums
  └─ id                    └─ artist_id (FK)
```

**Foreign Key**: `albums.artist_id` → `artists.id`  
**On Delete**: CASCADE (deleting an artist deletes all their albums)

**Example**:
- Artist "John Doe Music" → Albums: "First Album", "Second Album", "Greatest Hits"

---

## 3. Albums → Songs (One-to-Many)

**Parent**: `albums`  
**Child**: `songs`  
**Relationship**: One album can have many songs

```
albums (1) ──────── (N) songs
  └─ id                   └─ album_id (FK)
```

**Foreign Key**: `songs.album_id` → `albums.id`  
**On Delete**: SET NULL (deleting an album keeps songs but removes album reference)

**Example**:
- Album "First Album" → Songs: "Track 1", "Track 2", "Track 3"

---

## 4. Artists → Songs (One-to-Many)

**Parent**: `artists`  
**Child**: `songs`  
**Relationship**: One artist can have many songs

```
artists (1) ──────── (N) songs
  └─ id                    └─ artist_id (FK)
```

**Foreign Key**: `songs.artist_id` → `artists.id`  
**On Delete**: CASCADE (deleting an artist deletes all their songs)

**Example**:
- Artist "John Doe Music" → Songs: "Song A", "Song B", "Song C"

---

## 5. Users → Favorites (One-to-Many)

**Parent**: `users`  
**Child**: `favorites`  
**Relationship**: One user can have many favorite songs

```
users (1) ──────── (N) favorites
  └─ id                   └─ user_id (FK)
```

**Foreign Key**: `favorites.user_id` → `users.id`  
**On Delete**: CASCADE (deleting a user deletes all their favorites)

**Example**:
- User "john@example.com" → Favorites: Song 1, Song 5, Song 10

---

## 6. Songs → Favorites (One-to-Many)

**Parent**: `songs`  
**Child**: `favorites`  
**Relationship**: One song can be favorited by many users

```
songs (1) ──────── (N) favorites
  └─ id                   └─ song_id (FK)
```

**Foreign Key**: `favorites.song_id` → `songs.id`  
**On Delete**: CASCADE (deleting a song deletes all favorites of that song)

**Example**:
- Song "Track 1" → Favorited by: User A, User B, User C

---

## 7. Users → Playlists (One-to-Many)

**Parent**: `users`  
**Child**: `playlists`  
**Relationship**: One user can create many playlists

```
users (1) ──────── (N) playlists
  └─ id                   └─ user_id (FK)
```

**Foreign Key**: `playlists.user_id` → `users.id`  
**On Delete**: CASCADE (deleting a user deletes all their playlists)

**Example**:
- User "john@example.com" → Playlists: "Workout Mix", "Chill Vibes", "Road Trip"

---

## 8. Users → Playlist Followers (One-to-Many)

**Parent**: `users`  
**Child**: `playlist_followers`  
**Relationship**: One user can follow many playlists

```
users (1) ──────── (N) playlist_followers
  └─ id                   └─ user_id (FK)
```

**Foreign Key**: `playlist_followers.user_id` → `users.id`  
**On Delete**: CASCADE (deleting a user removes all their playlist follows)

**Example**:
- User "john@example.com" → Following: Playlist 1, Playlist 5, Playlist 8

---

## 9. Playlists → Playlist Followers (One-to-Many)

**Parent**: `playlists`  
**Child**: `playlist_followers`  
**Relationship**: One playlist can be followed by many users

```
playlists (1) ──────── (N) playlist_followers
  └─ id                      └─ playlist_id (FK)
```

**Foreign Key**: `playlist_followers.playlist_id` → `playlists.id`  
**On Delete**: CASCADE (deleting a playlist removes all followers)

**Example**:
- Playlist "Workout Mix" → Followers: User A, User B, User C

---

## 10. Users → Listening History (One-to-Many)

**Parent**: `users`  
**Child**: `listening_history`  
**Relationship**: One user can have many listening history entries

```
users (1) ──────── (N) listening_history
  └─ id                   └─ user_id (FK)
```

**Foreign Key**: `listening_history.user_id` → `users.id`  
**On Delete**: CASCADE (deleting a user deletes their listening history)

**Example**:
- User "john@example.com" → History: Song 1 (2024-01-01), Song 2 (2024-01-02)

---

## 11. Songs → Listening History (One-to-Many)

**Parent**: `songs`  
**Child**: `listening_history`  
**Relationship**: One song can appear in many listening histories

```
songs (1) ──────── (N) listening_history
  └─ id                   └─ song_id (FK)
```

**Foreign Key**: `listening_history.song_id` → `songs.id`  
**On Delete**: CASCADE (deleting a song removes it from all listening histories)

**Example**:
- Song "Track 1" → Played by: User A (10 times), User B (5 times)

---

## Complete Relationship Hierarchy

```
users
├── artists (1:1)
│   ├── albums (1:N)
│   │   └── songs (1:N)
│   └── songs (1:N)
├── favorites (1:N)
│   └── songs (N:1)
├── playlists (1:N)
│   └── playlist_followers (1:N)
└── listening_history (1:N)
    └── songs (N:1)
```

---

## Many-to-Many Relationships

### Users ↔ Songs (via Favorites)
- A user can favorite many songs
- A song can be favorited by many users
- Junction table: `favorites`

### Users ↔ Playlists (via Playlist Followers)
- A user can follow many playlists
- A playlist can be followed by many users
- Junction table: `playlist_followers`

### Users ↔ Songs (via Listening History)
- A user can listen to many songs
- A song can be listened to by many users
- Junction table: `listening_history`

---

## Cascade Delete Behavior

| Parent Table | Child Table | On Delete Action |
|--------------|-------------|------------------|
| users | artists | CASCADE |
| users | favorites | CASCADE |
| users | playlists | CASCADE |
| users | playlist_followers | CASCADE |
| users | listening_history | CASCADE |
| artists | albums | CASCADE |
| artists | songs | CASCADE |
| albums | songs | SET NULL |
| songs | favorites | CASCADE |
| songs | listening_history | CASCADE |
| playlists | playlist_followers | CASCADE |

---

## Key Points

1. **User Deletion**: Deleting a user cascades to:
   - Their artist profile
   - All their favorites
   - All their playlists
   - All their playlist follows
   - All their listening history

2. **Artist Deletion**: Deleting an artist cascades to:
   - All their albums
   - All their songs

3. **Album Deletion**: Deleting an album:
   - Sets album_id to NULL in songs (songs remain but lose album reference)

4. **Song Deletion**: Deleting a song cascades to:
   - All favorites of that song
   - All listening history entries of that song

5. **Playlist Deletion**: Deleting a playlist cascades to:
   - All followers of that playlist

---

## Database Integrity Rules

- Every artist must have a user account
- Every song must have an artist
- Every album must have an artist
- Songs can exist without an album
- Favorites require both a user and a song
- Playlist followers require both a user and a playlist
- Listening history requires both a user and a song
