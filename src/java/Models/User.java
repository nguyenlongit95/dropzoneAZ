/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author longnguyen
 */
public class User {
    private Connection connect;

    public User() {
        this.connect = Connector.getConnection();
    }
    
    public boolean store(String email, String password) {
        String sql = "INSERT INTO users("
            + "email, password, total_file, total_size, "
            + "total_download, last_login, purchase_status)"
            + " VALUES(?,?,?,?,?,?,?)";
        PreparedStatement ps;
        try {
            ps = connect.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ps.setInt(3, 0);
            ps.setInt(4, 0);
            ps.setInt(5, 0);
            ps.setString(6, "0000-00-00 00:00:00");
            ps.setInt(7, 0);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("System error!");
            return false;
        }
    }
    
    public ResultSet find(String email) {
        String sql = "SELECT * FROM users WHERE email = '"+email+"'";
        try {
            PreparedStatement ps = connect.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            return rs;
        } catch (Exception e) {
            System.out.println(e);
            return null;
        }
    }
    
    public ResultSet login(String email, String password) {
        String sql = "SELECT * FROM users WHERE email = '"+email+"' AND password = '"+password+"'";
        try {
            PreparedStatement ps = connect.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            return rs;
        } catch (Exception e) {
            System.out.println(e);
            return null;
        }
    }
    
    public ResultSet findById(int id) {
        String sql = "SELECT * FROM users WHERE id = '"+id+"'";
        try {
            PreparedStatement ps = connect.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            return rs;
        } catch (Exception e) {
            System.out.println(e);
            return null;
        }
    }
    
//    public ResultSet list() {
//        String sql = "SELECT * FROM users ORDER BY id DESC";
//        try {
//            PreparedStatement ps = connect.prepareStatement(sql);
//            ResultSet rs = ps.executeQuery();
//            return rs;
//        } catch (Exception e) {
//            System.out.println(e);
//            return null;
//        }
//    }
}
