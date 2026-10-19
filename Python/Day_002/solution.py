import pandas as pd 
import numpy as np
 # ----------------------------------- 
 # 1. Create a sample customer dataset 
 #  ----------------------------------- 
data = { "age": [25, 32, np.nan, 45, 28, np.nan, 52, 41, 36, 29], "income": [35000, 52000, 48000, np.nan, 41000, 39000, 75000, np.nan, 61000, 45000], "experience": [1, 5, 4, 15, np.nan, 3, 20, 12, 8, np.nan], "city": [ "Mumbai", "Delhi", "Mumbai", "Pune", "Delhi", np.nan, "Mumbai", "Pune", "Delhi", "Mumbai" ], "purchased": [0, 1, 1, 1, 0, 0, 1, 1, 1, 0] } 
df = pd.DataFrame(data) 
print("Original Dataset:")
print(df)
 #-----------------------------------
 # 2. Check missing values
 #  ----------------------------------- 
print("\nMissing values in each column:")
print(df.isnull().sum())
 #-----------------------------------
 # 3. Calculate percentage of missing # values in each column
 # ----------------------------------- 
missing_percentage = df.isnull().mean() * 100 
print("\nMissing value percentage:") 
print(missing_percentage)
 #-----------------------------------
 # 4. Fill numerical missing values # using the median 
 #----------------------------------- 
numerical_columns = ["age", "income", "experience"]
for column in numerical_columns: 
    df[column] = df[column].fillna(df[column].median()) 
 # # -----------------------------------
 # 5. Fill categorical missing values # using the most frequent value
 #  ----------------------------------- 
df["city"] = df["city"].fillna(df["city"].mode()[0])
 #----------------------------------- # 
 # 6. Verify that missing values # have been handled 
 #----------------------------------- 
print("\nMissing values after cleaning:")
print(df.isnull().sum())
 #----------------------------------- # 
 # 7. Separate features and target 
 #----------------------------------- 
X = df.drop("purchased", axis=1) 
y = df["purchased"] 
print("\nFeatures:")
print(X) 
print("\nTarget:") 
print(y)