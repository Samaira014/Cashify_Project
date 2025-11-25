package com.cashify.servlet_cashify_project.controller;

import com.cashify.servlet_cashify_project.dao.ProductDao;
import com.cashify.servlet_cashify_project.dto.Product;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;
import java.util.Arrays;
import java.util.stream.Collectors;

@WebServlet("/products")
public class ProductListingController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ProductDao productDAO = new ProductDao();
        List<Product> products;

        String brand = request.getParameter("brand");
        String category = request.getParameter("category");
        String[] ramValues = request.getParameterValues("ram");
        String[] colorValues = request.getParameterValues("color");
        String sort = request.getParameter("sort");

        System.out.println("Sort applied: " + sort);

        if ((brand == null || brand.equals("all")) &&
                (category == null || category.equals("all")) &&
                (ramValues == null || ramValues.length == 0) &&
                (colorValues == null || colorValues.length == 0)) {

            products = productDAO.getAllProducts(sort);
            //System.out.println("Loading ALL products...");

        } else {
            products = productDAO.getFilteredProducts(
                    brand,
                    category,
                    sort,
                    null,
                    ramValues != null ? Arrays.stream(ramValues)
                            .map(Integer::parseInt).collect(Collectors.toList()) : null,
                    colorValues != null ? Arrays.asList(colorValues) : null
            );
            //System.out.println("Loading FILTERED products...");
        }

        //System.out.println("Products Loaded: " + products.size());

        request.setAttribute("products", products);
        request.getRequestDispatcher("phone-listing.jsp").forward(request, response);
    }
}
