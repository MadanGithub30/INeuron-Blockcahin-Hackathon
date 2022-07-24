//SPDX-License-Identifier:MIT

pragma solidity >=0.5.0 <0.9.0;

contract HackathonEcommereceAz{
    
    struct Product{ // creating Product of type struct.
      string title;
      string desc;
      address payable seller;
      uint productId;
      uint price;
      address buyer;
      bool delivered;
    }     
    uint counter = 1;
    Product[] public products;// creating an array to store all the info of the Product for the particular id of variable products.
    address payable public manager;

    constructor(){
        manager = payable(msg.sender);//Initiallizing the manager with the manager address.
    }

    function registerProduct(string memory _title,string memory _desc,uint _price) public  {
        require(_price>0,"Price should be greater than zero");
        Product memory tempProduct; //creating tempProduct variable of type Product.
        tempProduct.title = _title;
        tempProduct.desc = _desc;
        tempProduct.price = _price * 10**18;// OR 10**18.
        tempProduct.seller = payable(msg.sender);
        tempProduct.productId = counter;
        products.push(tempProduct);// Pushing all the elements to array products.
        counter++;

    } 

    function buy(uint _productId) payable public {
        require(products[_productId-1].price==msg.value,"Please pay the exact price");//Here checking The seller registered price for the product is equal to price paying by the buyer.
        require(products[_productId-1].seller!=msg.sender,"Seller can't be the buyer");
        products[_productId-1].buyer=msg.sender;

    }

    function delivery(uint _productId) public {
        require(products[_productId-1].buyer==msg.sender,"Only buyer can confirm");
        products[_productId-1].delivered = true;
        
    }
}