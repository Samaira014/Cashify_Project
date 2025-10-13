package com.cashify.servlet_cashify_project.controller;

import com.cashify.servlet_cashify_project.dao.ProductDao;
import com.cashify.servlet_cashify_project.dto.Product;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/products")
public class ProductListingController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    ProductDao dao = new ProductDao();

	    String brand = request.getParameter("brand");
	    String category = request.getParameter("category");
	    String sort = request.getParameter("sort");
	    String search = request.getParameter("q");
	    
	    // Multiple RAMs and Colors (checkboxes)
	    String[] ramParams = request.getParameterValues("ram");
	    String[] colorParams = request.getParameterValues("color");
	    
	    List<Integer> rams = ramParams != null ? Arrays.stream(ramParams).map(Integer::parseInt).collect(Collectors.toList()) : null;
	    List<String> colors = colorParams != null ? Arrays.asList(colorParams) : null;

	    List<Product> products = dao.getFilteredProducts(brand, category, sort, search, rams, colors);
	    List<String> brands = dao.getAllBrands();
	    List<String> categories = dao.getAllCategories();
	    List<Integer> ramOptions = dao.getAllRams();
	    List<String> colorOptions = dao.getAllColors();

	    request.setAttribute("products", products);
	    request.setAttribute("brands", brands);
	    request.setAttribute("categories", categories);
	    request.setAttribute("ramOptions", ramOptions);
	    request.setAttribute("colorOptions", colorOptions);
	    request.setAttribute("selectedBrand", brand);
	    request.setAttribute("selectedCategory", category);
	    request.setAttribute("selectedSort", sort);
	    request.setAttribute("searchQuery", search);
	    request.setAttribute("selectedRams", rams);
	    request.setAttribute("selectedColors", colors);

	    request.getRequestDispatcher("phone-listing.jsp").forward(request, response);
	}
}