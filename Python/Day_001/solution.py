# ============================================================
# Project: Personal Expense Analyzer
# Day: 1
# Topic: Core Python Fundamentals
# ============================================================


# STEP 1: Store expense transactions

expenses = [
    {"category": "Food", "amount": 250},
    {"category": "Transport", "amount": 120},
    {"category": "Food", "amount": 350},
    {"category": "Shopping", "amount": 1200},
    {"category": "Bills", "amount": 800},
    {"category": "Transport", "amount": 180},
    {"category": "Food", "amount": 200},
    {"category": "Entertainment", "amount": 500},
    {"category": "Bills", "amount": 650},
    {"category": "Shopping", "amount": 900},
]


# STEP 2: Define the monthly budget

monthly_budget = 6000


# STEP 3: Calculate total expenditure

total_expense = 0

for transaction in expenses:
    total_expense += transaction["amount"]


# STEP 4: Calculate average transaction amount

number_of_transactions = len(expenses)

average_expense = total_expense / number_of_transactions


# STEP 5: Calculate spending by category

category_totals = {}

for transaction in expenses:

    category = transaction["category"]
    amount = transaction["amount"]

    if category in category_totals:
        category_totals[category] += amount
    else:
        category_totals[category] = amount


# STEP 6: Identify the largest transaction

largest_transaction = expenses[0]

for transaction in expenses:

    if transaction["amount"] > largest_transaction["amount"]:
        largest_transaction = transaction


# STEP 7: Calculate remaining budget

remaining_budget = monthly_budget - total_expense


# STEP 8: Generate the financial report

print("=" * 45)
print("       PERSONAL EXPENSE ANALYZER")
print("=" * 45)

print(f"Number of transactions : {number_of_transactions}")
print(f"Total expenditure      : Rs. {total_expense:.2f}")
print(f"Average transaction   : Rs. {average_expense:.2f}")

print("\nCATEGORY-WISE EXPENDITURE")
print("-" * 45)

for category, amount in category_totals.items():

    percentage = (amount / total_expense) * 100

    print(
        f"{category:<15} "
        f"Rs. {amount:>7.2f} "
        f"({percentage:5.1f}%)"
    )


print("\nLARGEST TRANSACTION")
print("-" * 45)

print(f"Category : {largest_transaction['category']}")
print(f"Amount   : Rs. {largest_transaction['amount']:.2f}")


print("\nMONTHLY BUDGET SUMMARY")
print("-" * 45)

print(f"Monthly budget    : Rs. {monthly_budget:.2f}")
print(f"Total expenditure: Rs. {total_expense:.2f}")
print(f"Remaining budget : Rs. {remaining_budget:.2f}")


if remaining_budget > 0:

    print("Status: Within budget.")

elif remaining_budget == 0:

    print("Status: Budget fully utilized.")

else:

    print(f"Status: Over budget by Rs. {abs(remaining_budget):.2f}")


print("\nReport generated successfully!")
print("=" * 45)