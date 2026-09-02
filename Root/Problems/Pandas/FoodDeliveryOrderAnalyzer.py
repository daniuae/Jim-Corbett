# 2. Food Delivery Order Analysis
#
# The required operations are:
#
# Create orders DataFrame
# Remove duplicate orders using OrderID
# Fill missing amounts with 0
# Calculate delivered spending per customer
# Create restaurant/status pivot summary
import pandas as pd

class FoodDeliveryOrderAnalyzer:

    # ---------------------------------------------------------
    # 1. Create Orders DataFrame
    # ---------------------------------------------------------
    def create_orders_df(
        self,
        data: list
    ) -> pd.DataFrame:

        df = pd.DataFrame(
            data,
            columns=[
                "OrderID",
                "CustomerID",
                "Restaurant",
                "Date",
                "Amount",
                "Status"
            ]
        )

        return df

    # ---------------------------------------------------------
    # 2. Remove Duplicate Orders
    # ---------------------------------------------------------
    def remove_duplicate_orders(
        self,
        df: pd.DataFrame
    ) -> pd.DataFrame:

        result = (
            df.drop_duplicates(
                subset=["OrderID"],
                keep="first"
            )
            .reset_index(drop=True)
        )

        return result

    # ---------------------------------------------------------
    # 3. Fill Missing Order Amounts
    # ---------------------------------------------------------
    def fill_missing_amounts(
        self,
        df: pd.DataFrame
    ) -> pd.DataFrame:

        df = df.copy()

        df["Amount"] = (
            df["Amount"]
            .fillna(0)
        )

        return df

    # ---------------------------------------------------------
    # 4. Calculate Total Spending per Customer
    # ---------------------------------------------------------
    def customer_total_spending(
        self,
        df: pd.DataFrame
    ) -> pd.DataFrame:

        # Only delivered orders
        delivered_df = df[
            df["Status"] == "Delivered"
        ]

        result = (
            delivered_df
            .groupby("CustomerID")["Amount"]
            .sum()
            .reset_index(name="Total Spending")
        )

        return result

    # ---------------------------------------------------------
    # 5. Restaurant-wise Status Summary
    # ---------------------------------------------------------
    def restaurant_status_summary(
        self,
        df: pd.DataFrame
    ) -> pd.DataFrame:

        result = pd.pivot_table(
            df,
            index="Restaurant",
            columns="Status",
            values="OrderID",
            aggfunc="count",
            fill_value=0
        )

        # Make sure required status columns exist
        result = result.reindex(
            columns=[
                "Cancelled",
                "Delivered",
                "Preparing"
            ],
            fill_value=0
        )

        result = result.reset_index()

        return result


# =============================================================
# DRIVER CODE
# =============================================================

if __name__ == "__main__":

    analyzer = FoodDeliveryOrderAnalyzer()

    order_data = [
        [501, 1001, "SpiceHub", "2024-08-01", 450.0, "Delivered"],
        [502, 1002, "BurgerTown", "2024-08-01", None, "Cancelled"],
        [501, 1001, "SpiceHub", "2024-08-01", 450.0, "Delivered"],
        [503, 1003, "PizzaZone", "2024-08-02", 700.0, "Delivered"],
        [504, 1001, "SpiceHub", "2024-08-03", 450.0, "Delivered"],
        [505, 1004, "BurgerTown", "2024-08-03", 300.0, "Preparing"],
        [506, 1005, "PizzaZone", "2024-08-04", None, "Delivered"],
        [507, 1002, "BurgerTown", "2024-08-04", 250.0, "Cancelled"]
    ]

    # 1. Create DataFrame
    df = analyzer.create_orders_df(order_data)

    print("=" * 60)
    print("FOOD DELIVERY ORDERS")
    print("=" * 60)
    print(df)

    # 2. Remove duplicates
    unique_df = analyzer.remove_duplicate_orders(df)

    print("\n" + "=" * 60)
    print("ORDERS AFTER REMOVING DUPLICATES")
    print("=" * 60)
    print(unique_df)

    # 3. Fill missing amounts
    filled_df = analyzer.fill_missing_amounts(unique_df)

    print("\n" + "=" * 60)
    print("ORDERS AFTER FILLING MISSING AMOUNTS")
    print("=" * 60)
    print(filled_df)

    # 4. Customer spending
    spending = analyzer.customer_total_spending(filled_df)

    print("\n" + "=" * 60)
    print("CUSTOMER TOTAL SPENDING")
    print("=" * 60)
    print(spending)

    # 5. Restaurant summary
    summary = analyzer.restaurant_status_summary(filled_df)

    print("\n" + "=" * 60)
    print("RESTAURANT STATUS SUMMARY")
    print("=" * 60)
    print(summary)
