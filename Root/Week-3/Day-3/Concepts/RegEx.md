Regular Expressions (Regex) in Python — Simple Way to Learn
Think of Regex as a search pattern.
Example:
text = "My phone number is 9876543210"
Instead of searching the entire text manually, regex can find patterns like:
Phone numbers
Email IDs
Dates
URLs
Digits
Words

Step 1: Import Regex Module
import re

Step 2: Most Used Functions
Function
Purpose
re.search()
Find first match
re.findall()
Find all matches
re.match()
Match from beginning
re.sub()
Replace text
re.split()
Split text
re.compile()
Create reusable pattern


Step 3: Basic Patterns
Digits
\d = Any digit (0-9)
import re

text = "Age is 25"

print(re.findall(r"\d", text))
Output
['2', '5']

Multiple Digits
\d+
print(re.findall(r"\d+", "Age is 25"))
Output
['25']

Alphabets
[a-zA-Z]
print(re.findall(r"[a-zA-Z]", "Python123"))
Output
['P','y','t','h','o','n']

Words
\w
print(re.findall(r"\w+", "Python 123"))
Output
['Python', '123']

Spaces
\s
print(re.findall(r"\s", "Hello World"))
Output
[' ']

Step 4: Most Important Symbols
Symbol
Meaning
Example
.
Any character
a.b
*
0 or more
ab*
+
1 or more
ab+
?
Optional
colou?r
^
Start of string
^Hello
$
End of string
World$
[]
Character set
[abc]
|
OR
cat|dog


Example 1: Starts With
text = "Python is easy"

print(re.search(r"^Python", text))
Output
Match

Example 2: Ends With
print(re.search(r"easy$", text))
Output
Match

Step 5: Extract Email
text = "Contact: abc@gmail.com"

emails = re.findall(r"\S+@\S+", text)

print(emails)
Output
['abc@gmail.com']

Step 6: Extract Phone Number
text = "Call me at 9876543210"

phones = re.findall(r"\d{10}", text)

print(phones)
Output
['9876543210']

Step 7: Replace Text
text = "I like Java"

new_text = re.sub("Java", "Python", text)

print(new_text)
Output
I like Python

Step 8: Split Using Regex
text = "Apple,Orange;Banana"

result = re.split(r"[,;]", text)

print(result)
Output
['Apple', 'Orange', 'Banana']

Step 9: Curly Braces Quantifiers
Pattern
Meaning
\d{3}
Exactly 3 digits
\d{3,5}
3 to 5 digits
\d{3,}
3 or more digits

Example:
print(re.findall(r"\d{3}", "12345 678"))
Output
['123', '678']

Real-Time Data Engineer Examples
Extract Order IDs
text = "ORD1001 ORD1002 ORD1003"

print(re.findall(r"ORD\d+", text))
Output
['ORD1001', 'ORD1002', 'ORD1003']

Extract Dates
text = "2025-08-01"

print(re.findall(r"\d{4}-\d{2}-\d{2}", text))
Output
['2025-08-01']

Extract Amounts
text = "$100 $250 $999"

print(re.findall(r"\$\d+", text))
Output
['$100', '$250', '$999']

80/20 Regex Cheat Sheet
Pattern
Meaning
\d
Digit
\D
Non-digit
\w
Word
\W
Non-word
\s
Space
\S
Non-space
.
Any character
*
Zero or more
+
One or more
?
Optional
^
Start
$
End
[]
Character set
{}
Count


Learning Order (1 Hour)
Level 1 (15 mins)
\d
\w
\s
Level 2 (15 mins)
+
*
?
Level 3 (15 mins)
^
$
[]
Level 4 (15 mins)
findall()
search()
sub()
split()
If you master just these 10 patterns (\d, \w, \s, +, *, ?, ^, $, [], {}), you'll be able to solve about 90% of regex tasks used in Python, ETL pipelines, log parsing, data validation, and data engineering work.

