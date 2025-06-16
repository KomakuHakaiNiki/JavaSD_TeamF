package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DAO {
    // JDBC接続情報（必要に応じて変更）
    private static final String URL = "jdbc:h2:tcp://localhost/~/teamf";
    private static final String USER = "sa";
    private static final String PASSWORD = "";

    // JDBCドライバのロード（静的初期化ブロック）
    static {
        try {
            Class.forName("org.h2.Driver"); // H2の場合
            // MySQLの場合は "com.mysql.cj.jdbc.Driver"
        } catch (ClassNotFoundException e) {
            throw new IllegalStateException("JDBCドライバのロードに失敗しました", e);
        }
    }

    // コネクション取得メソッド
    public Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
