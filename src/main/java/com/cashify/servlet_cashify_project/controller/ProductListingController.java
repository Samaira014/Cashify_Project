package com.cashify.servlet_cashify_project.controller;




import com.cashify.servlet_cashify_project.dao.ProductDao;
import com.cashify.servlet_cashify_project.dto.Product;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/products")
public class ProductListingController extends HttpServlet {
	private ProductDao productDao = new ProductDao();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String brand = request.getParameter("brand");
        String category = request.getParameter("category");
        String sort = request.getParameter("sort");
        String q = request.getParameter("q");

        List<Product> products = productDao.getFilteredProducts(brand, category, sort, q);
        List<String> brands = productDao.getAllBrands();
        List<String> categories = productDao.getAllCategories();

        request.setAttribute("products", products);
        request.setAttribute("brands", brands);
        request.setAttribute("categories", categories);

        request.getRequestDispatcher("user-products.jsp").forward(request, response);
    }
}