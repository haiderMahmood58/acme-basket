# Acme Widget Co - Sales System Proof of Concept

## Overview

This Ruby project implements a simple sales basket system for Acme Widget Co, a fictional widget provider. It demonstrates:

- Product catalog management
- Adding products to a basket
- Applying special offers (e.g., buy-one-get-second-half-price)
- Calculating delivery fees based on order subtotal
- Computing the final total price with offers and delivery fees applied

---

## How It Works

1. **Product Catalog**  
   Products are defined with a unique code, name, and price in cents (integer to avoid floating point rounding issues).  
   The `Catalogue` class stores these products keyed by their product code.

2. **Basket**  
   The `Basket` class is initialized with the product catalogue, delivery rules, and offers.  
   Products are added to the basket by their product codes using the `add` method.

3. **Special Offers**  
   Offers implement a common interface with an `apply` method that takes basket items and returns the discount in cents (negative integer).  
   Currently, a `RedWidgetHalfPrice` offer applies "buy one red widget, get the second at half price".

4. **Delivery Rules**  
   Delivery fees depend on the subtotal (after discounts) as follows:
   - Orders under $50: $4.95 delivery fee  
   - Orders $50 to under $90: $2.95 delivery fee  
   - Orders $90 and above: free delivery  
   Delivery rules are implemented as ordered threshold checks.

5. **Total Calculation**  
   The basket total sums the product prices, applies all offers (discounts), then adds the appropriate delivery fee.  
   The total is presented as a formatted dollar string (e.g., `$37.85`).

---

## Assumptions

- Prices are stored and calculated in **cents as integers** to avoid floating point inaccuracies.
- The product catalogue is static and loaded at basket initialization.
- Delivery rules are threshold-based and ordered from highest to lowest thresholds.
- Offers are extensible via a strategy pattern; currently, only one offer is implemented.
- Basket totals are always positive or zero; no negative totals expected.
- No concurrency or persistence: this is a simple in-memory proof of concept.
- No user interface or web framework; interaction is through the command line or tests.
- The system assumes product codes passed to `add` exist in the catalogue; otherwise, it raises an error.

---

## Running the Project

- Ensure Ruby is installed (tested on Ruby 3.0.2).
- Run `ruby main.rb` to see example basket totals.
- Run tests with `ruby test/basket_test.rb`.

---

## Code Structure

- `lib/models` - Product and Basket classes  
- `lib/catalogue.rb` - Product catalogue class  
- `lib/pricing` - Delivery rule classes  
- `lib/offers` - Offer strategy classes  
- `test` - Minitest test files  

---

*This project is a coding exercise for demonstrating Ruby object design and pricing logic.*
