/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tungvs.controllers;

import java.io.IOException;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import tungvs.daos.ProductDAO;
import tungvs.dtos.ProductDTO;

/**
 *
 * @author USER
 */
@WebServlet(name = "SearchUserController", urlPatterns = {"/SearchUserController"})
public class SearchUserController extends HttpServlet {

    private static final String SUCCESS = "home.jsp";
    private static final String ERROR = "invalid.jsp";

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
        String url = SUCCESS;
        try {
            String search = request.getParameter("txtSearch");
            String category = request.getParameter("cbCategory");
            String strFrom = request.getParameter("txtFrom");
            int from=0;
            if(!"".equals(strFrom)){
                from=Integer.valueOf(strFrom);
            }
            ProductDAO dao = new ProductDAO();
            HttpSession session = request.getSession();
            if ("All".equals(category) || "".equals(category)) {
                if ("".equals(request.getParameter("txtTo"))) {
                    if (from < 0) {
                        request.setAttribute("LESS_THAN_ZERO", "[From] must > 0");
                    } else {
                        List<ProductDTO> list = dao.searchUserAllCategory(search, from);
                        if (!list.isEmpty()) {
                            Collections.sort(list, new Comparator<ProductDTO>() {
                                @Override
                                public int compare(ProductDTO o1, ProductDTO o2) {
                                    return o2.getCreateDate().compareTo(o1.getCreateDate());
                                }
                            });
                            session.setAttribute("SIZE", list.size());
                            session.setAttribute("LIST", list);
                            session.setAttribute("CUR_PAGE", 1);
                            url = SUCCESS;
                        } else {
                            session.removeAttribute("LIST");
                        }
                    }
                } else {
                    int to = Integer.valueOf(request.getParameter("txtTo"));
                    if (from < 0 || to < 0) {
                        request.setAttribute("LESS_THAN_ZERO", "[From] and [To] must > 0");
                    } else {
                        if (from > to) {
                            request.setAttribute("LESS_THAN_ZERO", "[From] must <= [To]");
                        } else {
                            List<ProductDTO> list = dao.searchUserAllCategory(search, from, to);
                            if (!list.isEmpty()) {
                                Collections.sort(list, new Comparator<ProductDTO>() {
                                    @Override
                                    public int compare(ProductDTO o1, ProductDTO o2) {
                                        return o2.getCreateDate().compareTo(o1.getCreateDate());
                                    }
                                });
                                session.setAttribute("SIZE", list.size());
                                session.setAttribute("LIST", list);
                                session.setAttribute("CUR_PAGE", 1);
                                url = SUCCESS;
                            } else {
                                session.removeAttribute("LIST");
                            }
                        }

                    }
                }
            } else {
                if ("".equals(request.getParameter("txtTo"))) {
                    if (from < 0) {
                        request.setAttribute("LESS_THAN_ZERO", "[From] must > 0");
                    } else {
                        List<ProductDTO> list = dao.searchUser(search, from, category);
                        if (!list.isEmpty()) {
                            Collections.sort(list, new Comparator<ProductDTO>() {
                                @Override
                                public int compare(ProductDTO o1, ProductDTO o2) {
                                    return o2.getCreateDate().compareTo(o1.getCreateDate());
                                }
                            });
                            session.setAttribute("SIZE", list.size());
                            session.setAttribute("LIST", list);
                            session.setAttribute("CUR_PAGE", 1);
                            url = SUCCESS;
                        } else {
                            session.removeAttribute("LIST");
                        }
                    }
                } else {
                    int to = Integer.valueOf(request.getParameter("txtTo"));
                    if (from < 0 || to < 0) {
                        request.setAttribute("LESS_THAN_ZERO", "[From] and [To] must > 0");
                    } else {
                        if (from > to) {
                            request.setAttribute("LESS_THAN_ZERO", "[From] must <= [To]");
                        } else {
                            List<ProductDTO> list = dao.searchUser(search, from, to, category);
                            if (!list.isEmpty()) {
                                Collections.sort(list, new Comparator<ProductDTO>() {
                                    @Override
                                    public int compare(ProductDTO o1, ProductDTO o2) {
                                        return o2.getCreateDate().compareTo(o1.getCreateDate());
                                    }
                                });
                                session.setAttribute("SIZE", list.size());
                                session.setAttribute("LIST", list);
                                session.setAttribute("CUR_PAGE", 1);
                                url = SUCCESS;
                            } else {
                                session.removeAttribute("LIST");
                            }
                        }

                    }
                }
            }
        } catch (Exception e) {
        } finally {
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
