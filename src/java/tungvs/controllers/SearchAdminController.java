/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tungvs.controllers;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tungvs.daos.ProductDAO;
import tungvs.dtos.ProductDTO;

/**
 *
 * @author USER
 */
@WebServlet(name = "SearchAdminController", urlPatterns = {"/SearchAdminController"})
public class SearchAdminController extends HttpServlet {
    private static final String SUCCESS="admin.jsp";
    private static final String ERROR="admin.jsp";
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url=ERROR;
        try {
            String search=request.getParameter("txtSearch");
            String categoryName=request.getParameter("cbCategory");
            String status=request.getParameter("cbStatus");
            ProductDAO dao=new ProductDAO();
            if("All".equals(categoryName)){//all cate
                if("All".equals(status)){//all
                    List<ProductDTO> list=dao.searchList(search);
                    if(!list.isEmpty()){
                        request.setAttribute("SEARCH_LIST", list);
                        url=SUCCESS;
                    }
                }else{//status
                    if("Available".equals(status)){
                        status="true";
                    }else{
                        status="false";
                    }
                    List<ProductDTO> list=dao.searchAdminStatus(search, status);
                    if(!list.isEmpty()){
                        request.setAttribute("SEARCH_LIST", list);
                        url=SUCCESS;
                    }
                }
            }else{//cate selected
                if("All".equals(status)){//just cate
                    List<ProductDTO> list=dao.searchAdminCategory(search, categoryName);
                    if(!list.isEmpty()){
                        request.setAttribute("SEARCH_LIST", list);
                        url=SUCCESS;
                    }
                }else{//cate and status
                    if("Available".equals(status)){
                        status="true";
                    }else{
                        status="false";
                    }
                    List<ProductDTO> list=dao.searchAdminAllCondition(search, categoryName, status);
                    if(!list.isEmpty()){
                        request.setAttribute("SEARCH_LIST", list);
                        url=SUCCESS;
                    }
                }
            }                        
        } catch (Exception e) {
        }finally{
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
