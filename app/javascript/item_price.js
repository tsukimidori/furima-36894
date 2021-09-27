function cost(){
  const itemPrice = document.getElementById('item-price');
  const addTaxPrice = document.getElementById('add-tax-price');
  const profit = document.getElementById('profit');

  itemPrice.addEventListener('keyup', () => {
    const inputValue = itemPrice.value;
    addTaxPrice.innerHTML = `${Math.round(inputValue * 0.1)}`;
    profit.innerHTML = `${inputValue - addTaxPrice.innerHTML}`;
  });
};

window.addEventListener('load', cost);