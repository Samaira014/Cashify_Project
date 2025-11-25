package com.cashify.servlet_cashify_project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import com.cashify.servlet_cashify_project.connection.CashifyConnection;
import com.cashify.servlet_cashify_project.dto.Product;

public class ProductDao {
	private Connection connection = CashifyConnection.getCashifyConnection();

	// Add Product
	public boolean addProduct(Product p) {
		boolean flag = false;
		try {
			String sql = "INSERT INTO product (seller_id, productName, brand, category, model, price, color, ram, conditions, quantity, descriptions, image, discounted_price, rejection_msg, rating, verified, joinedDateTime) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement ps = connection.prepareStatement(sql);

			ps.setInt(1, p.getSellerId());
			ps.setString(2, p.getProductName());
			ps.setString(3, p.getBrand());
			ps.setString(4, p.getCategory());
			ps.setString(5, p.getModel());
			ps.setDouble(6, p.getPrice());
			ps.setString(7, p.getColor());
			ps.setInt(8, p.getRam());
			ps.setString(9, p.getCondition());
			ps.setInt(10, p.getQuantity());
			ps.setString(11, p.getDescription());
			ps.setBytes(12, p.getImage());
			ps.setDouble(13, p.getDiscountedPrice());
			ps.setString(14, p.getRejection_msg());
			ps.setDouble(15, p.getRating());
			ps.setBoolean(16, false);
			ps.setTimestamp(17, Timestamp.valueOf(LocalDateTime.now()));

			int i = ps.executeUpdate();
			if (i > 0) {
				flag = true;
				System.out.println("✅ Product added successfully for Seller ID: " + p.getSellerId());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	// Get all products by seller
	public List<Product> getProductsBySellerId(int sellerId) {
		List<Product> products = new ArrayList<>();
		try {
			String sql = "SELECT * FROM product WHERE seller_id=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, sellerId);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setSellerId(rs.getInt("seller_id"));
				p.setProductName(rs.getString("productName"));
				p.setBrand(rs.getString("brand"));
				p.setCategory(rs.getString("category"));
				p.setModel(rs.getString("model"));
				p.setPrice(rs.getDouble("price"));
				p.setColor(rs.getString("color"));
				p.setRam(rs.getInt("ram"));
				p.setCondition(rs.getString("conditions"));
				p.setQuantity(rs.getInt("quantity"));
				p.setDescription(rs.getString("descriptions"));
				p.setImage(rs.getBytes("image"));
				p.setDiscountedPrice(rs.getObject("discounted_price") != null ? rs.getDouble("discounted_price") : 0.0);
				p.setRejection_msg(rs.getString("rejection_msg"));
				p.setRating(rs.getDouble("rating"));
				p.setVerified(rs.getBoolean("verified"));
				p.setJoinedDateTime(rs.getTimestamp("joinedDateTime"));
				products.add(p);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return products;
	}

	// Get all products (for Admin)
	public List<Product> getAllProducts(String sort) {
	    List<Product> list = new ArrayList<>();
	    String sql = "SELECT * FROM product WHERE verified = true";

	    if ("price_asc".equals(sort))
	        sql += " ORDER BY COALESCE(discounted_price, price) ASC";
	    else if ("price_desc".equals(sort))
	        sql += " ORDER BY COALESCE(discounted_price, price) DESC";
	    else
	        sql += " ORDER BY joinedDateTime DESC";

	    try (PreparedStatement ps = connection.prepareStatement(sql);
	         ResultSet rs = ps.executeQuery()) {

	        while (rs.next()) {
	            Product p = new Product();
	            p.setId(rs.getInt("id"));
	            p.setSellerId(rs.getInt("seller_id"));
	            p.setProductName(rs.getString("productName"));
	            p.setBrand(rs.getString("brand"));
	            p.setCategory(rs.getString("category"));
	            p.setModel(rs.getString("model"));
	            p.setPrice(rs.getDouble("price"));
	            p.setColor(rs.getString("color"));
	            p.setRam(rs.getInt("ram"));
	            p.setCondition(rs.getString("conditions"));
	            p.setQuantity(rs.getInt("quantity"));
	            p.setDescription(rs.getString("descriptions"));
	            p.setImage(rs.getBytes("image"));
	            p.setDiscountedPrice(rs.getObject("discounted_price") != null 
	                ? rs.getDouble("discounted_price") : 0.0);
	            p.setRating(rs.getDouble("rating"));
	            p.setVerified(rs.getBoolean("verified"));
	            p.setJoinedDateTime(rs.getTimestamp("joinedDateTime"));
	            list.add(p);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list;
	}


	// Update existing product
	public boolean updateProduct(Product p) {
		boolean flag = false;
		try {
			String sql = "UPDATE product SET productName=?, brand=?, category=?, model=?, price=?, color=?, ram=?, conditions=?, quantity=?, descriptions=?, image=?, discounted_price=?, rejection_msg=?, rating=?, verified=? WHERE id=?";
			PreparedStatement ps = connection.prepareStatement(sql);

			ps.setString(1, p.getProductName());
			ps.setString(2, p.getBrand());
			ps.setString(3, p.getCategory());
			ps.setString(4, p.getModel());
			ps.setDouble(5, p.getPrice());
			ps.setString(6, p.getColor());
			ps.setString(7, p.getCondition());
			ps.setInt(8, p.getQuantity());
			ps.setString(9, p.getDescription());
			ps.setBytes(10, p.getImage());
			ps.setDouble(11, p.getDiscountedPrice());
			ps.setString(12, p.getRejection_msg());
			ps.setDouble(13, p.getRating());
			ps.setBoolean(14, p.isVerified());
			ps.setInt(15, p.getId());

			int i = ps.executeUpdate();
			if (i > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	// Delete product by ID
	public boolean deleteProduct(int id) {
		boolean flag = false;
		try {
			String sql = "DELETE FROM product WHERE id=?";
			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, id);
			int i = ps.executeUpdate();
			if (i > 0)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	public boolean updateDiscountedPrice(int Id, double discountedPrice) {
		String sql = "UPDATE product SET discounted_price=? WHERE id=?";
		try (PreparedStatement ps = connection.prepareStatement(sql)) {
			ps.setDouble(1, discountedPrice);
			ps.setInt(2, Id);
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// Verify a product
	public boolean verifyProduct(int Id) {
		String sql = "UPDATE product SET verified=true, rejection_msg=NULL WHERE id=?";
		try (PreparedStatement ps = connection.prepareStatement(sql)) {
			ps.setInt(1, Id);
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// Reject a product with reason
	public boolean rejectProduct(int Id, String reason) {
		String sql = "UPDATE product SET verified=false, rejection_msg=? WHERE id=?";
		try (PreparedStatement ps = connection.prepareStatement(sql)) {
			ps.setString(1, reason);
			ps.setInt(2, Id);
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	

	// Get unique brand names
	public List<String> getAllBrands() {
		List<String> brands = new ArrayList<>();
		try (PreparedStatement ps = connection
				.prepareStatement("SELECT DISTINCT brand FROM product WHERE verified=true");
				ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				brands.add(rs.getString("brand"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return brands;
	}

	// Get unique categories
	public List<String> getAllCategories() {
		List<String> categories = new ArrayList<>();
		try (PreparedStatement ps = connection
				.prepareStatement("SELECT DISTINCT category FROM product WHERE verified=true");
				ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				categories.add(rs.getString("category"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return categories;
	}

//✅ Get Product Image by ID
	public byte[] getImage(int productId) {
		byte[] imageData = null;
		String sql = "SELECT image FROM product WHERE id = ?";
		try (PreparedStatement ps = connection.prepareStatement(sql)) {
			ps.setInt(1, productId);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				imageData = rs.getBytes("image");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return imageData;
	}

	// Get unique RAM values
	public List<Integer> getAllRams() {
		List<Integer> rams = new ArrayList<>();
		try (PreparedStatement ps = connection.prepareStatement("SELECT DISTINCT ram FROM product WHERE verified=true");
				ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				rams.add(rs.getInt("ram"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rams;
	}

	// Get unique Colors
	public List<String> getAllColors() {
		List<String> colors = new ArrayList<>();
		try (PreparedStatement ps = connection
				.prepareStatement("SELECT DISTINCT color FROM product WHERE verified=true");
				ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				colors.add(rs.getString("color"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return colors;
	}

	public List<Product> getFilteredProducts(String brand, String category, String sort, String q, List<Integer> rams,
			List<String> colors) {
		List<Product> list = new ArrayList<>();
		StringBuilder sql = new StringBuilder("SELECT * FROM product WHERE verified = true");

		if (brand != null && !brand.isEmpty())
			sql.append(" AND brand = ?");
		if (category != null && !category.isEmpty())
			sql.append(" AND category = ?");
		if (rams != null && !rams.isEmpty())
			sql.append(" AND ram IN (" + rams.stream().map(i -> "?").collect(Collectors.joining(",")) + ")");
		if (colors != null && !colors.isEmpty())
			sql.append(" AND color IN (" + colors.stream().map(c -> "?").collect(Collectors.joining(",")) + ")");
		if (q != null && !q.isEmpty())
			sql.append(" AND productName LIKE ?");

		if ("price_asc".equals(sort))
			sql.append(" ORDER BY COALESCE(discounted_price, price) ASC");
		else if ("price_desc".equals(sort))
			sql.append(" ORDER BY COALESCE(discounted_price, price) DESC");
		else
			sql.append(" ORDER BY joinedDateTime DESC");

		try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
			int index = 1;
			if (brand != null && !brand.isEmpty())
				ps.setString(index++, brand);
			if (category != null && !category.isEmpty())
				ps.setString(index++, category);
			if (rams != null)
				for (Integer r : rams)
					ps.setInt(index++, r);
			if (colors != null)
				for (String c : colors)
					ps.setString(index++, c);
			if (q != null && !q.isEmpty())
				ps.setString(index++, "%" + q + "%");

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setSellerId(rs.getInt("seller_id"));
				p.setProductName(rs.getString("productName"));
				p.setBrand(rs.getString("brand"));
				p.setCategory(rs.getString("category"));
				p.setModel(rs.getString("model"));
				p.setPrice(rs.getDouble("price"));
				p.setColor(rs.getString("color"));
				p.setRam(rs.getInt("ram"));
				p.setCondition(rs.getString("conditions"));
				p.setQuantity(rs.getInt("quantity"));
				p.setDescription(rs.getString("descriptions"));
				p.setDiscountedPrice(
						rs.getObject("discounted_price") != null ? rs.getDouble("discounted_price") : null);
				p.setRating(rs.getDouble("rating"));
				p.setVerified(rs.getBoolean("verified"));
				p.setJoinedDateTime(rs.getTimestamp("joinedDateTime"));
				list.add(p);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// ✅ Fetch product details by ID
	public Product getProductById(int id) {
		Product product = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			String query = "SELECT * FROM product WHERE id = ?";
			ps = connection.prepareStatement(query);
			ps.setInt(1, id);
			rs = ps.executeQuery();

			if (rs.next()) {
				product = new Product();
				product.setId(rs.getInt("id"));
				product.setProductName(rs.getString("productName"));
				product.setDescription(rs.getString("descriptions"));
				product.setBrand(rs.getString("brand"));
				product.setPrice(rs.getDouble("price"));
				product.setImage(rs.getBytes("image"));
				product.setCategory(rs.getString("category"));
				product.setSellerId(rs.getInt("seller_id"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (Exception ignored) {
			}
			try {
				if (ps != null)
					ps.close();
			} catch (Exception ignored) {
			}
		}

		return product;
	}

	// Count products by status
	public int countProductsByStatus(String status) {
		String sql = "";
		switch (status) {
		case "pending":
			sql = "SELECT COUNT(*) FROM product WHERE verified=false AND rejection_msg IS NULL";
			break;
		case "approved":
			sql = "SELECT COUNT(*) FROM product WHERE verified=true";
			break;
		case "rejected":
			sql = "SELECT COUNT(*) FROM product WHERE rejection_msg IS NOT NULL";
			break;
		case "sold":
			sql = "SELECT COUNT(*) FROM product";
					// WHERE sold=true";
			break;
		default:
			return 0;
		}
		try (Statement st = connection.createStatement(); ResultSet rs = st.executeQuery(sql)) {
			if (rs.next())
				return rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	// Get products by status
	public List<Product> getProductsByStatus(String status) {
		
		List<Product> list = new ArrayList<>();
		String sql = "";
		switch (status) {
		case "pending":
			sql = "SELECT * FROM product WHERE verified=false AND rejection_msg IS NULL ORDER BY joinedDateTime DESC";
			break;
		case "approved":
			sql = "SELECT * FROM product WHERE verified=true ORDER BY joinedDateTime DESC";
			break;
		case "rejected":
			sql = "SELECT * FROM product WHERE rejection_msg IS NOT NULL ORDER BY joinedDateTime DESC";
			break;
		case "sold":
			sql = "SELECT * FROM product";
//                WHERE sold=true ORDER BY joinedDateTime DESC";
			break;
		}

		try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				Product p = new Product();
				p.setId(rs.getInt("id"));
				p.setSellerId(rs.getInt("seller_id"));
				p.setProductName(rs.getString("productName"));
				p.setBrand(rs.getString("brand"));
				p.setCategory(rs.getString("category"));
				p.setPrice(rs.getDouble("price"));
				p.setDiscountedPrice(
				rs.getObject("discounted_price") != null ? rs.getDouble("discounted_price") : null);
				p.setVerified(rs.getBoolean("verified"));
				p.setRejection_msg(rs.getString("rejection_msg"));
				p.setJoinedDateTime(rs.getTimestamp("joinedDateTime"));
				p.setImage(rs.getBytes("image"));
				list.add(p);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

//	// ✅ NEW: Get Pending Products with Seller Details
//	public List<Product> getPendingProductsWithSellerDetails() {
//
//		List<Product> list = new ArrayList<>();
//
//		String sql = """
//				     SELECT p.*, s.name, s.email, s.phone
//				     FROM product p
//				    JOIN seller s ON p.seller_id = s.id
//				    WHERE p.verified = false AND p.rejection_msg IS NULL
//				    ORDER BY p.joinedDateTime DESC
//				""";
//		try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
//			while (rs.next()) {
//				Product p = new Product();
//				p.setId(rs.getInt("id"));
//				p.setSellerId(rs.getInt("seller_id"));
//				p.setProductName(rs.getString("productName"));
//				p.setBrand(rs.getString("brand"));
//				p.setCategory(rs.getString("category"));
//				p.setModel(rs.getString("model"));
//				p.setPrice(rs.getDouble("price"));
//				p.setColor(rs.getString("color"));
//				p.setRam(rs.getInt("ram"));
//				p.setCondition(rs.getString("conditions"));
//				p.setQuantity(rs.getInt("quantity"));
//				p.setDescription(rs.getString("descriptions"));
//				p.setDiscountedPrice(
//						rs.getObject("discounted_price") != null ? rs.getDouble("discounted_price") : null);
//				p.setRating(rs.getDouble("rating"));
//				p.setVerified(rs.getBoolean("verified"));
//				p.setJoinedDateTime(rs.getTimestamp("joinedDateTime"));
//
//				list.add(p);
//			}
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//
//		return list;
//	}

	// ✅ NEW: Unified update method for Admin approval/rejection/discount
	public boolean updateProductStatus(int productId, boolean approved, String rejectionMsg, Double discountedPrice) {
		String sql = "UPDATE product SET verified=?, rejection_msg=?, discounted_price=? WHERE id=?";
		try (PreparedStatement ps = connection.prepareStatement(sql)) {
			ps.setBoolean(1, approved);
			ps.setString(2, rejectionMsg);
			if (discountedPrice != null)
				ps.setDouble(3, discountedPrice);
			else
				ps.setNull(3, java.sql.Types.DOUBLE);
			ps.setInt(4, productId);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	// ✅ NEW: Mark Product as Sold
	public boolean markProductAsSold(int productId) {
		String sql = "UPDATE product SET sold = true WHERE id = ?";
		try (PreparedStatement ps = connection.prepareStatement(sql)) {
			ps.setInt(1, productId);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

}
