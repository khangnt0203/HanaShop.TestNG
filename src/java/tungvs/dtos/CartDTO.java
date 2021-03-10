/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tungvs.dtos;

import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author USER
 */
public class CartDTO {
    private Map<String,ProductDTO> cart;
    private float totalPrice;
    public CartDTO() {
        totalPrice=0;
    }

    public CartDTO(Map<String, ProductDTO> cart) {
        this.cart = cart;
    }

    public Map<String, ProductDTO> getCart() {
        return cart;
    }

    public float getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(float totalPrice) {
        this.totalPrice = totalPrice;
    }
    
    public void setCart(Map<String, ProductDTO> cart) {
        this.cart = cart;
    }
    public void addCart(ProductDTO product){
        if(cart==null){
            cart=new HashMap<>();
        }
        if(cart.containsKey(product.getProId())){
            product.setQuantity(this.cart.get(product.getProId()).getQuantity()+1);
        }
        product.setTotal(product.getPrice()*product.getQuantity());
        cart.put(product.getProId(), product);
        totalPrice=0;
        for (ProductDTO pro : cart.values()) {
            totalPrice= totalPrice + pro.getTotal();
        }
    }
}
