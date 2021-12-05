function count (){
  const itemPrice  = document.getElementById("item-price");
  itemPrice.addEventListener("keyup", () => {
    const priceValue = itemPrice.value;
    const addTaxPrice = document.getElementById("add-tax-price");
    const tax = Math.floor(priceValue * 0.1);
    addTaxPrice.innerHTML = tax;
    const profit = document.getElementById("profit");
    profit.innerHTML = priceValue - tax;
  });
};

window.addEventListener('load', count);
