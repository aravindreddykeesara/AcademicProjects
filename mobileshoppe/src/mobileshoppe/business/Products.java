package mobileshoppe.business;
import java.io.Serializable;

/**
 *  Aravind Reddy Keesara uncc id# 800976233
 */

public class Products implements Serializable {
	
	private String productImage;
	private int productid;
	private String productname;
	private int quantity;
	private String price ;
	
	
	public Products() {
		
		productImage ="";
		productid = 0;
		productname = "";
		quantity = 0;
		price = "";
		
	}


	public Products(String productImage, int productid, String productname, int quantity, String price) {
		super();
		this.productImage = productImage;
		this.productid = productid;
		this.productname = productname;
		this.quantity = quantity;
		this.price = price;
	}


	public String getProductImage() {
		return productImage;
	}


	public void setProductImage(String productImage) {
		this.productImage = productImage;
	}


	public int getProductid() {
		return productid;
	}


	public void setProductid(int productid) {
		this.productid = productid;
	}


	public String getProductname() {
		return productname;
	}


	public void setProductname(String productname) {
		this.productname = productname;
	}


	public int getQuantity() {
		return quantity;
	}


	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}


	public String getPrice() {
		return price;
	}


	public void setPrice(String price) {
		this.price = price;
	}


	@Override
	public String toString() {
		return "Products [productImage=" + productImage + ", productid=" + productid + ", productname=" + productname
				+ ", quantity=" + quantity + ", price=" + price + "]";
	}
	
	
	
	
	
	

	


}
