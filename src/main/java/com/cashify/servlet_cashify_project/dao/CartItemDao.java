package com.cashify.servlet_cashify_project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.cashify.servlet_cashify_project.connection.CashifyConnection;
import com.cashify.servlet_cashify_project.dto.Cart;
import com.cashify.servlet_cashify_project.dto.CartItems;

public class CartItemDao {

	Connection connection = CashifyConnection.getCashifyConnection();

	public Cart saveProductIntoCartDao(Cart cart) {

		try {

			String cartInsertQuery = "insert into cart(userid,status) values(?,?)";

			PreparedStatement ps = connection.prepareStatement(cartInsertQuery);

			ps.setInt(1, cart.getUserId());
			ps.setString(2, cart.getStatus());

			return ps.executeUpdate() != 0 ? cart : null;

		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}

	}

	public CartItems saveCartItemsDao(CartItems cartItems) {
		try {

			String cartItemInsertQuery = "insert into cart_items(cartid,productid,quantity,price,date_times) values(?,?,?,?,?)";

			PreparedStatement ps = connection.prepareStatement(cartItemInsertQuery);

			ps.setInt(1, cartItems.getCartid());
			ps.setInt(2, cartItems.getProductid());
			ps.setInt(3, cartItems.getQuantity());
			ps.setDouble(4, cartItems.getPrice());
			ps.setObject(5, cartItems.getDatetimes());

			return ps.executeUpdate() != 0 ? cartItems : null;

		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	public Cart getCartDetails(int userId) {

		String getProductItemFromCartQuery = "select * from cart where userid=?";

		try {
			PreparedStatement ps = connection.prepareStatement(getProductItemFromCartQuery);
			
			ps.setInt(1, userId);
			
			ResultSet resultSet=ps.executeQuery();
			
			if(resultSet.next()) {
				
				Cart cart=new Cart();
				cart.setId(resultSet.getInt("id"));
				cart.setUserId(resultSet.getInt("userid"));
				cart.setStatus(resultSet.getString("status"));
				
				return cart;
			}
			return null;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public List<CartItems> getAllCartItemsDetails() {

		String getProductItemFromCartQuery = "select * from cart_items";

		List<CartItems> cartItems = new ArrayList<CartItems>();
		
		try {
			PreparedStatement ps = connection.prepareStatement(getProductItemFromCartQuery);
			
			ResultSet resultSet=ps.executeQuery();
			
			while(resultSet.next()) {
				
				CartItems cartItem = new CartItems();
				
				cartItem.setItemsid(resultSet.getInt("id"));
				cartItem.setCartid(resultSet.getInt("cartid"));
				cartItem.setPrice(resultSet.getDouble("price"));
				cartItem.setProductid(resultSet.getInt("productid"));
				cartItem.setQuantity(resultSet.getInt("quantity"));
				//cartItem.setDatetimes(resultSet.getObject(""));
				
				
				cartItems.add(cartItem);
			}
			return cartItems;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public boolean updateCartItemsQuantityAndPriceDao(int quantity, double price, int itemsId) {
		
		try {
			String updateQuery = "update cart_items set quantity=?, price=? where id = ?";
			
			PreparedStatement ps = connection.prepareStatement(updateQuery);
			
			ps.setInt(1, quantity);
			ps.setDouble(2, price);
			ps.setInt(3, itemsId);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}