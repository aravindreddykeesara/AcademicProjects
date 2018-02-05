package mobileshoppe.business;

import java.io.Serializable;

public class Cartitems implements Serializable {
	
	String cartProductName;
	String cartProductImageurl;
	String cartProductPrice;
	int  cartId;
	String UserEmail;
	public Cartitems() {
		
		cartProductName = "";
		cartProductImageurl = "";
		cartProductPrice = "";
		cartId = 0;
		UserEmail = "";
		
	}
	public Cartitems(String cartProductName, String cartProductImageurl, String cartProductPrice, int cartId,
			String userEmail) {
		super();
		this.cartProductName = cartProductName;
		this.cartProductImageurl = cartProductImageurl;
		this.cartProductPrice = cartProductPrice;
		this.cartId = cartId;
		UserEmail = userEmail;
	}
	public String getCartProductName() {
		return cartProductName;
	}
	public void setCartProductName(String cartProductName) {
		this.cartProductName = cartProductName;
	}
	public String getCartProductImageurl() {
		return cartProductImageurl;
	}
	public void setCartProductImageurl(String cartProductImageurl) {
		this.cartProductImageurl = cartProductImageurl;
	}
	public String getCartProductPrice() {
		return cartProductPrice;
	}
	public void setCartProductPrice(String cartProductPrice) {
		this.cartProductPrice = cartProductPrice;
	}
	public int getCartId() {
		return cartId;
	}
	public void setCartId(int cartId) {
		this.cartId = cartId;
	}
	public String getUserEmail() {
		return UserEmail;
	}
	public void setUserEmail(String userEmail) {
		UserEmail = userEmail;
	}
	@Override
	public String toString() {
		return "Cartitems [cartProductName=" + cartProductName + ", cartProductImageurl=" + cartProductImageurl
				+ ", cartProductPrice=" + cartProductPrice + ", cartId=" + cartId + ", UserEmail=" + UserEmail + "]";
	}
	
	
	
	
	
}
