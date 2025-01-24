const item_price = () => {

const priceInput = document.getElementById("item-price");
const addTaxDom = document.getElementById("add-tax-price");
const profitDom = document.getElementById("profit");

priceInput.addEventListener("input", () => {
  const price = parseInt(priceInput.value);
  if (isNaN(price) || price <= 0) {
    addTaxDom.innerHTML = "0";
    profitDom.innerHTML = "0";
    return;
  }
  const tax = Math.floor(price * 0.1);
  const profit = Math.floor(price - tax);
  addTaxDom.innerHTML = tax;
  profitDom.innerHTML = profit;
  });
};

window.addEventListener("turbo:load",item_price );
window.addEventListener("turbo:render",item_price );
