import pandas as pd
import os

# 1. SETUP: Point this to your actual file path
# If the file is in the same folder as this script, just keep 'data.csv'
file_path = 'data.csv' 

# 2. LOAD
print(f"Reading {file_path}...")
try:
    df = pd.read_csv(file_path, encoding='ISO-8859-1') # specific encoding for this dataset usually
except FileNotFoundError:
    print("Error: File not found. Please check the path.")
    exit()

# 3. CHECK DUPLICATES
# We look for rows where BOTH InvoiceNo and StockCode are the same
duplicates = df[df.duplicated(subset=['InvoiceNo', 'StockCode'], keep=False)]

# 4. REPORT
total_rows = len(df)
duplicate_count = len(duplicates)

print("-" * 40)
print(f"Total Rows: {total_rows}")
print("-" * 40)

if duplicate_count == 0:
    print("✅ SUCCESS: (InvoiceNo + StockCode) is ALWAYS unique!")
    print("You are safe to use this constraint in Postgres.")
else:
    print(f"❌ WARNING: Found {duplicate_count} duplicate rows.")
    print("This means the same product appears multiple times on a single invoice.")
    print("\nHere are the first 5 examples:")
    print(duplicates[['InvoiceNo', 'StockCode', 'Description', 'Quantity']].head(10).to_string(index=False))
    
    print("\nRECOMMENDATION:")
    print("You must aggregate (SUM) the quantity of these lines before loading to the Fact table.")