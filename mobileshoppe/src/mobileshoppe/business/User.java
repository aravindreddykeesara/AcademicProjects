package mobileshoppe.business;

import java.io.Serializable;

/**
 *  Aravind Reddy Keesara uncc id# 800976233
 */

public class User implements Serializable {

    private String email;
    private String firstName;
    private String lastName;
    private String password;
    private String  salt;

    public User() {
        email = "";
        firstName = "";
        lastName = "";
        password = "";
        salt = "";
    }

	public User(String email, String firstName, String lastName, String password, String salt) {
		super();
		this.email = email;
		this.firstName = firstName;
		this.lastName = lastName;
		this.password = password;
		this.salt = salt;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getSalt() {
		return salt;
	}

	public void setSalt(String salt) {
		this.salt = salt;
	}

	@Override
	public String toString() {
		return "User [email=" + email + ", firstName=" + firstName + ", lastName=" + lastName + ", password=" + password
				+ ", salt=" + salt + "]";
	}
	
	
    
}