/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import java.sql.ResultSet;

/**
 *
 * @author longnguyen
 */
public class Files {
    private Connection connect;

    public Files() {
        this.connect = Connector.getConnection();
    }
    
    public boolean store(String fileName, long fileSize, int userId) {
        String sql = "INSERT INTO files("
            + "file_name, size, time_upload, user_id, created_at, updated_at)"
            + " VALUES(?,?,?,?,?,?)";
        PreparedStatement ps;
        Timestamp now = new Timestamp(System.currentTimeMillis());
        try {
            ps = this.connect.prepareStatement(sql);
            ps.setString(1, fileName);
            ps.setLong(2, fileSize);
            ps.setTimestamp(3, now);
            ps.setInt(4, userId);
            ps.setTimestamp(5, now);
            ps.setTimestamp(6, now);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("System error!");
            return false;
        }
    }
    
    public ResultSet countFile(String fileName) {
        String sql = "SELECT * FROM files WHERE file_name LIKE '" + fileName + "%'";
        PreparedStatement ps;
        try {
            ps = this.connect.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            return rs;
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("System error!");
            return null;
        }
    }
}
