portfolio = []
print("Your stock portfolio has been created:", portfolio)

def add_stock(stock):
    portfolio.append(stock)
    return stock


print("Added:", add_stock("AAPL"))
print("Added:", add_stock("TSLA"))

def remove_stock(stock):
    if stock in portfolio:
        portfolio.remove(stock)
        return stock
    else:
        return "Stock not found"

def find_stock(stock):
    if stock in portfolio:
        return portfolio.index(stock)
    else:
        return "Stock not found"

def reverse_portfolio():
    portfolio.reverse()
    return portfolio


def show_portfolio():
    print("Your current portfolio:")
    for stock in portfolio:
        print("-", stock)


def compare_stock_length(stock1, stock2):
    if len(stock1) > len(stock2):
        return stock1 + " has a longer symbol."
    elif len(stock2) > len(stock1):
        return stock2 + " has a longer symbol."
    else:
        return "Both have equal length."

while True:
    print("\n--- Stock Portfolio Menu ---")
    print("1. Add Stock")
    print("2. Remove Stock")
    print("3. Find Stock")
    print("4. Reverse Portfolio")
    print("5. Show Portfolio")
    print("6. Compare Stock Symbol Lengths")
    print("7. Exit")

    choice = input("Enter your choice: ")

    if choice == "1":
        s = input("Enter stock symbol to add: ")
        print("Added:", add_stock(s))

    elif choice == "2":
        s = input("Enter stock symbol to remove: ")
        print(remove_stock(s))

    elif choice == "3":
        s = input("Enter stock symbol to find: ")
        print("Result:", find_stock(s))

    elif choice == "4":
        print("Reversed Portfolio:", reverse_portfolio())

    elif choice == "5":
        show_portfolio()

    elif choice == "6":
        s1 = input("Enter first stock symbol: ")
        s2 = input("Enter second stock symbol: ")
        print(compare_stock_length(s1, s2))

    elif choice == "7":
        print("Exiting Portfolio Manager...")
        break

    else:
        print("Invalid choice. Try again.")
