ILS 1  
**FindBorderBarSize**

DescriptionVirtual Machine  
**Lists and Tuples in Python**   
**In this lab, you will learn:**

* What lists and tuples are  
* How to create them  
* How to access elements  
* How to use functions  
* How to convert between lists and tuples

**Lists in Python:**

**A list in Python:**

* Is ordered  
* Is changeable  
* Can store different data types  
* Uses square brackets: \[\]

**Create a List**

fruits \= \["apple", "banana", "cherry"\]  
fruits  
**Accessing List Elements**

print("First fruit:", fruits\[0\])  
print("Second fruit:", fruits\[1\])  
print("Third fruit:", fruits\[2\])  
**List Modification**

* Lists can be changed after creation.  
* Here are some basic functions for beginners.

**Modify Elements**

\# Change banana to mango  
fruits\[1\] \= "mango"  
fruits  
**Add Items**

fruits.append("orange")   \# Add at end  
fruits.insert(1, "grape") \# Add at a specific position  
fruits  
**Remove Items**

fruits.remove("apple")    \# Remove by value  
removed\_item \= fruits.pop() \# Remove last item  
print("Removed:", removed\_item)  
fruits  
**List Functions**

**Below are 15 simple list functions:**

1. len() – length  
2. append() – add item  
3. insert() – insert at index  
4. remove() – remove item  
5. pop() – remove last or index  
6. clear() – empty list  
7. sort() – sort list  
8. reverse() – reverse list  
9. index() – find index of item  
10. count() – count occurrences  
11. copy() – copy list  
12. max() – max number  
13. min() – min number  
14. sum() – sum of numbers  
15. list() – convert to list

**Demonstrating Key List Functions**

numbers \= \[10, 5, 20, 5, 8\]  
print("List:", numbers)  
print("Length:", len(numbers))  
print("Count of 5:", numbers.count(5))  
print("Index of 20:", numbers.index(20))  
print("Maximum:", max(numbers))  
print("Minimum:", min(numbers))  
print("Sum:", sum(numbers))  
\# Copy the list  
numbers\_copy \= numbers.copy()  
print("Copied List:", numbers\_copy)  
\# Reverse the list  
numbers\_copy.reverse()  
print("Reversed List:", numbers\_copy)  
\# Sort list  
numbers\_copy.sort()  
print("Sorted List:", numbers\_copy)  
**Clearing a List**

temp\_list \= \["a", "b", "c"\]  
temp\_list.clear()  
temp\_list  
**Tuples in Python**

**What is a Tuple?**

**A tuple in Python:**

* Is ordered  
* Cannot be changed (immutable)  
* Uses parentheses: ()

**Create a Tuple**

colors \= ("red", "green", "blue")  
colors  
**Access Elements**

print("First color:", colors\[0\])  
print("Second color:", colors\[1\])  
print("Third color:", colors\[2\])  
**Tuple Functions** 

**Simple tuple functions for beginners:**

1. len() – length  
2. count() – count occurrences  
3. index() – find index  
4. tuple() – convert to tuple  
5. sorted() – returns sorted list of tuple items

**Tuple Functions**

numbers\_tuple \= (10, 5, 20, 5\)  
print("Tuple:", numbers\_tuple)  
print("Length:", len(numbers\_tuple))  
print("Count of 5:", numbers\_tuple.count(5))  
print("Index of 20:", numbers\_tuple.index(20))  
print("Sorted version:", sorted(numbers\_tuple))  \# Returns a list  
**Section 4: Converting Lists and Tuples**

**Convert List to Tuple**

animals\_list \= \["dog", "cat", "rabbit"\]  
animals\_tuple \= tuple(animals\_list)  
animals\_tuple  
**Convert Tuple to List**

num\_tuple \= (1, 2, 3\)  
num\_list \= list(num\_tuple)  
num\_list  
**End of Lab**

**You successfully learned:**

* How to create lists and tuples  
* How to modify lists  
* list functions  
* tuple functions  
* How to convert between lists and tuples

ILS 2  
**FindBorderBarSize**

DescriptionVirtual Machine  
**If, Elif, Else in Python**   
**Section 1: Introduction**

**Conditional statements allow a program to make decisions.**

**In Python, the main conditional statements are:**

* if → checks the first condition  
* elif → checks additional conditions  
* else → runs when none of the above conditions are true

**Section 2: Basic if Statement**

**The if statement runs when its condition is true.**

**Basic if example**

number \= 10  
if number \> 5:  
    print("The number is greater than 5.")  
**Section 3: if – else Statement**

**The else block runs when the if condition is false.**

**if-else example**

age \= int(input("Enter your age: "))  
if age \>= 18:  
    print("You are eligible to vote.")  
else:  
    print("You are not eligible to vote.")  
**Section 4: if – elif – else**

**Use elif when you want to check multiple conditions.**

**Only one block runs—the first one that is true.**

**if-elif-else example**

marks \= int(input("Enter your marks (0–100): "))  
if marks \>= 90:  
    print("Grade: A")  
elif marks \>= 75:  
    print("Grade: B")  
elif marks \>= 60:  
    print("Grade: C")  
else:  
    print("Grade: D")  
**Section 5: Checking Even or Odd**

**This is one of the most common examples for beginners: determining if a number is even or odd.**

number \= int(input("Enter a number: "))  
if number % 2 \== 0:  
    print("The number is EVEN.")  
else:  
    print("The number is ODD.")  
**Section 6: Checking Positive, Negative, or Zero**

**A simple program with three conditions using if, elif, and else.**

num \= float(input("Enter any number: "))  
if num \> 0:  
    print("The number is POSITIVE.")  
elif num \< 0:  
    print("The number is NEGATIVE.")  
else:  
    print("The number is ZERO.")  
**Section 7: Simple String Comparison**

**You can use if conditions with strings as well.**

city \= input("Enter your favorite city: ")  
if city \== "Paris":  
    print("Paris is known as the City of Light.")  
elif city \== "London":  
    print("London is famous for the Big Ben.")  
else:  
    print("That's a wonderful city\!")  
**Section 8: Checking Password Match**

password \= input("Enter password: ")  
if password \== "python123":  
    print("Access Granted.")  
else:  
    print("Access Denied.")  
**Section 9: Minimum Interactive Exercise**

**Try this yourself:**

**Write a small program that:**

1. Takes a number from the user  
2. Prints:  
3.   
* "Small Number" if number \< 50  
* "Medium Number" if number is between 50 and 100  
* "Large Number" if number \> 100

**Starter Template)**

num \= int(input("Enter a number: "))  
\# Write your if, elif, else below:  
**End of Lab**

**You learned:**

* How to use if, elif, and else  
* How Python makes decisions  
* How to compare numbers and strings  
* How to build simple interactive programs

ILS 3  
**Introduction to Python Loops and Controls: for, while, break, continue, pass**  
**Section 1: Introduction**

**Loops allow code to run repeatedly.**

**Python has two main loops:**

* for loop – repeats for each value in a sequence  
* while loop – repeats as long as a condition stays true

**This lab introduces both loops in simple steps.**

**Section 2: Basic for Loop**

**A for loop repeats for each number in range().**

**Example**

for i in range(5):  
    print("Current number is:", i)  
**Sample Output:**

Current number is: 0  
Current number is: 1  
Current number is: 2  
Current number is: 3  
Current number is: 4  
**Explanation:**

* Range(5) gives numbers 0 to 4\.  
* The loop prints each number one by one.

**Section 3: for Loop with if–else**

**We can check conditions inside a loop.**

for num in range(5):  
    if num \== 3:  
        print(num, "is special\!")  
    else:  
        print(num, "is normal.")  
**Sample Output:**

0 is normal.  
1 is normal.  
2 is normal.  
3 is special\!  
4 is normal.  
**Explanation:**

* The loop prints each number.  
* When the number is 3, it prints a different message.

**Section 4: Basic while Loop**

**A while loop repeats as long as its condition is TRUE.**

count \= 1  
while count \<= 5:  
    print("Count is:", count)  
    count \= count \+ 1  
**Sample Output:**

Count is: 1  
Count is: 2  
Count is: 3  
Count is: 4  
Count is: 5  
**Explanation:**

* Starts at 1\.  
* Runs until the value becomes greater than 5\.

**Section 5: while Loop with if–else**

**Checking conditions inside a while loop.**

x \= 1  
while x \<= 5:  
    if x \== 3:  
        print("Reached the number 3\!")  
    else:  
        print("Number is:", x)  
    x \= x \+ 1  
**Sample Output:**

Number is: 1  
Number is: 2  
Reached the number 3  
Number is: 4  
Number is: 5  
**Explanation:**

* When x becomes 3, it prints a special message.  
* Otherwise prints the current number.

**Section 6: Using break in a Loop**

**break stops the loop immediately.**

for i in range(10):  
    if i \== 5:  
        break  
    print("i is:", i)  
**Sample Output:**

i is: 0  
i is: 1  
i is: 2  
i is: 3  
i is: 4  
**Explanation:**

* The loop prints numbers until it reaches 5,  
* then break stops the loop.

**Section 7: Using continue in a Loop**

**continue skips the current iteration.**

**for i in range(6):**

    if i \== 3:  
        continue  
    print("i is:", i)  
**Sample Output:**

i is: 0  
i is: 1  
i is: 2  
i is: 4  
i is: 5  
**Explanation:**

* When i becomes 3, the print statement is skipped.  
* Loop continues normally afterward.

**Section 8: Using pass in a Loop**

**pass does nothing.**

**It is used as a placeholder.**

for i in range(5):  
    if i \== 2:  
        pass  
    print("i is:", i)  
**Sample Output:**

i is: 0  
i is: 1  
i is: 2  
i is: 3  
i is: 4  
**Explanation:**

* The loop runs normally.  
* When i is 2, pass simply does nothing.

**Section 9: Practice Exercise**

**Write a program that:**

* Asks the user for a number  
* Prints numbers from 1 to that number  
* Skip printing the number 5 (use continue)  
* Stop completely if the number reaches 10 (use break)  
* 

**Starter Template**

limit \= int(input("Enter a number: "))  
\# Write your for loop using break and continue below:  
**End of Lab**

**You learned:**

* How for and while loops work  
* How to combine loops with if–else  
* How break, continue, and pass affect loops  
* How to build small programs using loops

ILS 4  
**Stock Price Case Study**  
**Section 1: Introduction**

A list in Python is a collection that can hold multiple values in a single variable.  
Important points about lists:

* Lists are ordered  
* Lists are changeable (you can add, remove, or modify elements)  
* Lists use square brackets \[\]  
* Lists can store different types of data (numbers, strings, etc.)

In this lab, we will learn lists through a simple stock market example.  
**Section 2: Creating a List (Stock Prices)**

Here we create a list of stock prices for a company over five days.  
stock\_prices \= \[150.25, 152.30, 148.90, 155.00, 157.45\]  
print("Stock Prices:", stock\_prices)  
Sample Output:  
Stock Prices: \[150.25, 152.3, 148.9, 155.0, 157.45\]  
Explanation:  
We created a list called stock\_prices that stores the price for each day.  
**Section 3: Accessing List Elements**

We can retrieve values using their index.  
Indexing starts at 0\.  
print("Price on Day 1:", stock\_prices\[0\])  
print("Price on Day 3:", stock\_prices\[2\])  
print("Price on Day 5:", stock\_prices\[4\])  
Sample Output:  
Price on Day 1: 150.25  
Price on Day 3: 148.9  
Price on Day 5: 157.45  
Explanation:  
We access values using list\[index\].  
For example, index 0 is the first item.  
**Section 4: Modifying a List**

Example: updating the stock price on Day 3\.  
stock\_prices\[2\] \= 149.50  
print("Updated Prices:", stock\_prices)  
Sample Output:  
Updated Prices: \[150.25, 152.3, 149.5, 155.0, 157.45\]  
Explanation:  
We replaced the old Day 3 price (148.90) with the new value (149.50).  
**Section 5: Adding Items to a List**

We can add more stock prices using append().  
stock\_prices.append(160.10)  
print("After Adding New Price:", stock\_prices)  
Sample Output:  
After Adding New Price: \[150.25, 152.3, 149.5, 155.0, 157.45, 160.1\]  
Explanation:  
append() adds a new value at the end of the list.  
**Section 6: Removing Items From a List**

We can remove stock prices using remove().  
stock\_prices.remove(152.30)  
print("After Removing 152.30:", stock\_prices)  
Sample Output:  
After Removing 152.30: \[150.25, 149.5, 155.0, 157.45, 160.1\]  
Explanation:  
remove() deletes the first matching value from the list.  
**Section 7: Basic List Functions (Length, Max, Min)**

print("Number of Price Records:", len(stock\_prices))  
print("Highest Price:", max(stock\_prices))  
print("Lowest Price:", min(stock\_prices))  
Sample Output:  
Number of Price Records: 5  
Highest Price: 160.1  
Lowest Price: 149.5  
Explanation:

* len() → number of items  
* max() → highest value  
* min() → lowest value

**Section 8: Counting and Finding Index**

print("Count of 155.00:", stock\_prices.count(155.00))  
print("Index of 157.45:", stock\_prices.index(157.45))  
Sample Output:  
Count of 155.00: 1  
Index of 157.45: 3  
Explanation:

* count(x) → how many times x appears  
* index(x) → position of x in the list

**Section 9: Sorting and Reversing Lists**

Sorting the stock prices:  
sorted\_prices \= sorted(stock\_prices)  
print("Sorted Prices:", sorted\_prices)  
Sample Output:  
Sorted Prices: \[149.5, 150.25, 155.0, 157.45, 160.1\]  
Reversing the list:  
reversed\_prices \= list(reversed(stock\_prices))  
print("Reversed Prices:", reversed\_prices)  
Sample Output:  
Reversed Prices: \[160.1, 157.45, 155.0, 149.5, 150.25\]  
Explanation:

* sorted() returns a new sorted list  
* reversed() returns items from last to first

**Section 10: Practice Exercise** 

Write a program that:

* Creates a list of 5 stock prices  
* Prints:  
* The highest price  
* The lowest price  
* The total number of prices  
* Updates the last price with a new value  
* Prints the updated list

Starter Template  
stock\_prices \= \[\_\_\_, \_\_\_, \_\_\_, \_\_\_, \_\_\_\]  
\# Print highest and lowest  
\# Update last price  
\# Print updated list  
**End of Lab**

You learned:

* How to create a list  
* How to access and modify list values  
* How to add and remove items  
* Basic list functions: len(), max(), min(), count(), index()  
* How to sort and reverse a list  
* How lists help in real-world cases (like tracking stock prices)

ILS 5  
**Weather Case Study**  
**Section 1: Introduction**

**Conditional statements allow Python programs to make decisions.**

**Important points:**

* if → checks the first condition  
* elif → checks additional conditions  
* else → runs when none of the previous conditions are true

**In this lab, we will understand if and elif using a real-life weather-based case study.**

**Section 2: Basic if Statement**

**An if statement runs only when its condition is true.**

temperature \= 32  
if temperature \> 30:  
    print("It is a hot day\!")  
**Sample Output:**

It is a hot day\!  
**Explanation:**

**The condition (temperature \> 30\) is true, so the message prints.**

**Section 3: if–elif for Multiple Conditions**

**We can use elif to check additional conditions.**

temperature \= 18  
if temperature \> 30:  
    print("It is a hot day.")  
elif temperature \> 20:  
    print("It is a warm day.")  
else:  
    print("It is a cool day.")  
**Sample Output:**

It is a cool day.  
**Explanation:**

**18 is not \> 30 or \> 20, so the else block runs.**

**Section 4: Weather Case Study – Clothing Recommendation System**

**In this case study, we will write a program that recommends clothing based on the weather temperature entered by the user.**

temp \= int(input("Enter today's temperature: "))  
if temp \>= 35:  
    print("Recommendation: Wear light cotton clothes.")  
elif temp \>= 25:  
    print("Recommendation: Wear a t-shirt and jeans.")  
elif temp \>= 15:  
    print("Recommendation: Wear a light jacket.")  
else:  
    print("Recommendation: Wear warm clothes.")  
**Sample Output:**

Enter today's temperature: 12  
Recommendation: Wear warm clothes.  
**Explanation:**

**Since 12 is less than 15, the program suggests warm clothes.**

**Section 5: Weather Case Study – Safety Advice Based on Conditions**  
**Another part of the weather-based decision system:**

**We suggest actions based on rain probability.**

chance\_of\_rain \= int(input("Enter chance of rain (0–100%): "))  
if chance\_of\_rain \>= 80:  
    print("Safety Advice: Carry an umbrella and wear waterproof shoes.")  
elif chance\_of\_rain \>= 50:  
    print("Safety Advice: Carry an umbrella.")  
elif chance\_of\_rain \>= 20:  
    print("Safety Advice: It might drizzle—stay alert.")  
else:  
    print("Safety Advice: No rain expected today.")  
**Sample Output:**

Enter chance of rain (0–100%): 65  
Safety Advice: Carry an umbrella.  
**Explanation:**

**Since chance of rain is 65, it falls under the 50%–79% category.**

**Section 6: Weather Case Study – Air Quality Check**

**We evaluate the air quality index (AQI) and give health messages.**

aqi \= int(input("Enter the AQI value: "))  
if aqi \>= 300:  
    print("Air Quality: Hazardous. Stay indoors.")  
elif aqi \>= 200:  
    print("Air Quality: Very Unhealthy.")  
elif aqi \>= 100:  
    print("Air Quality: Unhealthy for sensitive groups.")  
else:  
    print("Air Quality: Good.")  
**Sample Output:**

Enter the AQI value: 110  
Air Quality: Unhealthy for sensitive groups.  
**Explanation:**

**AQI 110 falls in the range 100–199.**

**Section 7: Practice Exercise – Student Task**

**Write a program that:**

* Takes rainfall (mm) as input  
* Prints:  
* “Heavy Rainfall” if \>= 50  
* “Moderate Rainfall” if \>= 20  
* “Light Rainfall” if \>= 5  
* “No Rainfall” otherwise

**Starter Template**

rain \= int(input("Enter rainfall in mm: "))  
\# Write your if–elif conditions below:  
**End of Lab**

**You learned:**

* How if and elif conditions work  
* How to check multiple conditions  
* How to design decision-making programs  
* How to apply conditional logic to real-world weather data

