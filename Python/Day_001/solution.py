import pandas as pd
import matplotlib.pyplot as plt

# -----------------------------------
# 1. Create sample transaction data
# -----------------------------------

data = {
    "customer_id": [101, 102, 101, 103, 104, 102, 105, 103, 101, 105],
    "product": [
        "Laptop", "Mouse", "Keyboard", "Monitor", "Laptop",
        "Keyboard", "Mouse", "Laptop", "Monitor", "Keyboard"
    ],
    "quantity": [1, 2, 1, 2, 1, 3, 5, 1, 1, 2],
    "price": [800, 25, 50, 200, 900, 45, 20, 850, 220, 55]
}

df = pd.DataFrame(data)

print("Original Data:")
print(df)


# -----------------------------------
# 2. Calculate transaction amount
# -----------------------------------

df["total_amount"] = df["quantity"] * df["price"]

print("\nData with Total Amount:")
print(df)


# -----------------------------------
# 3. Calculate total spending
#    for each customer
# -----------------------------------

customer_spending = (
    df.groupby("customer_id")["total_amount"]
      .sum()
      .reset_index()
)

print("\nTotal Spending by Each Customer:")
print(customer_spending)


# -----------------------------------
# 4. Sort customers by spending
# -----------------------------------

customer_spending = customer_spending.sort_values(
    by="total_amount",
    ascending=False
)

print("\nCustomers Sorted by Spending:")
print(customer_spending)


# -----------------------------------
# 5. Select Top 5 customers
# -----------------------------------

top_5 = customer_spending.head(5)

print("\nTop 5 Customers:")
print(top_5)


# -----------------------------------
# 6. Visualize Top 5 Customers
# -----------------------------------

plt.figure(figsize=(8, 5))

plt.bar(
    top_5["customer_id"].astype(str),
    top_5["total_amount"]
)

plt.xlabel("Customer ID")
plt.ylabel("Total Spending")
plt.title("Top 5 Customers by Total Spending")

plt.tight_layout()
plt.show()