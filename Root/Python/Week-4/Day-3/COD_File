# Automated Warehouse Stock Manager

**Question Code:** Q02
**Difficulty Level:** Easy
**Technology:** Python OOP
**Total Marks:** 10

**Assessment SOP:** Independent test setup, latest-only report, no final score print

---

## Assessment Instructions

1. Open the Learnlytica assessment tool.
2. Enter your Email address.
3. Enter the Question ID.
4. Click **Start Assessment**.
5. Once the assessment starts, open VSCode.
6. Implement your solution only in:

```text
solution.py
```

### After Completing the Implementation

1. Click **Run Tests**.
2. Review the test results.
3. Click **Validate**.
4. Once satisfied with your attempt, click **Submit**.
5. Click **End Assessment**.

> **Note:** Sample inputs and expected outputs in this document are illustrative only and are intentionally different from the actual visible and hidden driver test data.

---

# Problem Statement

The **Automated Warehouse Stock Manager** maintains stock levels for an e-commerce warehouse.

Each item is stored in a dictionary where:

* **Key** → Item name
* **Value** → Stock quantity as an integer, or the string `"Out of Stock"`

The system must support:

* Registering items
* Processing outgoing shipments
* Restocking sold-out items
* Generating low-stock reports

---

# Class Creation

Create the following class:

```python
class WarehouseStockManager:
```

---

# Constructor

## Function Prototype

```python
def __init__(self):
```

## Purpose

Initialize an empty dictionary named `self.stock`.

## Implementation

```python
def __init__(self):
    self.stock = {}
```

---

# 1. Register a New Item

## Function Prototype

```python
def register_item(self, item_name: str, quantity: int) -> dict:
```

## Purpose

Add a new item or increase the stock of an existing item.

## Example Input

```python
manager.register_item("Laptops", 50)
```

## Expected Output

```python
{"Laptops": 50}
```

## Implementation Flow

* If `item_name` already exists and its current value is a numeric stock quantity, increase that stock by `quantity`.
* Otherwise, add the item with the given `quantity`.
* Return the updated `self.stock` dictionary.

---

# 2. Process Bulk Shipment

## Function Prototype

```python
def process_shipment(self, shipment: dict) -> dict:
```

## Purpose

Reduce stock for items included in an outgoing shipment.

## Example Setup

```python
manager.stock = {
    "Laptops": 50,
    "Keyboards": 20
}
```

## Example Input

```python
manager.process_shipment({
    "Laptops": 10,
    "Keyboards": 20
})
```

## Expected Output

```python
{
    "Laptops": 40,
    "Keyboards": "Out of Stock"
}
```

## Implementation Flow

For each item in `shipment`:

* If the item does not exist in `self.stock`, leave the warehouse dictionary unchanged for that item.
* If the current stock is a positive integer and the shipment quantity is greater than `0` but less than the current stock, subtract the shipment quantity from the current stock.
* If the shipment quantity is equal to or greater than the current stock, set that item's value to `"Out of Stock"`.
* If the shipment quantity is `0` or negative, set that item's value to `"Out of Stock"`.
* If the item is already `"Out of Stock"`, keep it as `"Out of Stock"`.
* Return the updated `self.stock` dictionary.

---

# 3. Restock Sold-Out Items

## Function Prototype

```python
def restock_items(self, restock_quantity: int) -> dict:
```

## Purpose

Restock only the items currently marked as `"Out of Stock"`.

## Example Setup

```python
manager.stock = {
    "Laptops": 40,
    "Keyboards": "Out of Stock"
}
```

## Example Input

```python
manager.restock_items(50)
```

## Expected Output

```python
{
    "Laptops": 40,
    "Keyboards": 50
}
```

## Implementation Flow

* Iterate through `self.stock`.
* Replace only values equal to `"Out of Stock"` with `restock_quantity`.
* Do not change items that already have numeric stock values.
* Return the updated `self.stock` dictionary.

---

# 4. Generate Low Stock Report

## Function Prototype

```python
def generate_low_stock_report(self, threshold: int) -> dict:
```

## Purpose

Return numeric-stock items whose quantity is strictly below `threshold`.

## Example Setup

```python
manager.stock = {
    "Keyboards": 10,
    "Monitors": 5,
    "Laptops": 40
}
```

## Example Input

```python
manager.generate_low_stock_report(15)
```

## Expected Output

```python
{
    "Keyboards": 10,
    "Monitors": 5
}
```

## Implementation Flow

* Check each item in `self.stock`.
* Include only items with an integer quantity strictly less than `threshold`.
* Do not include items whose quantity is exactly equal to `threshold`.
* Do not include items marked as `"Out of Stock"`.
* Return a **new dictionary** containing only the matching items.
