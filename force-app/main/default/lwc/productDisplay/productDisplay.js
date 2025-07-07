import { LightningElement, api } from 'lwc';

export default class ProductDisplay extends LightningElement {
    // Private property to store the price
    _price;

    // Private property to store the discount percentage
    _discountPercentage;

    // Public getter and setter for price
    get price() {
        return this._price;
    }

    set price(value) {
        // Validate input: Ensure price is a positive number
        const parsedValue = parseFloat(value);
        if (isNaN(parsedValue) || parsedValue < 0) {
            this._price = 0; // Default to 0 for invalid input
            this.dispatchEvent(
                new CustomEvent('error', { detail: 'Price must be a positive number' })
            );
        } else {
            this._price = parsedValue;
        }
    }

    // Public getter and setter for discount percentage
    get discountPercentage() {
        return this._discountPercentage;
    }

    set discountPercentage(value) {
        // Validate input: Ensure discount is between 0 and 100
        const parsedValue = parseFloat(value);
        if (isNaN(parsedValue) || parsedValue < 0 || parsedValue > 100) {
            this._discountPercentage = 0; // Default to 0 for invalid input
            this.dispatchEvent(
                new CustomEvent('error', { detail: 'Discount percentage must be between 0 and 100' })
            );
        } else {
            this._discountPercentage = parsedValue;
        }
    }

    // Getter to compute the discounted price
    get discountedPrice() {
        if (!this._price || !this._discountPercentage) {
            return this._price || 0;
        }
        const discount = this._price * (this._discountPercentage / 100);
        return (this._price - discount).toFixed(2); // Return formatted to 2 decimal places
    }

    // Getter to determine if the discount is considered "high"
    get isHighDiscount() {
        return this._discountPercentage >= 50;
    }

    // Method to reset price and discount
    resetValues() {
        this._price = 0;
        this._discountPercentage = 0;
        this.dispatchEvent(new CustomEvent('reset', { detail: 'Values reset to default' }));
    }

    // Handle input change for price
    handlePriceChange(event) {
        this.price = event.target.value;
    }

    // Handle input change for discount
    handleDiscountChange(event) {
        this.discountPercentage = event.target.value;
    }
}