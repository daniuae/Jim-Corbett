# Python OOP – Chess Tournament System
## Complete Python Features, Functionalities & Code Explanation

> **Source:** Low-Level Design (LLD) – Chess Tournament Player Management System  
> **Technology:** Python OOPs  
> **Assessment:** 4 Methods | 5 Test Cases | 10 Marks

---

# 1. Problem Overview

The system manages chess tournament players.

Each player has:

- Unique Player ID
- Player name
- Chess rating
- Participation status

The system must support:

1. Add a new player
2. Update a player's rating
3. Get player details
4. List qualified players based on rating
5. Handle duplicate and missing-player errors

The player information is stored in a dictionary.

Example:

```python
{
    "P101": {
        "name": "Arjun",
        "rating": 1850,
        "status": "Active"
    }
}
```

---

# 2. Python Features Used

| # | Python Feature | Where Used | Functionality | Example |
|---|---|---|---|---|
| 1 | Class | `class ChessTournamentSystem:` | Creates a blueprint | `class ChessTournamentSystem:` |
| 2 | Object | `chess = ChessTournamentSystem()` | Creates an instance | `chess.add_player(...)` |
| 3 | Methods | Four operations | Defines object behaviour | `def add_player(...)` |
| 4 | `self` | All instance methods | Refers to current object | `self.players` |
| 5 | Dictionary | Player storage | Stores key-value pairs | `self.players = {}` |
| 6 | Nested Dictionary | Player details | Stores multiple attributes | `{"name": "Arjun", "rating": 1850}` |
| 7 | List | Qualified players | Stores multiple IDs | `["P101", "P103"]` |
| 8 | Type Hints | Method definitions | Indicates expected types | `player_id: str` |
| 9 | `if` | Validation and filtering | Makes decisions | `if player_id in self.players:` |
| 10 | `for` loop | Qualification | Iterates through players | `for player_id, player in ...` |
| 11 | `in` | Existence checking | Checks dictionary membership | `player_id in self.players` |
| 12 | `not in` | Missing-player validation | Checks absence | `player_id not in self.players` |
| 13 | `raise` | Error handling | Explicitly raises an exception | `raise ValueError(...)` |
| 14 | `ValueError` | Duplicate player | Indicates invalid value/state | `ValueError("Player already exists")` |
| 15 | `KeyError` | Missing player | Indicates missing key | `KeyError("Player not found")` |
| 16 | `.items()` | Dictionary iteration | Returns key-value pairs | `self.players.items()` |
| 17 | `.append()` | Building result list | Adds an element to a list | `qualified.append(player_id)` |
| 18 | Dictionary access | Get/update | Retrieves a value by key | `self.players[player_id]` |
| 19 | Dictionary assignment | Add/update | Inserts or modifies data | `self.players[player_id] = ...` |
| 20 | Comparison operator | Qualification | Compares ratings | `rating >= minimum_rating` |
| 21 | `return` | All methods | Sends result to caller | `return self.players` |

---

# 3. Complete Code

```python
class ChessTournamentSystem:

    def __init__(self):
        self.players = {}

    # Operation 1: Add Player
    def add_player(self, player_id: str, name: str, rating: int) -> dict:

        if player_id in self.players:
            raise ValueError("Player already exists")

        self.players[player_id] = {
            "name": name,
            "rating": rating,
            "status": "Active"
        }

        return self.players

    # Operation 2: Update Rating
    def update_rating(self, player_id: str, new_rating: int) -> dict:

        if player_id not in self.players:
            raise KeyError("Player not found")

        self.players[player_id]["rating"] = new_rating

        return self.players

    # Operation 3: Get Player Details
    def get_player_details(self, player_id: str) -> dict:

        if player_id not in self.players:
            raise KeyError("Player not found")

        return self.players[player_id]

    # Operation 4: List Qualified Players
    def qualified_players(self, minimum_rating: int) -> list:

        qualified = []

        for player_id, player in self.players.items():
            if player["rating"] >= minimum_rating:
                qualified.append(player_id)

        return qualified
```

---

# 4. Class

```python
class ChessTournamentSystem:
```

A **class** is a blueprint for creating objects.

Here, the class represents the complete chess tournament management system.

Think:

```text
Class
  ↓
ChessTournamentSystem
  ↓
Contains data + operations
```

---

# 5. Object

```python
chess = ChessTournamentSystem()
```

This creates an object from the class.

The object can now call the methods:

```python
chess.add_player(...)
chess.update_rating(...)
chess.get_player_details(...)
chess.qualified_players(...)
```

Mental model:

```text
Class
   ↓
ChessTournamentSystem
   ↓
Object
   ↓
chess
```

---

# 6. `self`

Example:

```python
def add_player(self, player_id, name, rating):
```

`self` represents the **current object**.

When we write:

```python
chess.add_player("P101", "Arjun", 1850)
```

`self` refers to:

```text
chess
```

Therefore:

```python
self.players
```

means:

```text
the players belonging to the current chess object
```

---

# 7. Constructor – `__init__`

```python
def __init__(self):
    self.players = {}
```

`__init__()` is a special Python method called automatically when an object is created.

When:

```python
chess = ChessTournamentSystem()
```

Python automatically executes:

```python
__init__()
```

The dictionary is initialized:

```python
self.players = {}
```

Initially:

```text
players = {}
```

---

# 8. Dictionary

The main data structure is a dictionary.

```python
self.players = {}
```

A dictionary stores:

```text
key → value
```

Here:

```text
player ID → player information
```

Example:

```python
{
    "P101": {
        "name": "Arjun",
        "rating": 1850,
        "status": "Active"
    }
}
```

---

# 9. Nested Dictionary

The outer dictionary contains player IDs.

The value of each ID is another dictionary.

```python
"P101": {
    "name": "Arjun",
    "rating": 1850,
    "status": "Active"
}
```

Therefore this is a **nested dictionary**.

Structure:

```text
players
│
├── P101
│   ├── name
│   ├── rating
│   └── status
│
├── P102
│   ├── name
│   ├── rating
│   └── status
│
└── P103
    ├── name
    ├── rating
    └── status
```

---

# 10. Type Hints

Example:

```python
def add_player(
    self,
    player_id: str,
    name: str,
    rating: int
) -> dict:
```

The annotations mean:

| Syntax | Meaning |
|---|---|
| `player_id: str` | `player_id` is expected to be a string |
| `name: str` | `name` is expected to be a string |
| `rating: int` | `rating` is expected to be an integer |
| `-> dict` | Function is expected to return a dictionary |

Another example:

```python
def qualified_players(self, minimum_rating: int) -> list:
```

means:

```text
minimum_rating → int
return value → list
```

These are type hints/documentation; Python does not automatically enforce them at runtime.

---

# 11. Operation 1 – Add Player

```python
def add_player(self, player_id: str, name: str, rating: int) -> dict:
```

Example:

```python
chess.add_player("P101", "Arjun", 1850)
```

## Step 1 – Check Duplicate

```python
if player_id in self.players:
```

This checks whether the player ID already exists.

Example:

```python
"P101" in self.players
```

Possible result:

```text
True
```

or:

```text
False
```

## Step 2 – Raise Error

If the player already exists:

```python
raise ValueError("Player already exists")
```

`raise` explicitly generates an exception.

## Step 3 – Insert Player

```python
self.players[player_id] = {
    "name": name,
    "rating": rating,
    "status": "Active"
}
```

For:

```python
player_id = "P101"
name = "Arjun"
rating = 1850
```

the result is:

```python
{
    "P101": {
        "name": "Arjun",
        "rating": 1850,
        "status": "Active"
    }
}
```

## Step 4 – Return

```python
return self.players
```

The updated dictionary is returned.

---

# 12. Operation 2 – Update Rating

```python
def update_rating(self, player_id: str, new_rating: int) -> dict:
```

Example:

```python
chess.update_rating("P101", 1920)
```

## Step 1 – Check Existence

```python
if player_id not in self.players:
```

This asks:

> Does this player NOT exist?

If true:

```python
raise KeyError("Player not found")
```

## Step 2 – Update Rating

```python
self.players[player_id]["rating"] = new_rating
```

Before:

```python
"P101": {
    "name": "Arjun",
    "rating": 1850,
    "status": "Active"
}
```

After:

```python
"P101": {
    "name": "Arjun",
    "rating": 1920,
    "status": "Active"
}
```

## Step 3 – Return

```python
return self.players
```

---

# 13. Operation 3 – Get Player Details

```python
def get_player_details(self, player_id: str) -> dict:
```

Example:

```python
chess.get_player_details("P101")
```

## Check Existence

```python
if player_id not in self.players:
    raise KeyError("Player not found")
```

## Access Player

```python
return self.players[player_id]
```

For P101:

```python
{
    "name": "Arjun",
    "rating": 1920,
    "status": "Active"
}
```

Notice the difference:

```python
return self.players
```

returns **all players**.

Whereas:

```python
return self.players[player_id]
```

returns **one player's details**.

---

# 14. Operation 4 – Qualified Players

```python
def qualified_players(self, minimum_rating: int) -> list:
```

Example:

```python
chess.qualified_players(1800)
```

The requirement is:

```text
rating >= minimum_rating
```

## Step 1 – Create Empty List

```python
qualified = []
```

Initially:

```text
[]
```

## Step 2 – Iterate Through Players

```python
for player_id, player in self.players.items():
```

`.items()` provides:

```text
key + value
```

For example:

```text
P101 → player information
P102 → player information
P103 → player information
```

## Step 3 – Compare Rating

```python
if player["rating"] >= minimum_rating:
```

Suppose:

```text
minimum_rating = 1800
```

Then:

```text
P101 → 1920 >= 1800 → True
P102 → 1700 >= 1800 → False
P103 → 2100 >= 1800 → True
```

## Step 4 – Append Qualified Player

```python
qualified.append(player_id)
```

`append()` adds an item to a list.

Result:

```python
["P101", "P103"]
```

## Step 5 – Return

```python
return qualified
```

---

# 15. Dictionary Access Cheat Sheet

Given:

```python
players = {
    "P101": {
        "name": "Arjun",
        "rating": 1850,
        "status": "Active"
    }
}
```

### Get entire dictionary

```python
players
```

### Get P101

```python
players["P101"]
```

### Get name

```python
players["P101"]["name"]
```

### Get rating

```python
players["P101"]["rating"]
```

### Get status

```python
players["P101"]["status"]
```

### Update rating

```python
players["P101"]["rating"] = 1920
```

---

# 16. Dictionary Membership

### Check if key exists

```python
if player_id in self.players:
```

Meaning:

```text
Does player_id exist?
```

### Check if key doesn't exist

```python
if player_id not in self.players:
```

Meaning:

```text
Does player_id NOT exist?
```

This is one of the most important patterns for dictionary-based OOP problems.

---

# 17. Error Handling

| Situation | Code | Exception |
|---|---|---|
| Duplicate player | `if player_id in self.players` | `ValueError` |
| Missing player | `if player_id not in self.players` | `KeyError` |
| Explicitly generate error | `raise ...` | Exception |

### Duplicate

```python
if player_id in self.players:
    raise ValueError("Player already exists")
```

### Missing

```python
if player_id not in self.players:
    raise KeyError("Player not found")
```

---

# 18. `for` Loop + `.items()`

This is an important exam pattern.

```python
for player_id, player in self.players.items():
```

Suppose:

```python
self.players = {
    "P101": {"name": "Arjun", "rating": 1850},
    "P102": {"name": "Riya", "rating": 1700}
}
```

`.items()` gives:

```text
("P101", {...})
("P102", {...})
```

The loop separates them into:

```text
player_id
player
```

So:

```python
player["rating"]
```

gives the rating of the current player.

---

# 19. Comparison Operators Used

The important comparison is:

```python
>=
```

Meaning:

```text
greater than OR equal to
```

Example:

```python
1850 >= 1800
```

Result:

```text
True
```

Whereas:

```python
1700 >= 1800
```

Result:

```text
False
```

---

# 20. List and `append()`

Create a list:

```python
qualified = []
```

Add an element:

```python
qualified.append("P101")
```

Add another:

```python
qualified.append("P103")
```

Result:

```python
["P101", "P103"]
```

---

# 21. Complete Execution Example

```python
chess = ChessTournamentSystem()

chess.add_player("P101", "Arjun", 1850)
chess.add_player("P102", "Riya", 1700)
chess.add_player("P103", "Karthik", 2100)

chess.update_rating("P101", 1920)

print(chess.get_player_details("P101"))

print(chess.qualified_players(1800))
```

## Execution Flow

### 1. Create object

```python
chess = ChessTournamentSystem()
```

Initial state:

```python
self.players = {}
```

### 2. Add P101

```text
P101 → Arjun → 1850 → Active
```

### 3. Add P102

```text
P102 → Riya → 1700 → Active
```

### 4. Add P103

```text
P103 → Karthik → 2100 → Active
```

### 5. Update P101

```text
1850 → 1920
```

### 6. Get P101

Output:

```python
{
    "name": "Arjun",
    "rating": 1920,
    "status": "Active"
}
```

### 7. Find qualified players

Minimum rating:

```text
1800
```

Checks:

```text
P101 → 1920 >= 1800 → YES
P102 → 1700 >= 1800 → NO
P103 → 2100 >= 1800 → YES
```

Output:

```python
["P101", "P103"]
```

---

# 22. Four Methods – Quick Revision

| Method | Purpose | Main Logic |
|---|---|---|
| `add_player()` | Add new player | Check → Insert → Return |
| `update_rating()` | Change rating | Check → Update → Return |
| `get_player_details()` | Get one player | Check → Access → Return |
| `qualified_players()` | Find qualifying players | Loop → Compare → Append → Return |

---

# 23. Most Important Code Patterns to Memorize

## Pattern 1 – Create Class

```python
class ClassName:
```

## Pattern 2 – Constructor

```python
def __init__(self):
    self.data = {}
```

## Pattern 3 – Add Dictionary Entry

```python
self.data[key] = value
```

## Pattern 4 – Check Existing Key

```python
if key in self.data:
```

## Pattern 5 – Check Missing Key

```python
if key not in self.data:
```

## Pattern 6 – Raise Error

```python
raise ValueError("Already exists")
```

or:

```python
raise KeyError("Not found")
```

## Pattern 7 – Access Nested Dictionary

```python
self.data[key]["field"]
```

## Pattern 8 – Update Nested Dictionary

```python
self.data[key]["field"] = new_value
```

## Pattern 9 – Loop Dictionary

```python
for key, value in self.data.items():
```

## Pattern 10 – Filter Data

```python
if value["field"] >= minimum:
    result.append(key)
```

---

# 24. Exam Memory Formula

For this type of Python OOP question, remember:

```text
CLASS
  ↓
OBJECT
  ↓
SELF
  ↓
DICTIONARY
  ↓
VALIDATE
  ↓
UPDATE / INSERT
  ↓
LOOP
  ↓
CONDITION
  ↓
LIST
  ↓
RETURN
```

The four operations can be remembered as:

```text
ADD
→ check → insert → return

UPDATE
→ check → modify → return

GET
→ check → access → return

QUALIFY
→ loop → compare → append → return
```

---

# 25. One-Page Final Cheat Sheet

```python
class MySystem:

    def __init__(self):
        self.data = {}

    def add(self, key, value):

        if key in self.data:
            raise ValueError("Already exists")

        self.data[key] = value

        return self.data

    def update(self, key, new_value):

        if key not in self.data:
            raise KeyError("Not found")

        self.data[key]["field"] = new_value

        return self.data

    def get(self, key):

        if key not in self.data:
            raise KeyError("Not found")

        return self.data[key]

    def filter_data(self, minimum):

        result = []

        for key, value in self.data.items():

            if value["field"] >= minimum:
                result.append(key)

        return result
```

### Remember these 10 things:

1. `class` → create blueprint
2. `object` → create instance
3. `self` → current object
4. `__init__()` → initialize data
5. `{}` → dictionary
6. `in / not in` → check existence
7. `raise` → generate error
8. `.items()` → loop through dictionary
9. `.append()` → add to list
10. `return` → send result back

---

# 26. Assessment Mapping

The source specifies **10 marks**, with four named methods and five test cases. fileciteturn0file0L102-L117

| Test Case | Method | What It Tests | Marks |
|---|---|---|---:|
| TC1 | `add_player()` | Adds player successfully | 2 |
| TC2 | `update_rating()` | Updates rating correctly | 2 |
| TC3 | `get_player_details()` | Returns player information | 2 |
| TC4 | `qualified_players()` | Returns players meeting rating criteria | 2 |
| TC5 | Hidden | Duplicate/missing player errors | 2 |
| **Total** | | | **10** |

---

# 27. Final Mental Model

The complete program is essentially:

```text
                CHESS TOURNAMENT
                       │
                       ▼
              ChessTournamentSystem
                       │
                       ▼
                 self.players
                       │
          ┌────────────┼────────────┐
          ▼            ▼            ▼
        P101          P102         P103
          │            │            │
       Arjun          Riya        Karthik
       1920           1700         2100
       Active         Active       Active
          │
          ▼
   qualified_players(1800)
          │
          ▼
   1920 >= 1800 ✓
   1700 >= 1800 ✗
   2100 >= 1800 ✓
          │
          ▼
   ["P101", "P103"]
```

**Core formula:**

> **OOP + Dictionary + Validation + Exception Handling + Loop + Condition + List**

This pattern is directly reusable for many LLD/Python OOP exam problems such as **Student Management, Employee Management, Product Management, Library Management, Banking, Hospital Management, and Inventory systems**.
