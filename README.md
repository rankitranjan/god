# God - The Game of Dice

* Programming Languages: Ruby
* Test Cases: Rspec

## How to run

  * To start the game, use the terminal, go to 'God/lib' and run  ```ruby God-play.rb``` and follow the instructions on screen.
  * To run test ```rspec spec```


## Data Model

```
User (player)
   - id
   - name
   - email
   - password
   - contact
```

index on id and
         email col.

```
Game (game info)

 - id
 - name
 - some setings
```

index on id col.

```
GameRoom

  - id (int NOT NULL AUTO_INCREMENT)
  - game_id: Game (game_id)
  - created_by: User(user_id)
  - timestamp (datetime)
  - status enum(start, in_play, done)
```

index on id col.

```
GameRoomPlayer (joinsbetwen GameRoom and User model)

  - id (int NOT NULL AUTO_INCREMENT)
  - user_id User(user_id)
  - game_room_id GameRoom(game_room_id)
  - status enum(in_play, finished)
  - score (int)
  - order (int)
  - rank (int)
  - round_and_point [{ round: 1, point: 2 }, { round: 2, point: 4 }, {} ...]
  - timestamp
```

index on id col.
index on game_room_player, [:game_room_id, :user_id], unique: true


## Small Description

* We will be having a User (player) model which handles the user registration/login process.
* Game model is for storing the game infos and some generic settings.
* GameRoom model is a important model which will store info about on going game. (Details of who started the game, status and etc.))
* GameRoomPlayer is a join between user and game room model which will store data related to each and every round such as status, score, order, rank, round_and_point etc. Here we will append a new object({ round: 1, point: 2 }) to an array of each and every dice roll.


## API's:

Api: Get /gameRoom
Header: user_token

```
{
    - uuid
    - game_id
    - created_by
    - timestamp
    - status
}
```

```
Api: Post /joinRoom/:uuid
Header: user_token

{
   gameInfo: {}
   players: []
}
```


```
Api: Get /gameRoom/:uuid

Header: user_token
{
    gameInfo: {}
    GameRoomPlayer: {}
}

```

```
Api: Get /gameRoom/:uuid/histories

Header: user_token

[
    {
        gameInfo: {}
        GameRoomPlayer: {}
    },
    {
        gameInfo: {}
        GameRoomPlayer: {}
    }, 
    {},
    ...
    ..

]
```

```
Api: Get /gameRoom/:uuid/status

Header: user_token
{
    gameInfo: {}
}
```



